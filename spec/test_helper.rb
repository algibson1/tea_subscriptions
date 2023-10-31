def load_test_data 
  @sally = Customer.create!(first_name: "Sally", last_name: "Johnson", email: "example@test.com", street_address: "1234 Some Street", city: "Littleton", state: "CO", zip: "80125")
  @joseph = Customer.create!(first_name: "Joseph", last_name: "Johnson", email: "example@test.com", street_address: "1234 Some Street", city: "Littleton", state: "CO", zip: "80125")
  @junior = Customer.create!(first_name: "Junior", last_name: "Johnson", email: "example@test.com", street_address: "1234 Some Street", city: "Littleton", state: "CO", zip: "80125")
  @ally = Customer.create!(first_name: "Ally", last_name: "Johnson", email: "example@test.com", street_address: "1234 Some Street", city: "Littleton", state: "CO", zip: "80125")
  @Elly = Customer.create!(first_name: "Elly", last_name: "Johnson", email: "example@test.com", street_address: "1234 Some Street", city: "Littleton", state: "CO", zip: "80125")

  @spades = Tea.create!(blend_name: "Spades", type: "Black", description: "Elderberry, huckleberry, vanilla and anise", brew_temperature: 200, brew_time: 5)
  @hearts = Tea.create!(blend_name: "Hearts", type: "Black", description: "Sweet, with strawberry and rose", brew_temperature: 200, brew_time: 5)
  @diamonds = Tea.create!(blend_name: "Diamonds", type: "Black", description: "Apple, pomegranate and spices", brew_temperature: 200, brew_time: 5)
  @clubs = Tea.create!(blend_name: "Clubs", type: "Black", description: "Rose, violet, jasmine", brew_temperature: 200, brew_time: 5)
  @tabby = Tea.create!(blend_name: "Tabby", type: "Green", description: "Raspberry, lime", brew_temperature: 160, brew_time: 3)
  @ragdoll = Tea.create!(blend_name: "Ragdoll", type: "Green", description: "Apple, Jasmine", brew_temperature: 160, brew_time: 3)
  @maine_coon = Tea.create!(blend_name: "Maine Coon", type: "Green", description: "Mint, ginger", brew_temperature: 160, brew_time: 3)
  @sphynx = Tea.create!(blend_name: "Sphynx", type: "Green", description: "Earthy blend, with pomegranate and clove", brew_temperature: 160, brew_time: 3)

  @black = Subscription.create!(name: "Black Tea Pack", price: 20.37, frequency: "Monthly")
  @green = Subscription.create!(name: "Green Tea Pack", price: 20.37, frequency: "Weekly")
  @fruity = Subscription.create!(name: "Fruity Tea Pack", price: 24.64, frequency: "Annual")
  @floral = Subscription.create!(name: "Floral Tea Pack", price: 25.43, frequency: "Monthly")

  SubscriptionTea.create!(subscription: @black, tea: @spades)
  SubscriptionTea.create!(subscription: @black, tea: @hearts)
  SubscriptionTea.create!(subscription: @black, tea: @diamonds)
  SubscriptionTea.create!(subscription: @black, tea: @clubs)

  SubscriptionTea.create!(subscription: @green, tea: @tabby)
  SubscriptionTea.create!(subscription: @green, tea: @ragdoll)
  SubscriptionTea.create!(subscription: @green, tea: @maine_coon)
  SubscriptionTea.create!(subscription: @green, tea: @sphynx)

  SubscriptionTea.create!(subscription: @fruity, tea: @spades)
  SubscriptionTea.create!(subscription: @fruity, tea: @hearts)
  SubscriptionTea.create!(subscription: @fruity, tea: @diamonds)
  SubscriptionTea.create!(subscription: @fruity, tea: @tabby)
  SubscriptionTea.create!(subscription: @fruity, tea: @ragdoll)

  SubscriptionTea.create!(subscription: @floral, tea: @hearts)
  SubscriptionTea.create!(subscription: @floral, tea: @clubs)
  SubscriptionTea.create!(subscription: @floral, tea: @ragdoll)

  CustomerSubscription.create!(customer: @sally, subscription: @black)
  CustomerSubscription.create!(customer: @sally, subscription: @fruity)
  CustomerSubscription.create!(customer: @joseph, subscription: @black)
  CustomerSubscription.create!(customer: @ally, subscription: @black)
  CustomerSubscription.create!(customer: @ally, subscription: @floral)
end