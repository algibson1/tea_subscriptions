class Api::V1::CustomerSubscriptionsController < ApplicationController 
  before_action :find_customer
  before_action :find_subscription, only: [:create, :update]
  
  def index 
    render json: SubscriptionSerializer.new(@customer.subscriptions, params: {customer: @customer})
  end

  def create 
    CustomerSubscription.create!(cust_sub_params)
    render json: {message: "Successfully subscribed!"}
  end

  def update 
    sub = CustomerSubscription.find_by(cust_sub_params)
    sub&.update(status: params[:status]) || no_subscription_error
    render json: {message: "Subscription #{sub.status}"}
  end

  private 

  def cust_sub_params 
    {customer: @customer, subscription: @subscription}
  end

  def find_customer
    @customer = Customer.find(params[:customer_id])
  end

  def find_subscription
    @subscription = Subscription.find(params[:subscription_id] || params[:id])
  end

  def no_subscription_error
    raise ActiveRecord::RecordInvalid.new(), "#{@customer.first_name} has no subscription to #{@subscription.name} that can be updated"
  end
end