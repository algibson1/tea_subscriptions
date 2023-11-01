class Api::V1::CustomerSubscriptionsController < ApplicationController 
  before_action :find_customer
  before_action :find_subscription, only: [:create, :update]
  
  def index 
    render json: CustomerSubscriptionsSerializer.new(@customer).to_json
  end

  def create 
    CustomerSubscription.create!(cust_sub_params)
    render json: {message: "Successfully subscribed!"}
  end

  def update 
    sub = CustomerSubscription.find_by(customer: @customer, subscription: @subscription)
    sub.update(status: params[:status])
    if sub.status == "Cancelled"
      render json: {message: "Subscription Cancelled"}
    end
  end

  private 

  def cust_sub_params 
    params.permit(:subscription_id, :customer_id)
  end

  def find_customer
    @customer = Customer.find(params[:customer_id])
  end

  def find_subscription
    @subscription = Subscription.find(params[:subscription_id] || params[:id])
  end
end