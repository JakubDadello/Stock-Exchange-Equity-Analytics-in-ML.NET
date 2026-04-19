# ============================================================
# 4. SECRET (sensitive data)
# ============================================================
resource "kubernetes_secret" "ml_secret" {
  metadata {
    name = "ml_secret"
  }

  data = {
    MINIO_ACCESS_KEY = base64encode("admin")
    MINIO_SECRET_KEY = base64encode("supersecret")
  }
  
}


# ============================================================
# 3. CONFIGMAP (non-sensitive config)
# ============================================================
resource "kubernetes_config_map" "ml_config" {
  metadata {
    name = "ml-config"
  }

  data = {
    MODEL_STORAGE_URL = "http://model-storage:9000"
    INFERENCE_MODE = "dev"
    LOG_LEVEL = "debug"
  }
}


# ============================================================
# 2. INFERENCE API 
# ============================================================

# DEPLOYMENT
resource "kubernetes_deployment" "app" {
  metadata {
    name = "ml-inference"

    labels = {
      app = "ml-inference"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "ml-inference"
      }
    }

    template {
      metadata {
        labels = {
          app = "ml-inference"
        }
      }

      spec {
        container {
          name  = "api"
          image = "nginx:latest"

          port {
            container_port = 80
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
          }

          resources {
            requests = {
              cpu = "300m"
              memory = "512Mi"
            }

            limits = {
              cpu = "1000m"
              memory = "1Gi"
            }
          }
        }
      }
    }
  }
}

# SERVICE 
resource "kubernetes_service" "app" {
  metadata {
    name = "ml-inference"
  }

  spec {
    selector = {
       app = "ml-inference"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}




