module RBKMoney
  module Helpers
    def rbkmoney_form_tag(url = RBKMoney::purchase_uri, options = {})
      form_tag(url, options)
    end

    def rbkmoney_form_tag(url = RBKMoney::purchase_uri, options = {}, &block)
      if block
        form_tag(url, options, &block)
      else
        form_tag(url, options)
      end
    end

    def rbkmoney_setup(options = {})
      params = {
        eshop_id: RBKMoney::eshop_id,
        item_name: RBKMoney::service_name,
        currency: RBKMoney::currency,
        success_url: RBKMoney::success_url,
        fail_url: RBKMoney::fail_url,
        locale: 'ru',
        custom: []
      }.reject{|k,v| v.nil?}.merge(options)

      params[:hash] = RBKMoney::Utils.request_hash(params)

      form = []
      form << tag(:input, :type => 'hidden', :name => 'eshopId',            :value => params[:eshop_id])
      form << tag(:input, :type => 'hidden', :name => 'orderId',            :value => params[:order_id])
      form << tag(:input, :type => 'hidden', :name => 'serviceName',        :value => params[:item_name])
      form << tag(:input, :type => 'hidden', :name => 'recipientAmount',    :value => params[:amount])
      form << tag(:input, :type => 'hidden', :name => 'recipientCurrency',  :value => params[:currency])
      form << tag(:input, :type => 'hidden', :name => 'successUrl',         :value => params[:success_url])
      form << tag(:input, :type => 'hidden', :name => 'failUrl',            :value => params[:fail_url])
      form << tag(:input, :type => 'hidden', :name => 'requestedLanguage',  :value => params[:locale])
      form << tag(:input, :type => 'hidden', :name => 'userName',           :value => params[:user_name])
      form << tag(:input, :type => 'hidden', :name => 'user_email',         :value => params[:user_email])
      form << tag(:input, :type => 'hidden', :name => 'hash',               :value => params[:hash])

      params[:custom].each_with_index do |value, i|
        form << tag(:input, :type => 'hidden', :name => "userField_#{i}", :value => value)
      end

      form.map(&:to_s).join("\n").html_safe
    end
  end

  class Railtie < Rails::Railtie
    initializer "rbkmoney.helpers" do
      ActionView::Base.send :include, Helpers
    end
  end
end
