class CustomerSubscriptionsSerializer
  def initialize(customer)
    @customer = customer
  end

  def to_json
    {
      data: @customer.subscriptions.map do |subscription|
        {
          id: subscription.id,
          type: "subscription",
          attributes: {
            name: subscription.name,
            price: subscription.price,
            frequency: subscription.frequency,
            status: CustomerSubscription.find_by(customer: @customer, subscription: subscription).status
          }
        }
      end
    }
  end
end
