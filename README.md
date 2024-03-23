# terrraform-odoo-aws

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.67 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm_certificate"></a> [acm\_certificate](#module\_acm\_certificate) | ./modules/acm_certificate | n/a |
| <a name="module_alb"></a> [alb](#module\_alb) | ./modules/ec2/alb | n/a |
| <a name="module_asg"></a> [asg](#module\_asg) | ./modules/ec2/asg | n/a |
| <a name="module_dlm"></a> [dlm](#module\_dlm) | ./modules/ec2/dlm | n/a |
| <a name="module_efs"></a> [efs](#module\_efs) | ./modules/efs | n/a |
| <a name="module_rds_cluster"></a> [rds\_cluster](#module\_rds\_cluster) | ./modules/rds_cluster | n/a |
| <a name="module_sg"></a> [sg](#module\_sg) | ./modules/ec2/sg | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |
| <a name="module_waf"></a> [waf](#module\_waf) | ./modules/waf | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | Availability Zones | `list(string)` | <pre>[<br>  "ap-southeast-1a",<br>  "ap-southeast-1b",<br>  "ap-southeast-1c"<br>]</pre> | no |
| <a name="input_subnet_private_db_cidr"></a> [subnet\_private\_db\_cidr](#input\_subnet\_private\_db\_cidr) | Private Subnet DB CIDR values | `list(string)` | <pre>[<br>  "20.0.7.0/24",<br>  "20.0.8.0/24",<br>  "20.0.9.0/24"<br>]</pre> | no |
| <a name="input_subnet_private_ec2_cidr"></a> [subnet\_private\_ec2\_cidr](#input\_subnet\_private\_ec2\_cidr) | Private Subnet EC2/App CIDR values | `list(string)` | <pre>[<br>  "20.0.4.0/24",<br>  "20.0.5.0/24",<br>  "20.0.6.0/24"<br>]</pre> | no |
| <a name="input_subnet_public_cidr"></a> [subnet\_public\_cidr](#input\_subnet\_public\_cidr) | Public Subnet CIDR values | `list(string)` | <pre>[<br>  "20.0.1.0/24",<br>  "20.0.2.0/24",<br>  "20.0.3.0/24"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## How to use

To use your IAM credentials to authenticate the Terraform AWS provider, set the AWS_ACCESS_KEY_ID environment variable.

> $ export AWS_ACCESS_KEY_ID=

Now, set your secret key.
> $ export AWS_SECRET_ACCESS_KEY=

Initialize the directory
> terraform init

Format and validate the configuration
> terraform fmt

Create infrastructure
> terraform apply
