class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes  :name,
              :price,
              :frequency

  attributes :status do |subscription, params|
    subscription.status(params[:customer])
  end
end
