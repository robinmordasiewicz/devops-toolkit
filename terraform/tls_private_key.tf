resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "self_signed_cert" {
  #key_algorithm   = tls_private_key.private_key.algorithm
  private_key_pem = tls_private_key.private_key.private_key_pem
  dns_names       = [data.azurerm_public_ip.hub-nva-vip_public_ip.fqdn]

  subject {
    common_name  = data.azurerm_public_ip.hub-nva-vip_public_ip.fqdn
    organization = "Example, Inc."
  }

  validity_period_hours = 24
  early_renewal_hours   = 1

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

#resource "local_file" "ssl_key" {
#  content  = tls_private_key.private_key.private_key_pem
#  filename = "${path.module}/certs/cloudmanthanCA.key"
#}

output "cert_pem" {
  value = tls_self_signed_cert.self_signed_cert.cert_pem
}

output "private_key_pem" {
  value     = tls_private_key.private_key.private_key_pem
  sensitive = true
}
