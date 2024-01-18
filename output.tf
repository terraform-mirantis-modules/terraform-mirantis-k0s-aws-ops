
output "vpc" {
  value = module.vpc
}

output "nodegroups" {
  value = local.nodegroups_safer
}

output "ingresses" {
  description = "Ingresses with dns information"
  value       = local.ingresses_withlb
}

output "key_path" {
  description = "path to the machine ssh private key"
  value       = var.key_path
}
