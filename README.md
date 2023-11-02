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
Run the test suite. There should be 30 passing tests
```
bundle exec rspec
# 30 examples, 0 failures
```

## Endpoints
### Subscribe a customer to a subscription
Creates a row on CustomerSubscriptions table to associate a customer with a subscription. Status of the subscription will be "Active" by default. 

Example Request:
```ruby
post "/api/v1/customers/4/subscriptions", params: {subscription_id: 3}
```
Successful Response:
```json
{
  "message": "Successfully subscribed!"
}
```

### Update the status of a customer's subscription (Cancel or Pause)
Updates the status of an existing subscription to "Cancelled" or "Paused".

Example Request: 
```ruby
patch "/api/v1/customers/3/subscriptions/1", params: {status: "Cancelled"}
```
Successful Response:
```json
{
    "message": "Subscription Cancelled"
}
```

### See all of a customer's subscriptions
Returns list of all of a given customer's subscriptions, including their statuses.

Example Request:
```ruby
get "/api/v1/customers/3/subscriptions" 
```
Example Response:
```json
{
    "data": [
        {
            "id": 1,
            "type": "subscription",
            "attributes": {
                "name": "Black Tea Pack",
                "price": 20.37,
                "frequency": "Monthly",
                "status": "Cancelled"
            }
        },
        {
            "id": 2,
            "type": "subscription",
            "attributes": {
                "name": "Green Tea Pack",
                "price": 20.37,
                "frequency": "Weekly",
                "status": "Active"
            }
        },
        {
            "id": 3,
            "type": "subscription",
            "attributes": {
                "name": "Fruity Tea Pack",
                "price": 24.64,
                "frequency": "Annual",
                "status": "Cancelled"
            }
        }
    ]
}
```

## Planning and Setup
### Database Schema

![visual of schema design](/assets/images/tea_subscriptions_schema.png)

Teas - stores information about individual tea blends
- Blend Name
- Tea Type ("Black", "Green", "White", "Herbal", "Blended")
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
- Status ("Active", "Cancelled", "Paused")


## Thoughts For Future Work
### Schema
#### Teas
Brewing temperature and time for teas is usually based on the type of tea. For example, black and herbal teas are brewed at 200-212 F, whereas green teas are brewed at 160-180. Instead of having columns in the tea table for brewing instructions (where instructions will end up repetetive across all teas of the same type) this information could instead be extracted to a different table, such as "Brewing Instructions". Then, one row for black teas in Brewing Instructions could be associated with all black teas in the Teas table.

#### CustomerSubscriptions
Currently, "Paused" is included as a valid status option. This may be useful for customers who are going out of town for a little while, but want their subscription to resume eventually. An additional column such as "Reactivation Date" would be useful, as well as background workers that make sure that any "Paused" subscription is changed to "Active" when the reactivation date is reached.

#### Subscriptions
Subscriptions can sometimes be seasonal. Maybe there are some subscriptions only available in spring/summer due to availability of ingredients. Or maybe there is an autumn special with a lot of cinnamon and pumpkin spice inspired blends. Appropriate columns could be added to the Subscriptions table to account for this. On this note, a possible sad path to test for is when a customer tries to subscribe to a subscription that is not currently available.

### Endpoints
- Create teas, subscriptions, and customers
- Update details of teas, subscriptions, and customers
  - Ability for customer to create a custom subscription of the specific teas they want. Subscription has column to denote whether it's a company-offered subscription package or a custom package, and custom packages do not show up in an index of subscriptions visible to other customers
- Get list of all available subscriptions and the teas belonging to them (so a user could browse and choose a subscription)
  - Ability to search for subscriptions by frequency, price, or teas included in them
- Add or remove teas from a subscription package
- List of teas, with subscriptions that include them
- When a customer subscribes to a subscription they've previously subscribed to and then cancelled in the past, the status is updated on the old record, rather than the record being completely replaced by a new active subscription