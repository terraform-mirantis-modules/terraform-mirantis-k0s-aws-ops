# Mirantis terraform k0s AWS module for Ops

This is a terraform implementation which creates the underlying infrstastructure for k0s on the AWS provider.
This module uses an underlyining AWS official chart - terraform-aws-modules/autoscaling/aws, which is used to create autoscaling groups within the VPC.

## Usage
Just like any other terraform module you need to have pass the required variables to the module and then do `terraform apply`

## Examples
```
module "k0s-aws-ops" {
  source  = "terraform-mirantis-modules/k0s-aws-ops/mirantis"
  version = "0.0.1"

  name = "test-test"

  region = "us-east-1"

  // one definition for each group of machines to include in the stack
  nodegroups = {
    // A stack
    "ACon" = { // controllers for A
      ami              = "ami-xxxxxxxxx"
      count            = 1
      type             = "m6a.2xlarge"
      volume_size      = 100
      root_device_name = "/dev/sdb"
      role             = "controller"
      public           = true
      user_data        = ""
    },
    "AWrk_1" = { // workers for A
      ami              = "ami-xxxxxxxxx"
      count            = 1
      type             = "c6a.xlarge"
      volume_size      = 100
      root_device_name = "/dev/sdb"
      public           = true
      role             = "worker"
      user_data        = ""
    }
  }
}
```
You can find all examples under the *examples/* folder

## Support, Reporting Issues & Feedback

Please use Github [issues](https://github.com/terraform-mirantis-modules/terraform-mirantis-k0s-aws-ops) to report any issues, provide feedback, or request support.
