output "user_pool_domain" {
  value = aws_cognito_user_pool_domain.main.domain
}

output "user_pool_distribution_arn" {
  value = aws_cognito_user_pool_domain.main.cloudfront_distribution_arn
}
