resource "kubernetes_service" "user" {
  depends_on = [
    kubernetes_namespace.app
  ]

  metadata {
    name = "service-user"
    namespace = local.namespace
    labels = {
      app = "user"
    }
  }

  spec {
    type = "ClusterIP"

    selector = {
      app = "user"
    }

    port {
      port        = 4001
      target_port = 4001
    }
  }
}

resource "kubernetes_deployment" "user" {
  depends_on = [
    kubernetes_namespace.app
  ]

  metadata {
    name = "deployment-user"
    namespace = local.namespace
    labels = {
      app = "user"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "user"
      }
    }

    template {
      metadata {
        labels = {
          app = "user"
        }
      }

      spec {
        container {
          name  = "user"
          image = "kokiebisu1408/service-user"

          port {
            container_port = 4001
          }
        }
      }
    }
  }
}