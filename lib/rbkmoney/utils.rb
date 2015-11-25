module RBKMoney
  module Utils
    def request_hash(params)
      params_to_hash = [params[:eshop_id],
                        params[:amount],
                        params[:currency],
                        params[:user_email],
                        params[:item_name],
                        params[:order_id],
                        params[:custom],
                        RBKMoney.secret_key]

      string_to_hash = params_to_hash.join('::')

      Digest::MD5.hexdigest(string_to_hash)
    end
  end
end
