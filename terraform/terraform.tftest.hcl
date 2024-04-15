run "terraform_version" {
  assert {
    condition     = output.terraform_version == "1.8.0"
    error_message = "Current Version"
  }
}
