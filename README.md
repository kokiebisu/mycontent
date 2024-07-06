# mycontent

## なぜこれがあったら便利か

1. エンジニアの情報発信は自分の市場価値を高める上で有益
2. 発信すると同時に自分にもその技術の情報が届く
3. ブログを一から作る手間がなくなる

## 機能面

1. ブログプラットフォーム（Zenn, Notion, Qiita など）にのせる
2. 事前に選択した興味ある分野についてのコンテンツを自動生成
3. ブログを発信するあたってまずは自分にブログの内容が含まれたメールが自分に届く
4. 編集したければ「編集する」のボタンをクリック。そのまま発信したければ「発信する」をクリック

## 流れ

1. ログイン
2. 自分が発信したい技術を選択（１つだがいつでも変更可能。次の発信の際に適応される）
3. 発信時間の指定（いつでも変更可能。次の発信の際に適応される）

## アーキテクチャ

###　フロントエンド

- React
- Next.js
- TypeScript
- Tailwind CSS
- Storybook
- GraphQL

### バックエンド

- Go
- GQLGen
- PostgreSQL
- GRPC
- Express (Gateway)
- Docker

#### User Service

##### API

- getUser
- updatePassword
- updateInterest
- updatePublishTime
- login
- register
- logout

#### Platform Service

#### API

- registerPlatform
- unregisterPlatform
- getAllPlatforms

#### Blog Service

#### API

- createBlog
- getBlogs
- deleteBlog
- broadcastBlog

##### Email Service

#### API

- sendEmail

## Database Schema

### User

- id
- first_name
- last_name
- email
- interest
- years_of_experience

### Blog

- id
- user_id
- title
- content
- date
- keyword
