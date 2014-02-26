# RBK Money

This gem helps to integrate RBK Money payments into Ruby on Rails applications.

## Installation

Add this line to your application's Gemfile:

    gem 'rbkmoney'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rbkmoney

And finally install `rbkmoney.yml` configuration file:

    $ rails g rbkmoney:install

## Usage

1. Fill in your `config/rbkmoney.yml` file with data.
  
2. Create your RBK Money form as follows:

        <%= rbkmoney_form_tag do %>
          <%= rbkmoney_setup order_id: "<YOUR_ORDER_ID>",
                             item_name: "<ITEM_NAME>",
                             user_name: "<USER_NAME>",
                             user_email: "<USER_EMAIL>",
                             amount: 1,
                             success_url: "<CUSTOM_SUCCESS_URL>",
                             fail_url: "<CUSTOM_FAIL_URL>" %>   
                           
          <%= submit_tag %>
        <% end %>

3. Add payment processing to your controller, e.g.:
    
      
        class PaymentsController
          def process
            def payment
              notification = RBKMoney::Notification.new(params)
              
              if notification.acknowledge # check if payment is valid
                if notification.accepted? # check if payment is accepted
                  if notification.completed? # check if payment is completed
                    order = Order.find(notification.order_id)
                    if order # check if order exists
                      if order.total == notification.amount # check payment amount
                        ...
                        head :ok and return
                      end
                    end
                  end
                end
              end
              
              head :bad_request and return
            end
          end
        end
    
4. Add route for your new action, e.g.: 

        post 'payments/process' => 'payments#process'


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
