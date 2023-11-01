require 'rails_helper'

RSpec.describe CustomerSubscription, type: :model do
  describe "relationships" do
    it { should belong_to :customer }
    it { should belong_to :subscription }
  end

  describe "validations" do
    context "an association between customer and subscription already exists" do
      it "throws error if customer subscription is already active" do
        @sally = Customer.create!(first_name: "Sally", last_name: "Johnson", email: "example@test.com", street_address: "1234 Some Street", city: "Littleton", state: "CO", zip: "80125")
        @black = Subscription.create!(name: "Black Tea Pack", price: 20.37, frequency: "Monthly")
        CustomerSubscription.create!(customer: @sally, subscription: @black, status: "Active")

        expect { CustomerSubscription.create!(customer: @sally, subscription: @black) }.to raise_error("Validation failed: Customer is already subscribed!")
      end

      it "Replaces old subscription if subscription is not active" do
        @sally = Customer.create!(first_name: "Sally", last_name: "Johnson", email: "example@test.com", street_address: "1234 Some Street", city: "Littleton", state: "CO", zip: "80125")
        @black = Subscription.create!(name: "Black Tea Pack", price: 20.37, frequency: "Monthly")
        CustomerSubscription.create!(customer: @sally, subscription: @black, status: "Cancelled")

        expect(CustomerSubscription.count).to eq(1)
        expect(CustomerSubscription.last.status).to eq("Cancelled")

        CustomerSubscription.create!(customer: @sally, subscription: @black)
        expect(CustomerSubscription.count).to eq(1)
        expect(CustomerSubscription.last.status).to eq("Active")
      end
    end
  end
end
