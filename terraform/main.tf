module "s3" {
  source     = "./modules/s3"
  bucketname = local.bucketname
}

module "route53_zone" {
  source           = "./modules/route53-zone"
  root_domain_name = local.root_domain_name
}

module "acm" {
  source           = "./modules/acm"
  root_domain_name = local.root_domain_name
  domain_aliases   = local.domain_aliases
  zone_id          = module.route53_zone.zone_id
}

module "cloudfront" {
  source                         = "./modules/cloudfront"
  root_domain_name               = local.root_domain_name
  domain_aliases                 = local.domain_aliases
  s3_bucket_regional_domain_name = module.s3.bucket_regional_domain_name
  acm_certificate_arn            = module.acm.validated_certificate_arn
}

module "route53_records" {
  source                               = "./modules/route53-records"
  zone_id                              = module.route53_zone.zone_id
  root_domain_name                     = local.root_domain_name
  domain_aliases                       = local.domain_aliases
  cloudfront_distribution_domain_name  = module.cloudfront.distribution_domain_name
  cloudfront_distribution_hosted_zone_id = module.cloudfront.distribution_hosted_zone_id
}

module "porkbun" {
  source                    = "./modules/porkbun"
  root_domain_name          = local.root_domain_name
  route53_zone_name_servers = module.route53_zone.zone_name_servers
}