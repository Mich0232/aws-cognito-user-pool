resource "aws_cognito_user_pool" "main" {
  name                     = "${var.project_name}-userpool"
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  tags = local.resource_tags

  mfa_configuration = var.mfa
  software_token_mfa_configuration {
    enabled = true
  }

  account_recovery_setting {
    recovery_mechanism {
      priority = 1
      name     = "verified_email"
    }
  }

  schema {
    attribute_data_type      = "String"
    name                     = "email"
    developer_only_attribute = false
    required                 = true
    mutable                  = false
    string_attribute_constraints {
      min_length = "5"
      max_length = "320"
    }
  }

  user_attribute_update_settings {
    attributes_require_verification_before_update = ["email"]
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

}

resource "aws_cognito_user_pool_domain" "main" {
  domain          = var.sso_domain
  user_pool_id    = aws_cognito_user_pool.main.id
  certificate_arn = var.sso_domain_certificate_arn
}

resource "aws_cognito_user_pool_client" "main" {
  name         = "${var.project_name}-app-client"
  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret                      = false
  explicit_auth_flows                  = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["openid", "email"]
  supported_identity_providers         = ["COGNITO"]
  callback_urls                        = [var.callback_url]

  access_token_validity  = var.access_token_validity
  refresh_token_validity = var.refresh_token_validity
  id_token_validity      = var.id_token_validity

  token_validity_units {
    access_token  = "minutes"
    refresh_token = "hours"
    id_token      = "minutes"
  }

  enable_token_revocation       = true
  prevent_user_existence_errors = "ENABLED"
}
