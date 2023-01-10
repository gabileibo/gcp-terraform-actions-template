# Hello from GCP

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | ~> 1.3.6  |
| <a name="requirement_google"></a> [google](#requirement_google)          | ~> 4.46.0 |

## Providers

| Name                                                      | Version   |
| --------------------------------------------------------- | --------- |
| <a name="provider_google"></a> [google](#provider_google) | ~> 4.46.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                   | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [google_storage_bucket_object_content.bootstrap_text](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_bucket_object_content) | data source |

## Inputs

| Name                                                                           | Description               | Type     | Default | Required |
| ------------------------------------------------------------------------------ | ------------------------- | -------- | ------- | :------: |
| <a name="input_project_id"></a> [project_id](#input_project_id)                | GCP project ID            | `string` | n/a     |   yes    |
| <a name="input_region"></a> [region](#input_region)                            | GCP default region        | `string` | n/a     |   yes    |
| <a name="input_tf_state_bucket"></a> [tf_state_bucket](#input_tf_state_bucket) | Bucket name storing state | `string` | n/a     |   yes    |

## Outputs

| Name                                                                          | Description                                                     |
| ----------------------------------------------------------------------------- | --------------------------------------------------------------- |
| <a name="output_bootstrap_text"></a> [bootstrap_text](#output_bootstrap_text) | bootstrap text to show in Github actions to ensure proper setup |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
