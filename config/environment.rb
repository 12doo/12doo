# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
V3::Application.initialize!

require 'active_merchant'
require 'active_merchant/billing/integrations/action_view_helper'

ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)

#Alipay activemerchant config
ActiveMerchant::Billing::Integrations::Alipay::KEY = "nz25webq288acynbd2dakma53dhzu6y1"
ActiveMerchant::Billing::Integrations::Alipay::ACCOUNT = "2088501132543295"
ActiveMerchant::Billing::Integrations::Alipay::EMAIL = "admin@imphotobook.com"
