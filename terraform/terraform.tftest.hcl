run "terraform_version" {
  assert {
    condition     = output.terraform_version == "1.6.2"
    error_message = "Current Version"
  }
}
