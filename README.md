# Tea Subscriptions

This project is a RESTful API to for a tea subscription service.

## Versions
Ruby 3.2.2
Rails 7.0.8

## Installation
Fork and clone this repository
Install all gems
```
bundle exec install
```
Create the database
```
rails db:{create,migrate}
```
Run the test suite. There should be n passing tests
```
bundle exec rspec
# input return here
```

## Endpoints
### Subscribe a customer to a subscription
### Cancel a customer's subscription
### See all of a customer's subscriptions

## Planning and Setup
### Database Schema
Teas - stores information about individual tea blends
- Blend Name
- Type (e.g.; "Black", "Green", "White", "Herbal", "Mixed")
- Description
- Brew Temperature
- Brew Time

Customers - stores information about individual customers
- First Name
- Last Name
- Email
- Street Address
- City
- State
- Zip

Subscriptions - stores information about offered subscription packages
- Name
- Price
- Frequency

SubscriptionTeas - associates subscriptions with the teas included in the subscription service
- Subscription_id
- Tea_id

CustomerSubscriptions - associates customers with their subscriptions
- Customer_id
- Subscription_id