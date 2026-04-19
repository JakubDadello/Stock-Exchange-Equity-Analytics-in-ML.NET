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
# 4. PERSISTENT VOLUME CLAIM (PVC)
# ============================================================
resource "kubernetes_persistent_volume_claim" "minio" { #StorageClass (dynamic provisioning)
  metadata {
    name = "pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

# ============================================================
# 1. MODEL STORAGE (MinIO)
# ============================================================

# DEPLOYMENT
resource "kubernetes_deployment" "minio" {
  metadata {
    name = "model-storage"

    labels = {
      app = "model-storage"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
          app = "model-storage"
      }
    }

    template {
      metadata {
        labels = {
          app = "model-storage"
        }
      }

      spec {
        container {
          name  = "minio"
          image = "minio/minio:latest"

          args = ["server", "/data"]

          port {
            container_port = 9000
          }

          volume_mount {
            name       = "data"
            mount_path = "/data"
          }

          resources {
            requests = {
              cpu = "100m"
              memory = "256Mi"
            }

            limits = {
              cpu = "300m"
              memory = "512Mi"
            }
          }
        }
      }
    }
  }
}

# SERVICE 
resource "kubernetes_service" "minio" {
  metadata {
    name = "model-storage"
  }

  spec {
    selector = {
      app = "model-storage"
    }

    port {
      port        = 9000
      target_port = 9000
    }

    type = "NodePort" #Load Balancer following an on-premises deployment 

  }
}
