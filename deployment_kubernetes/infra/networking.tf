# ============================================================
# 4. GATEWAY API (INGRESS)
# ============================================================
resource "kubernetes_ingress_v1" "gateway" {
  metadata {
    name = "ml-gateway"
    namespace = kubernetes_service.inference.metadata[0].namespace 

    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.inference.metadata[0].name

              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}