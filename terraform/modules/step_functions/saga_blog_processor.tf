resource "aws_sfn_state_machine" "saga_blog_processor" {
  name     = "saga-blog-processor"
  role_arn = var.iam_role_step_functions_role_arn

  definition = jsonencode({
    "Comment": "Blog Content Generation Process",
    "StartAt": "ParseConversations",
    "States": {
      "ParseConversations": {
        "Type": "Task",
        "Resource": var.lambda_parse_conversations_arn,
        "Next": "MapConversations"
      },
      "MapConversations": {
        "Type": "Map",
        "ItemsPath": "$.conversations",
        "Parameters": {
          "conversation.$": "$$.Map.Item.Value",
          "bucket_name.$": "$.bucket_name",
          "key.$": "$.key"
        },
        "Iterator": {
          "StartAt": "GenerateBlog",
          "States": {
            "GenerateBlog": {
              "Type": "Task",
              "Resource": var.lambda_generate_blog_arn,
              "End": true
            }
          }
        },
        "End": true
      },
    }
  })
}
