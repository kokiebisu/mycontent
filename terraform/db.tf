resource "kubernetes_service" "db" {
  depends_on = [
    kubernetes_namespace.app
  ]

  metadata {
    name = "db"
    namespace = local.namespace
    labels = {
      app = "db"
    }
  }

  spec {
    type = "ClusterIP"

    selector = {
      app = "db"
    }

    port {
      port        = 5432
      target_port = 5432
    }
  }
}

resource "kubernetes_deployment" "db" {
  depends_on = [
    kubernetes_namespace.app
  ]

  metadata {
    name = "deployment-db"
    namespace = local.namespace
    labels = {
      app = "db"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "db"
      }
    }

    template {
      metadata {
        labels = {
          app = "db"
        }
      }

      spec {
        container {
          name  = "db"
          image = "postgres"

          port {
            container_port = 5432
          }

          env {
            name  = "POSTGRES_USER"
            value = "postgres"
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = "mypassword"
          }

          env {
            name  = "POSTGRES_DB"
            value = "mydb"
          }
        }
      }
    }
  }
}