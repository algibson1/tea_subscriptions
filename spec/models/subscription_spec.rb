require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "relationships" do
    it { should have_many :subscription_teas }
    it { should have_many(:teas).through(:subscription_teas) }
    it { should have_many :customer_subscriptions }
    it { should have_many(:customers).through(:customer_subscriptions) }
  end

  describe "instance methods" do
    it "can report status of subscription for a given customer" do
      load_test_data

      expect(@black.status(@sally)).to eq("Active")
      expect(@black.status(@ally)).to eq("Paused")
      expect(@fruity.status(@sally)).to eq("Cancelled")
    end
  end
end
