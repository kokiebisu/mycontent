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
        "ResultPath": "$.parseResult",
        "Next": "MapConversations",
        "Parameters": {
          "environment": var.environment,
          "detail.$": "$.detail"
        }
      },
      "MapConversations": {
        "Type": "Map",
        "ItemsPath": "$.parseResult.conversation_ids",
        "Parameters": {
          "conversation_id.$": "$$.Map.Item.Value",
          "bucket_name.$": "$.parseResult.bucket_name",
          "key.$": "$.parseResult.key"
        },
        "Iterator": {
          "StartAt": "GenerateBlogECS",
          "States": {
            "GenerateBlogECS": {
              "Type": "Task",
              "Resource": "arn:aws:states:::ecs:runTask.sync",
              "Parameters": {
                "LaunchType": "FARGATE",
                "Cluster": "${var.ecs_cluster_arn}",
                "TaskDefinition": "${var.generate_blog_task_definition_arn}",
                "NetworkConfiguration": {
                  "AwsvpcConfiguration": {
                    "Subnets": var.subnet_ids,
                    "SecurityGroups": [var.ecs_task_security_group_id],
                    "AssignPublicIp": "ENABLED"
                  }
                },
                "Overrides": {
                  "ContainerOverrides": [
                    {
                      "Name": "generate-blog",
                      "Environment": [
                        {
                          "Name": "INPUT_BUCKET",
                          "Value.$": "$.bucket_name"
                        },
                        {
                          "Name": "INPUT_KEY",
                          "Value.$": "$.key"
                        },
                        {
                          "Name": "CONVERSATION_ID",
                          "Value.$": "$.conversation_id"
                        },
                        {
                          "Name": "ENVIRONMENT",
                          "Value": var.environment
                        },
                        {
                          "Name": "AWS_DEFAULT_REGION",
                          "Value": "${var.region_name}"
                        },
                        {
                          "Name": "BLOG_SERVICE_URL",
                          "Value": "blog.mycontent.internal:50052"
                        }
                      ]
                    }
                  ]
                }
              },
              "End": true
            }
          }
        },
        "End": true
      }
    }
  })
}