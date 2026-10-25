variable "aws_region" {
  default = "ap-south-1"
}

variable "my_ip" {
  description = "Your public IPv4 address with /32"
  type        = string
}

variable "public_key_path" {
  description = "Path to the SSH public key inside WSL"
  type        = string
  default     = "~/.ssh/travelmemory-key.pub"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
