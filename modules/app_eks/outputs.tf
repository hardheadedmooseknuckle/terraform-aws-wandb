output "cluster_id" {
  value       = module.eks.cluster_id
  description = "ID of the created EKS cluster"
}

output "aws_auth_configmap_yaml" {
  description = "Formatted yaml output for base aws-auth configmap containing roles used in cluster node groups/fargate profiles"
  value       = module.eks.aws_auth_configmap_yaml
}
output "autoscaling_group_names" {
  value = { for name, value in module.eks.self_managed_node_groups_autoscaling_group_names : name => lookup(value, "name") }
  # value = module.eks.self_managed_node_groups_autoscaling_group_names
}