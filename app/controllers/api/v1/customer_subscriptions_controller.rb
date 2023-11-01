class Api::V1::CustomerSubscriptionsController < ApplicationController 
  def index 
    customer = Customer.find(params[:customer_id])
    render json: CustomerSubscriptionsSerializer.new(customer).to_json
  end

  def create 
    CustomerSubscription.create!(cust_sub_params)
    render json: {message: "Successfully subscribed!"}
  end

  def update 
    sub =  CustomerSubscription.find_by(customer_id: params[:customer_id], subscription_id: params[:id])
    sub.update(status: params[:status])
    render json: {message: "Subscription Cancelled"}
  end

  private 

  def cust_sub_params 
    params.permit(:subscription_id, :customer_id)
  end
end