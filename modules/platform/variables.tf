variable "platform_key" {
  description = "Platform name/label key for the platforms list"
  type = string
}

variable "region" {
  description = "AWS Region to use for searching for images"
  type        = string
  default     = "us-east-1"
}

variable "custom_platforms" {
  description = "Platform/AMI that can be used. Can override the built in libraryy list."
  type = map(object({
    ami_name   = string
    owner      = string
    user       = string
    interface  = string
    connection = string
  }))
  default = {}
}

variable "windows_password" {
  description = "Password to use with windows & winrm"
  type = string
  default = ""
}
