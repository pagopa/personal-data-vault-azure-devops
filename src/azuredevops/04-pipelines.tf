locals {
  delploy_app = {
    docker_image = "ms-tokenizer"
  }
}


module "ecs_deploy" {
  source = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_build_definition_deploy?ref=v2.0.5"

  project_id                   = azuredevops_project.this.id
  repository                   = var.ms-person.repository
  github_service_connection_id = azuredevops_serviceendpoint_github.github_pr.id

  ci_trigger_use_yaml = true

  variables        = local.delploy_app
  variables_secret = {}

  service_connection_ids_authorization = [
    azuredevops_serviceendpoint_github.github_ro.id,
    azuredevops_serviceendpoint_aws.uat_serviceendpoint.id,
    azuredevops_serviceendpoint_aws.prod_serviceendpoint.id,
  ]
}
