variable "namespace" {
  type        = string
  description = "Name prefix used for resources"
}

variable "domain" {
  type        = string
  default     = "wandb.ml"
  description = "domain for accessing the Weights & Biases UI."
}

variable "subdomain" {
  type        = string
  default     = "venky-aws"
  description = "Subdomain for accessing the Weights & Biases UI."
}

variable "wandb_license" {
  type = string
}