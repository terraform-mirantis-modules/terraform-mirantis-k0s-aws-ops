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
