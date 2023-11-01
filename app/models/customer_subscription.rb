class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription
  validate :unique_or_inactive, on: :create

  enum status: %w(Active Cancelled Paused)

  def unique_or_inactive
    found = CustomerSubscription.find_by(customer_id: self.customer_id, subscription_id: self.subscription_id)
    if !found.nil? && found.status == "Active"
      errors.add(:customer, "is already subscribed!")
    elsif !found.nil? && found.status != "Active"
      found.destroy
    end
  end
end
