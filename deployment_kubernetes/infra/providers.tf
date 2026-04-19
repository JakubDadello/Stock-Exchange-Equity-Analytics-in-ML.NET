# ============================================================
# Required providers (declaration)
# ============================================================
terraform {
    required_providers {
        kubernetes = {
            source  = "hashicorp/kubernetes"
            version = "~> 2.30"
        }
    }
}

# ============================================================
# providers (configuration)
# ============================================================

#provider for Kubernetes 
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube-context"
}

#provider for HELM 
resource "helm_release" "kube_prometheus_stack" {
    name = "kube_prometheus_stack"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart = "kube_prometheus_stack"
    version = "55.0.0"
    namespace = kubernetes_namespace.monitoring[0].name

    # -----------------------------------------------------------
    # Prometheus configuration 
    # -----------------------------------------------------------

    # storage
    set {
        name = "prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.resources.requests.storage"
        value = "20Gi" #dev -> 10Gi, staging -> 20-50Gi, prod -> over 50Gi  
    }

    # scrapeInterval
    set {
        name = "prometheus.prometheusSpec.scrapeInterval"
        value = "30s" #dev -> 30s, staging -> 15-30s, prod -> 15s 
    }

    # evaluationInterval
    set {
        name = "prometheus.prometheusSpec.evaluationInterval:"
        value = "60s" #dev -> 60s, staging -> 30-60s, prod -> 30s 
    }

    # retention
    set {
        name  = "prometheus.prometheusSpec.retention"
        value = "10d" #keep the default value from values.yaml 
    }

    # resources
    set {
        name  = "prometheus.prometheusSpec.resources.requests.memory"
        value = "2Gi" #change the default value (400Mi) into 2Gi 
    }

    
    # -----------------------------------------------------------
    # Grafana configuration 
    # -----------------------------------------------------------

    # Log/Safety 
    set {
        name = "grafana.adminUser"
        value = "kube-admin"
    }
    set {
        name  = "grafana.adminPassword"
        value = "kube-admin-password" #only for trial  
    }

    #Access (Ingress)
    set {
        name = "grafana.ingress.enabled"
        value = "true"
    }

    # Persistence 
    set {
        name  = "grafana.persistence.enabled"
        value = "true"
    }
    set {
        name  = "grafana.persistence.size"
        value = "10Gi"
    } 

    # Resources 
    set {
        name = "grafana.resources.requests.memory"
        value = "256Mi"
    }
    set {
        name = "grafana.resources.requests.cpu"
        value = "100m"
    }

    # Sidecar 
    set {
        name = "grafana.sidecar.dashboards.enabled"
        value = "true"
    }
    set {
        name = "grafana.sidecar.datasources.enabled"
        value = "true" 
    }
}