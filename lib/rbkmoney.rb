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
    self.config['eshop_id'].to_i rescue 2016423
  end
  
  def self.eshop_account
    self.config['eshop_account'] rescue 'RU038214319'
  end
  
  def self.currency
    self.config['currency'] rescue 'RUR'
  end
  
  def self.success_url
    self.config['success_url'] rescue nil
  end
  
  def self.fail_url
    self.config['fail_url'] rescue nil
  end

end

require "rbkmoney/version"
require 'rbkmoney/notification'
require 'rbkmoney/helper'