locals {
  // combine our library of platforms with any custom platforms that may have been given
  platform_definitions = merge(local.lib_platform_definitions, var.custom_platforms)

  user_data_windows = templatefile(
    "${path.module}/userdata_windows.tpl",
    {
      win_admin_password = var.windows_password
    }
    )

  platform = local.platform_definitions[var.platform_key]
}

data "aws_ami" "ami" {
  most_recent = true
  owners      = [local.platform.owner]
  filter {
    name   = "name"
    values = [local.platform.ami_name]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

// variables calculated after ami data is pulled
locals {
  // combine ami/plaftorm data
  platform_with_ami = merge(local.platform, data.aws_ami.ami, {key: var.platform_key, ami: data.aws_ami.ami.id, user_data: data.aws_ami.ami.platform == "windows" ? local.user_data_windows : "" })
}
