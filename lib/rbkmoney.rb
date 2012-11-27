require 'cgi'
require 'net/http'
require 'net/https'
require 'active_support'
require 'digest/md5'

module RBKMoney
  
  PURCHASE_URI = "https://rbkmoney.ru/acceptpurchase.aspx"
  
  def self.config
    @config ||= YAML.load_file("#{Rails.root}/config/rbkmoney.yml")[Rails.env]
  end
  
  def self.purchase_uri
    PURCHASE_URI
  end
  
  def self.eshop_id
    config['eshop_id'].to_i
  end
  
  def self.eshop_account
    config['eshop_account']
  end
  
  def self.currency
    config['currency']
  end
  
  def self.success_url
    config['success_url']
  end
  
  def self.fail_url
    config['fail_url']
  end

end

require "rbkmoney/version"
require 'rbkmoney/notification'
require 'rbkmoney/helper'