output "backend_public_ip" {
  value = module.backend.backend_public_ip
}

output "database_endpoint" {
  value = module.database.db_endpoint
}

output "frontend_url" {
  value = module.frontend.frontend_url
}
