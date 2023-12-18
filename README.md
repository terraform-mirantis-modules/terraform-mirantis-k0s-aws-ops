# Mirantis terraform k0s AWS module for Ops

This is a terraform implementation which creates the underlying infrstastructure for k0s on the AWS provider.
This module uses an underlyining AWS official chart - terraform-aws-modules/autoscaling/aws, which is used to create autoscaling groups within the VPC.

## Usage
Just like any other terraform module you need to have pass the required variables to the module and then do `terraform apply`

## Examples
You can find all example variables files under the *examples/* folder
```
// used to name infrastructure
name = "test-test"

region = "us-east-1"

// one definition for each group of machines to include in the stack
nodegroups = {
  // A stack
  "ACon" = { // controllers for A
    ami              = "ami-0f4cb88f4072d0bdb"
    count            = 3
    type             = "m6a.2xlarge"
    volume_size      = 100
    root_device_name = "/dev/sdb"
    role             = "controller"
    public           = true
    user_data        = ""
  },
  "AWrk_1" = { // workers for A
    ami              = "ami-0f4cb88f4072d0bdb"
    count            = 3
    type             = "c6a.xlarge"
    volume_size      = 100
    root_device_name = "/dev/sdb"
    public           = true
    role             = "worker"
    user_data        = ""
  }
}

```

## Support, Reporting Issues & Feedback

Please use Github [issues](https://github.com/terraform-mirantis-modules/terraform-mirantis-k0s-aws-ops) to report any issues, provide feedback, or request support.
