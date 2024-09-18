variable "auth0_domain" {
  description = "The Auth0 domain"
  type        = string
}

variable "auth0_client_id" {
  description = "The Auth0 client ID"
  type        = string
}

variable "auth0_client_secret" {
  description = "The Auth0 client secret"
  type        = string
  sensitive   = true
}
