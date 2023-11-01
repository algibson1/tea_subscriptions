class Api::V1::CustomerSubscriptionsController < ApplicationController 
  def index 
    customer = Customer.find(params[:customer_id])
    render json: CustomerSubscriptionsSerializer.new(customer).to_json
  end

  def create 
    CustomerSubscription.create!(cust_sub_params)
    render json: {message: "Successfully subscribed!"}, status: 200
  end

  # def destroy 
  #   sub = CustomerSubscription.find_by(cust_sub_params)
  #   sub.destroy
  # end

  private 

  def cust_sub_params 
    params.permit(:subscription_id, :customer_id)
  end
end