## AWS Cognito

This Terraform module creates a simple AWS Cognito authentication provider.  
Users will be identified by the `email` address.

 - MFA is configurable.
 - Account recovery by email
 - Email constraints: 320 >= email.length >= 5
 - Email sender: Cognito


### Input variables

`project_name` - Project name (will be used as prefix in other resources)

`sso_domain` - Domain for hosted UI.

`sso_domain_certificate_arn` - ARN of SSL certificate

`callback_url` - URL to which authorization code should be sent.

`mfa` - Is MFA enabled/disabled (default: OPTIONAL)

`access_token_validity` - Minutes for how long Access Token should be valid (default: 60)

`refresh_token_validity` - Hours for how long Refresh Token should be valid (default: 1)

`id_token_validity` - Minutes for how long ID Token should be valid (default: 60)

`tags` - Tags


### Outputs

`user_pool_domain` - Domain of app-client's hosted UI.

`user_pool_distribution_arn` - Cloudfront distribution of hosted UI.

