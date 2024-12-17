output "cluster_id" {
  description = "The unique identifier of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.id
}

output "kube_config" {
  description = "Kubeconfig file contents for connecting to the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "node_resource_group" {
  description = "The name of the resource group which contains the nodes of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "api_server_address" {
  description = "The URL to the Kubernetes API server."
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.host
}

output "identity_principal_id" {
  description = "The principal ID of the system-assigned identity used by the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
