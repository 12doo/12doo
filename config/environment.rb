# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
V3::Application.initialize!

require 'active_merchant'
require 'active_merchant/billing/integrations/action_view_helper'

ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)

#Alipay activemerchant config
ActiveMerchant::Billing::Integrations::Alipay::KEY = "sauy54rkin9b5hu8t980syw7gb7c704m"
ActiveMerchant::Billing::Integrations::Alipay::ACCOUNT = "2088002645810592"
ActiveMerchant::Billing::Integrations::Alipay::EMAIL = "zacharyzhang@msn.com"
