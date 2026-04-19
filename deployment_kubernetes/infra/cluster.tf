# ============================================================
# Main Namespace 
# ============================================================
resource "kubernetes_namespace" "ml-namespace" {
  metadata {
    name = "ml-namespace"
  }
}

# ============================================================
# Monitoring Namespace 
# ============================================================
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}