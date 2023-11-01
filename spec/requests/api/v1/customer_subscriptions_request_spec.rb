require "rails_helper" 

RSpec.describe "Customer Subscriptions Endpoints" do
  describe "create endpoint" do
    context "given a valid customer and subscription" do
      it "creates an association between a customer and a subscription (subscribes)" do
        load_test_data

        expect(@junior.subscriptions).to eq([])
        expect(@elly.subscriptions).to eq([])

        post "/api/v1/customers/#{@junior.id}/subscriptions", params: {subscription_id: @floral.id}

        expect(response).to be_successful
        expect(response.status).to eq(200)

        expect(JSON.parse(response.body)["message"]).to eq("Successfully subscribed!")

        post "/api/v1/customers/#{@elly.id}/subscriptions", params: {subscription_id: @floral.id}
        expect(JSON.parse(response.body)["message"]).to eq("Successfully subscribed!")

        @junior = Customer.find(@junior.id)
        @elly = Customer.find(@elly.id)

        expect(@junior.subscriptions).to eq([@floral])
        expect(@elly.subscriptions).to eq([@floral])
      end

      xit "does not subscribe the customer if they are already subscribed" do
        load_test_data 

        expect(@sally.subscriptions).to eq([@black, @fruity])

        post "/api/v1/customers/#{@sally.id}/subscriptions", params: {subscription_id: @fruity.id}
        expect(response).to_not be_successful
        # expect(response.status).to eq()
      end
    end

    context "given invalid customer or subscription" do
      xit "returns an error if customer id is invalid" do

      end

      xit "returns an error if subscription id is invalid" do

      end
    end
  end

  describe "destroy endpoint" do
    context "given a valid customer and subscription" do
      it "destroys an associatioin between a customer and a subscription (unsubscribes)" do
        load_test_data

        expect(@sally.subscriptions).to eq([@black, @fruity])
        delete "/api/v1/customers/#{@sally.id}/subscriptions", params: {subscription_id: @fruity.id}

        expect(response).to be_successful
        expect(response.status).to eq(204)
        expect(response.body).to eq("")

        @sally = Customer.find(@sally.id)
        expect(@sally.subscriptions).to eq([@black])
      end

      xit "returns an error if association does not exist" do
        
      end
    end

    context "given invalid customer or subscription data" do
      xit "returns an error if customer doesn't exist" do

      end

      xit "returns an error if subscription doesn't exist" do

      end
    end
  end
end