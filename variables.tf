variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "tags" {
  description = "Tags to put on everything"
  type        = map(string)
  default = {
    project = "necesse-terraform"
  }
}

variable "instance_type" {
  description = "What type of instance to deploy"
  type        = string
  default     = "t3.medium"
}

variable "hosted_zone" {
  description = "What DNS Zone in R53 are we using for the install"
  type        = string
  default     = "aws.rgrs.xyz."
}

variable "game_name" {
  description = "What game from LinuxGSM are we installing?"
  type = string
  default = "necesse"
}