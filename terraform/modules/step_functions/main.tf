# resource "aws_lambda_function" "group_conversations" {
#   filename      = "lambda_functions/group_conversations.zip"
#   function_name = "group_conversations"
#   role          = aws_iam_role.lambda_role.arn
#   handler       = "group_conversations.lambda_handler"
#   runtime       = "python3.8"
# }

# resource "aws_lambda_function" "sanitize_conversations" {
#   filename      = "lambda_functions/sanitize_conversations.zip"
#   function_name = "sanitize_conversations"
#   role          = aws_iam_role.lambda_role.arn
#   handler       = "sanitize_conversations.lambda_handler"
#   runtime       = "python3.8"
# }

# resource "aws_lambda_function" "generate_content" {
#   filename      = "lambda_functions/generate_content.zip"
#   function_name = "generate_content"
#   role          = aws_iam_role.lambda_role.arn
#   handler       = "generate_content.lambda_handler"
#   runtime       = "python3.8"
#   environment = {
#     variables = {
#       OPENAI_API_KEY = var.openai_api_key
#     }
#   }
# }

# resource "aws_lambda_function" "save_content" {
#   filename      = "lambda_functions/save_content.zip"
#   function_name = "save_content"
#   role          = aws_iam_role.lambda_role.arn
#   handler       = "save_content.lambda_handler"
#   runtime       = "python3.8"
# }

# resource "aws_sfn_state_machine" "content_processor" {
#   name     = "content-processor"
#   role_arn = aws_iam_role.step_functions_role.arn

#   definition = jsonencode({
#     "Comment": "Blog Content Generation Process",
#     "StartAt": "LoadConversations",
#     "States": {
#       "LoadConversations": {
#         "Type": "Task",
#         "Resource": aws_lambda_function.load_conversations.arn,
#         "Next": "GroupConversations"
#       },
#       "GroupConversations": {
#         "Type": "Task",
#         "Resource": aws_lambda_function.group_conversations.arn,
#         "Next": "SanitizeConversations"
#       },
#       "SanitizeConversations": {
#         "Type": "Task",
#         "Resource": aws_lambda_function.sanitize_conversations.arn,
#         "Next": "GenerateContent"
#       },
#       "GenerateContent": {
#         "Type": "Task",
#         "Resource": aws_lambda_function.generate_content.arn,
#         "Next": "SaveContent"
#       },
#       "SaveContent": {
#         "Type": "Task",
#         "Resource": aws_lambda_function.save_content.arn,
#         "End": true
#       }
#     }
#   })
# }

# resource "aws_iam_role" "step_functions_role" {
#   name = "step_functions_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "states.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_policy" "lambda_policy" {
#   name = "lambda_policy"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents"
#         ]
#         Effect = "Allow"
#         Resource = "arn:aws:logs:*:*:*"
#       },
#       {
#         Action = [
#           "s3:GetObject"
#         ]
#         Effect = "Allow"
#         Resource = "arn:aws:s3:::*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
#   role       = aws_iam_role.lambda_role.name
#   policy_arn = aws_iam_policy.lambda_policy.arn
# }

# resource "aws_iam_policy" "step_functions_policy" {
#   name = "step_functions_policy"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "lambda:InvokeFunction"
#         ]
#         Effect = "Allow"
#         Resource = [
#           aws_lambda_function.load_conversations.arn,
#           aws_lambda_function.group_conversations.arn,
#           aws_lambda_function.sanitize_conversations.arn,
#           aws_lambda_function.generate_content.arn,
#           aws_lambda_function.save_content.arn
#         ]
#       },
#       {
#         Action = [
#           "s3:GetObject"
#         ]
#         Effect = "Allow"
#         Resource = "arn:aws:s3:::*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "step_functions_policy_attachment" {
#   role       = aws_iam_role.step_functions_role.name
#   policy_arn = aws_iam_policy.step_functions_policy.arn
# }