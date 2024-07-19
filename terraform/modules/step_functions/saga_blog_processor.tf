resource "aws_sfn_state_machine" "saga_blog_processor" {
  name     = "saga-blog-processor"
  role_arn = aws_iam_role.step_functions_role.arn

  definition = jsonencode({
    "Comment": "Blog Content Generation Process",
    "StartAt": "ProcessConversations",
    "States": {
      "ProcessConversations": {
        "Type": "Task",
        "Resource": var.lambda_process_conversations_arn,
        "Next": "GenerateContent"
      },
      "GenerateContent": {
        "Type": "Task",
        "Resource": var.lambda_generate_content_arn,
        "End": true
      },
    }
  })
}
