terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.17.0"
    }
  }
}

locals {
  namespace   = "mycontent"
  config_path = "/Users/ken/Environments/docker/.kube/config"
}

provider "kubernetes" {
  config_path    = local.config_path
  config_context = "minikube"
}

resource "kubernetes_namespace" "app" {
  metadata {
    name = local.namespace
  }
}

resource "kubernetes_ingress_v1" "default" {
  depends_on = [
    kubernetes_namespace.app
  ]

  metadata {
    name      = "api-ingress"
    namespace = local.namespace
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }

  spec {
    rule {
      http {
        path {
          path     = "/api"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.gateway.metadata[0].name
              port {
                number = 4000
              }
            }
          }
        }
      }
    }
  }
}

