require "rails_helper" 

RSpec.describe SubscriptionSerializer do
  it "returns hash of subscriptions for a given customer" do
    load_test_data
    serializer = SubscriptionSerializer.new(@sally.subscriptions, params: {customer: @sally})

    expected = {
      data: [
        {
          :id=>@black.id.to_s, 
          :type=>"subscription", 
          :attributes=>{
            :name=>"Black Tea Pack", 
            :price=>20.37, 
            :frequency=>"Monthly",
            :status=>"Active"}
        },
        {
          :id=>@fruity.id.to_s, 
          :type=>"subscription", 
          :attributes=>{
            :name=>"Fruity Tea Pack", 
            :price=>24.64, 
            :frequency=>"Annual",
            :status=>"Cancelled"}
        }
      ]
    }

    expect(serializer.to_json).to eq(expected.to_json)
  end
end