data "http" "terraform" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"
  request_headers = {
    Accept = "application/json"
  }
}

output "terraform_version" {
  description = "Terraform Version"
  value       = jsondecode(data.http.terraform.response_body).current_version
}
