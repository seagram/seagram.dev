module "secrets" {
  source = "./modules/secrets"
  email  = var.email
  phone_number = var.phone_number
}

module "sns" {
  source = "./modules/sns"
  
  depends_on = [module.secrets]
}

module "budgets" {
  source = "./modules/budgets"
  
  depends_on = [module.secrets, module.sns]
}
