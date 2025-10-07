module "route53_zone" {
  source           = "../../modules/route53-zone"
  root_domain_name = var.root_domain_name
}

module "acm" {
  source           = "../../modules/acm"
  root_domain_name = var.root_domain_name
  domain_aliases   = var.domain_aliases
  zone_id          = module.route53_zone.zone_id
}

module "cloudfront" {
  source                         = "../../modules/cloudfront"
  root_domain_name               = var.root_domain_name
  domain_aliases                 = var.domain_aliases
  s3_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  acm_certificate_arn            = module.acm.certificate_arn
}

module "s3" {
  source                        = "../../modules/s3"
  bucket_name                   = var.bucket_name
  cloudfront_distribution_arn   = module.cloudfront.distribution_arn
}

module "route53_records" {
  source                                 = "../../modules/route53-records"
  zone_id                                = module.route53_zone.zone_id
  root_domain_name                       = var.root_domain_name
  domain_aliases                         = var.domain_aliases
  cloudfront_distribution_domain_name    = module.cloudfront.distribution_domain_name
  cloudfront_distribution_hosted_zone_id = module.cloudfront.distribution_hosted_zone_id
}

module "porkbun" {
  source      = "../../modules/porkbun"
  domain_name = var.root_domain_name
  nameservers = module.route53_zone.zone_name_servers
}

module "secrets" {
  source      = "../../modules/secrets-manager"
  name_prefix = "seagram-prod/"
  
  secrets = {
    porkbun_api_key = {
      value       = var.porkbun_api_key
    }
    porkbun_secret_api_key = {
      value       = var.porkbun_secret_api_key
    }
  }
}
