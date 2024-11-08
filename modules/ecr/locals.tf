locals {
  resource_tags = merge(
    {
      tfmodule        = "terraform_ecr_mod/ecr:v1.2.0"
    },
    var.tags
  )
}