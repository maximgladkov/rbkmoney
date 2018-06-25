module RBKMoney
  class Notification
    attr_accessor :params

    def initialize(p)
      @params = p
      @order = Order.where(id: @params['orderId']).first
    end

    def accepted?
      completed? or status == "3"
    end

    def completed?
      status == "5"
    end

    def amount
      recipient_amount.to_f
    end
    
    def eshop_id
      @params['eshopId']
    end
    
    def payment_id
      @params['paymentId']
    end
    
    def order_id
      @params['orderId']
    end

    def service_name
      @params['serviceName']
    end
    
    def eshop_account
      @params['eshopAccount']
    end
    
    def recipient_amount
      @params['recipientAmount']
    end
    
    def currency
      @params['recipientCurrency']
    end

    def status
      @params['paymentStatus']
    end
    
    def user_name
      @params['userName']
    end
    
    def user_email
      @params['userEmail']
    end

    def payment_data
      @params['paymentData']
    end

    def received_at
      Time.parse payment_data
    end

    def secret_key
      RBKMoney::secret_key
    end
    
    def received_hash
      @params['hash']
    end
    
    def user_fields
      @params.select{ |p| p =~ /userField_[0-9]+/ }.map{ |k, v| v }
    end
    
    def to_s
      values = [:eshop_id, :order_id, :service_name, :recipient_amount, :currency, :status, :user_name, :user_email, :payment_data, :received_hash].map { |property| "#{property}: '#{self.send property}'" }.join(', ')
      "<#{values}>"
    end
    
    def generated_hash
      params_to_hash = [
                        RBKMoney::eshop_id,
                        @order.id,
                        RBKMoney::service_name,
                        RBKMoney::eshop_account,
                        @order.total.to_s.gsub(",","."), 
                        currency,
                        status,
                        #@order.email, 
                        #@order.email, 
                        user_name,
                        user_email,
                        payment_data,
                        RBKMoney.secret_key
      ]
      #@order.full_name,
      Rails.logger.fatal "hash #{params_to_hash}"
      
      string_to_hash = params_to_hash.join('::')
      Rails.logger.fatal "hash string #{string_to_hash}"
      
      Rails.logger.fatal "hash md5 #{Digest::MD5.hexdigest(string_to_hash)}"
      Digest::MD5.hexdigest(string_to_hash)
    end

    def acknowledge      
      received_hash == generated_hash
    end
    alias_method :acknowledge?, :acknowledge
    
  end
end
