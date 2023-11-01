# Tea Subscriptions

This project is a RESTful API for a tea subscription service.

## Versions
- Ruby 3.2.2
- Rails 7.0.8

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
POST to CustomerSubscriptions
### Cancel a customer's subscription
DESTROY CustomerSubscriptions
### See all of a customer's subscriptions
GET CustomerSubscriptions

## Planning and Setup
### Database Schema
Teas - stores information about individual tea blends
- Blend Name
- Tea Type ("Black", "Green", "White", "Herbal", or "Blended")
- Description
- Brew Temperature (in degrees Fahrenheit)
- Brew Time (in minutes)

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
- Price (in USD)
- Frequency

SubscriptionTeas - associates subscriptions with the teas included in the subscription service
- Subscription_id
- Tea_id

CustomerSubscriptions - associates customers with their subscriptions
- Customer_id
- Subscription_id


## Thoughts For Future Work
### Schema
#### Teas
Brewing temperature and time for teas is usually based on the type of tea. For example, black and herbal teas are brewed at 200-212 F, whereas green teas are brewed at 160-180. Instead of having columns in the tea table for brewing instructions (where instructions will end up repetetive across all teas of the same type) this information could instead be extracted to a different table, such as "Brewing Instructions". Then, one row for black teas in Brewing Instructions could be associated with all black teas in the Teas table.

#### CustomerSubscriptions
Sometimes subscriptions can have different statuses. For example, it might be pending if a customer's credit card has not gone through. Or, it could be paused, such as if a customer is going out of town for a little while.

#### Subscriptions
Subscriptions can sometimes be seasonal. Maybe there are some subscriptions only available in spring/summer due to availability of ingredients. Or maybe there is an autumn special with a lot of cinnamon and pumpkin spice inspired blends. Appropriate columns could be added to the Subscriptions table to account for this. On this note, a possible sad path to test for is when a customer tries to subscribe to a subscription that is not currently available.

### Endpoints
- Create teas, subscriptions, and customers
- Update teas, subscriptions, and customers
- List of all available subscriptions and the teas belonging to them (so a user could browse and choose a subscription)
  - Ability to search for subscriptions by frequency, price, or teas included in them
- Add or remove teas from a subscription
- List of teas, with the subscriptions that include them