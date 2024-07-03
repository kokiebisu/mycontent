resource "kubernetes_service" "content" {
  depends_on = [
    kubernetes_namespace.app
  ]

  metadata {
    name = "service-content"
    namespace = local.namespace
    labels = {
      app = "content"
    }
  }

  spec {
    type = "ClusterIP"

    selector = {
      app = "content"
    }

    port {
      port        = 4002
      target_port = 4002
    }
  }
}

resource "kubernetes_deployment" "content" {
  depends_on = [
    kubernetes_namespace.app
  ]

  metadata {
    name = "deployment-content"
    namespace = local.namespace
    labels = {
      app = "content"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "content"
      }
    }

    template {
      metadata {
        labels = {
          app = "content"
        }
      }

      spec {
        container {
          name  = "content"
          image = "kokiebisu1408/service-content"

          port {
            container_port = 4002
          }
        }
      }
    }
  }
}