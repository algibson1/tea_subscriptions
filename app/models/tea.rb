class Tea < ApplicationRecord
  has_many :subscription_teas 
  has_many :subscriptions, through: :subscription_teas

  enum type: %w(black green white herbal blended)
end
