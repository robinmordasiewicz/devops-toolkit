resource "null_resource" "marketplace_agreement" {
  for_each = local.vm-image

  provisioner "local-exec" {
    command = "${each.value.terms} && az vm image terms accept --publisher ${each.value.publisher} --offer ${each.value.offer} --plan ${each.value.sku} || true"
  }

  # triggers = {
  #   publisher = each.value.publisher
  #   offer     = each.value.offer
  #   sku       = each.value.sku
  #   terms     = each.value.terms
  # }
}
