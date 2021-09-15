
# Global Config
variable "overwrite" {
  type        = bool
  default     = false
  description = "**DANGEROUS** Overwrites parameter if exists, use carefully"
}

variable "prefix" {
  type        = string
  default     = ""
  description = "Set a prefix to all variables, for example: `/myapp/dev/`"
}

# SecureString Config
variable "key_id" {
  type        = string
  default     = "alias/aws/ssm"
  description = "When using SecureString, use a specific KMS key"
}

# Tiers
variable "string_tier" {
  type        = string
  default     = "Standard"
  description = "Valid values: `Standard`, `Advanced` and `Intelligent-Tiering`"
}

variable "securestring_tier" {
  type        = string
  default     = "Standard"
  description = "Valid values: `Standard`, `Advanced` and `Intelligent-Tiering`"
}

variable "stringlist_tier" {
  type        = string
  default     = "Standard"
  description = "Valid values: `Standard`, `Advanced` and `Intelligent-Tiering`"
}

# Parameters
variable "string_parameters" {
  type        = list(string)
  default     = []
  description = "List of String(s)"
}

variable "securestring_parameters" {
  type        = list(string)
  default     = []
  description = "List of SecureString(s)"
}

variable "stringlist_parameters" {
  type        = list(string)
  default     = []
  description = "List of StringList(s) **comma-separated**"
}

# Initial Value
variable "string_initial_value" {
  type        = string
  default     = "empty"
  description = "Initial value for String(s)"
}

variable "securestring_initial_value" {
  type        = string
  default     = "empty"
  description = "Initial value for SecureString(s)"
}

variable "stringlist_initial_value" {
  type        = string
  default     = "empty"
  description = "Initial value for StringList(s)"
}

# Locals - all variables are fetched as locals to allow manipulation of values in future versions

locals {
  # Global Config
  prefix    = var.prefix != "" ? var.prefix : ""
  overwrite = var.overwrite

  # SecureString Config
  key_id = var.key_id

  # Tier
  string_tier       = var.string_tier
  securestring_tier = var.securestring_tier
  stringlist_tier   = var.stringlist_tier

  # Parameters
  string_parameters       = var.string_parameters
  securestring_parameters = var.securestring_parameters
  stringlist_parameters   = var.stringlist_parameters

  # Initial Value
  string_initial_value       = var.string_initial_value
  securestring_initial_value = var.securestring_initial_value
  stringlist_initial_value   = var.stringlist_initial_value
}
