require "rails_helper" 

RSpec.describe "Customer Subscriptions Endpoints" do
  describe "Index endpoint" do
    context "given a valid customer id" do
      it "returns list of all customer's subscriptions, regardless of status" do
        load_test_data 

        get "/api/v1/customers/#{@sally.id}/subscriptions" 

        expect(response).to be_successful
        expect(response.status).to eq(200)

        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(subscriptions).to be_an(Array)
        expect(subscriptions.count).to eq(2)
        expect(subscriptions.first[:id]).to eq(@black.id)
        expect(subscriptions.first[:attributes][:name]).to eq(@black.name)
        expect(subscriptions.first[:attributes][:status]).to eq("Active")
        expect(subscriptions.second[:id]).to eq(@fruity.id)
        expect(subscriptions.second[:attributes][:name]).to eq(@fruity.name)
        expect(subscriptions.second[:attributes][:status]).to eq("Cancelled")
      end

      it "might return an empty array if customer has no subscriptions" do
        load_test_data 

        get "/api/v1/customers/#{@junior.id}/subscriptions" 

        expect(response).to be_successful
        expect(response.status).to eq(200)

        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(subscriptions).to eq([])
      end
    end

    context "given invalid customer id" do
      it "throws an error that customer was not found" do
        get "/api/v1/customers/1234567/subscriptions" 

        expect(response).to_not be_successful
        expect(response.status).to eq(404)

        error = JSON.parse(response.body, symbolize_names: true)
        expected = {
          errors: [
            detail: "Couldn't find Customer with 'id'=1234567"
          ]
        }
        expect(error).to eq(expected)
      end
    end
  end

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

  describe "update endpoint" do
    context "given a valid customer and subscription" do
      it "can cancel a subscription" do
        load_test_data

        get "/api/v1/customers/#{@sally.id}/subscriptions"
        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(subscriptions.first[:id]).to eq(@black.id)
        expect(subscriptions.first[:attributes][:status]).to eq("Active")

        patch "/api/v1/customers/#{@sally.id}/subscriptions/#{@black.id}", params: {status: "Cancelled"}

        expect(response).to be_successful
        expect(response.status).to eq(200)
        message = JSON.parse(response.body, symbolize_names: true)[:message]
        expect(message).to eq("Subscription Cancelled")

        get "/api/v1/customers/#{@sally.id}/subscriptions"
        subscriptions = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(subscriptions.first[:id]).to eq(@black.id)
        expect(subscriptions.first[:attributes][:status]).to eq("Cancelled")
      end

      xit "can pause a subscription" do

      end

      xit "returns an error if association does not exist" do
        
      end

      xit "throws an error if the given status is not a valid status" do

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