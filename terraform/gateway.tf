resource "kubernetes_service" "gateway" {
  depends_on = [
    kubernetes_namespace.app
  ]

  metadata {
    name = "service-gateway"
    namespace = local.namespace
    labels = {
      app = "gateway"
    }
  }

  spec {
    type = "ClusterIP"

    selector = {
      app = "gateway"
    }

    port {
      port        = 4000
      target_port = 4000
    }
  }
}

resource "kubernetes_deployment" "gateway" {
  depends_on = [
    kubernetes_namespace.app
  ]

  metadata {
    name = "deployment-gateway"
    namespace = local.namespace
    labels = {
      app = "gateway"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "gateway"
      }
    }

    template {
      metadata {
        labels = {
          app = "gateway"
        }
      }

      spec {
        container {
          name  = "gateway"
          image = "kokiebisu1408/gateway"

          port {
            container_port = 4000
          }
        }
      }
    }
  }
}