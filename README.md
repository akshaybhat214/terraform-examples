# TF Examples

- This repo contains terraform examples for various AWS resources.
- In most cases, you can just modify the `variables.tf` file and then add/remove features
as needed.
- Complicated modules will have their own README.

### Usage
- `terraform init` to initialize tf config files
- `terraform plan` to see what changes will be applied
- `terraform apply` to apply the changes and create/modify the resources

Different modules may have used different terraform versions, as indicated by the `.terraform-version`
file in the folders. 
Either you can modify the code to comply with your terraform version, or use
tfenv: https://github.com/tfutils/tfenv
