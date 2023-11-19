resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "tls_private_key" {
  description = "TSL private key"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}
