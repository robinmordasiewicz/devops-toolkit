resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "self_signed_cert" {
  private_key_pem = tls_private_key.private_key.private_key_pem
  dns_names       = [data.azurerm_public_ip.hub-nva-vip_public_ip.fqdn]

  subject {
    common_name = data.azurerm_public_ip.hub-nva-vip_public_ip.fqdn
  }

  validity_period_hours = 24
  early_renewal_hours   = 1

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}
