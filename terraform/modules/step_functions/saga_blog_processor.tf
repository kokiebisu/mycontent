resource "aws_sfn_state_machine" "saga_blog_processor" {
  name     = "saga-blog-processor"
  role_arn = var.iam_role_step_functions_role_arn

  definition = jsonencode({
    "Comment": "Blog Content Generation Process",
    "StartAt": "ThreadGrouper",
    "States": {
      "ThreadGrouper": {
        "Type": "Task",
        "Resource": var.lambda_thread_grouper_arn,
        "Next": "ProcessConversations"
      },
      "ProcessConversations": {
        "Type": "Task",
        "Resource": var.lambda_process_conversations_arn,
        "End": true
      },
    }
  })
}
