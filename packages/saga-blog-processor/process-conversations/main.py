import os
from datetime import datetime

import boto3
import dotenv
from langchain_openai import ChatOpenAI
from langchain.chains.summarize import load_summarize_chain
from langchain.prompts import PromptTemplate
from langchain.schema import Document


dotenv.load_dotenv()

os.environ["OPENAI_API_KEY"] = os.getenv("OPENAI_API_KEY")
os.environ["LANGCHAIN_TRACING_V2"] = os.getenv("LANGCHAIN_TRACING_V2")
os.environ["LANGCHAIN_API_KEY"] = os.getenv("LANGCHAIN_SMITH_API_KEY")

llm = ChatOpenAI(model='gpt-4o-mini')


def generate_blog_content(conversation, min_chars=8000, max_attempts=3):
    combined_text = ""

    combined_text += f"### タイトル: {conversation['title']}\n"
    combined_text += f"### 冒頭の質問: {conversation['question']}\n"
    for t in conversation['thread']:
        combined_text += f"### {'回答' if t['role'] == 'assistant' else '追加の質問'}: {t['content']}\n\n"

    prompt_template = PromptTemplate(
        input_variables=["text", "current_content", "min_chars"],
        template="""
        重要: この記事は必ず日本語で生成してください。

        以下の会話に基づいて、中級者から上級者向けの技術的なブログ記事を生成または拡張してください。深い技術的な洞察を含みつつ、自然な語り口で読者が新しい知識を得られるような内容にしてください：

        {text}

        すでに生成された記事がこちらですが、さらなる改善が必要です。現在の記事を基に、より深い技術的な洞察や実践的な経験を追加し、自然な流れで読者を引き込むような内容に拡張してください。
        実際のプロジェクト経験から得られた具体的な課題、その解決策、そして学んだ教訓を含め、{min_chars}文字以上になるまで拡張してください：
        {current_content}

        ブログ記事は以下の要素を含め、各部分を技術的な深さを保ちながら自然な流れで繋げてください。ただし、これらの要素を必ずしもこの順序や形式で使用する必要はありません。記事の内容に合わせて、適切なセクションタイトルと構成を選択してください：

        - 読者の興味を引く導入（実際のプロジェクト経験や課題から始める）
        - プロジェクトの技術的背景（業界の課題や既存のソリューションの限界）
        - 実装の詳細と直面した技術的課題（具体的なコード例や設計上の決定を含む）
        - パフォーマンス最適化や拡張性に関する考察
        - セキュリティとプライバシーの考慮事項
        - プロジェクトから得られた技術的な洞察と業界への影響
        - 将来の展望と次のステップ

        記事は以下の点に注意して作成してください：
        - 技術的な正確さを保ちつつ、読者が追体験できるような具体的な例を提供する
        - 業界標準や最新のトレンドを参照しつつ、独自の洞察を加える
        - 技術的な概念を説明する際は、実際のユースケースや応用例を交えて具体化する
        - 直面した課題とその解決策を詳細に説明し、読者が学べるポイントを明確にする
        - コードスニペットを使用する場合は、その部分の重要性や工夫した点を説明する
        - 個人的な経験や感想を適度に交えつつ、客観的な分析も提供する
        - 読者に新しい視点や考え方を提供し、技術的な議論を促す内容を含める

        重要: 必ず{min_chars}文字以上の記事を生成してください。現在の内容が不足している場合は、より深い技術的な分析、実装の詳細、業界への影響などを追加して、指定された文字数に達するまで拡張してください。

        マークダウン形式を使用し、適切な見出し、コードブロック、リンクを含めてください。

        必ず日本語で記事を生成してください。英語や他の言語は使用しないでください。

        ## ブログ記事
        """
    )

    summarize_chain = load_summarize_chain(llm, chain_type="stuff", prompt=prompt_template)
    
    doc = Document(page_content=combined_text)
    
    current_content = ""
    for attempt in range(max_attempts):
        blog_content = summarize_chain.invoke({
            "input_documents": [doc],
            "text": combined_text,
            "current_content": current_content,
            "min_chars": min_chars
        })
        
        char_count = len(blog_content['output_text'])
        if char_count >= min_chars:
            return blog_content['output_text']
        
        print(f"生成された記事が短すぎます（{char_count}文字）。拡張を試みます（試行 {attempt + 1}/{max_attempts}）。")
        current_content = blog_content['output_text']
        min_chars = max(min_chars, min_chars + (min_chars - char_count))  # 目標文字数を調整

    print(f"最大試行回数（{max_attempts}回）に達しました。生成された内容（{char_count}文字）を返します。")
    return current_content


def store_blog_content(bucket_name, key, blog_content):
    s3_client = boto3.client('s3')
    s3_client.put_object(Bucket=bucket_name, Key=key, Body=blog_content)


def lambda_handler(event, context):
    '''
    This lambda will get triggered when the 'Thread Grouper' lambda has finished grouping the conversations
    by threads and uploaded the result to s3. This lambda handles a single thread and stores the generated
    blog post back in s3 at the (generated/user_id/thread_id.md) path.
    '''
    try:
        bucket_name = event['bucket_name']
        key = event['key']
        user_id = key.split('/')[2]
        threads = event['result']
        timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
        for thread in threads:
            blog_content = generate_blog_content(thread)
            print("BLOG CONTENT: ", blog_content)
            key=f"generated/user/{user_id}/{timestamp}.md"
            print("STORING BLOG CONTENT TO: ", key)
            store_blog_content(bucket_name, key, blog_content)
    except Exception as e:
        print(f"Error: {str(e)}")
        raise
