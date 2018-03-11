# README

Hello! This is an api which will service a trello like application. Through this API, a client will have the ability to:

    * Create a list
    * Create a card for a list
    * Move a card from one list to another
    * Set a due date on a card
    * See if a card is due in the next 3 days
    * See if a card is overdue

## Installation

Starting off you'll need to clone the application and bundle. In your command line please do the following:

    git clone && cd 
    bundle install
    
## Tests
    
To run all the tests associated with this repository:
    
    bundle exec rspec
    
The request specs will test all of the endpoints are working as expected. To run these tests:
    
    bundle exec rspec spec/requests
    
To test the models are set up in the correct way:
    
    bundle exec rspec spec/models
    
## Endpoints

These are all the endpoints this api requires along with their request parameters. Please see the section responses for
example responses

#### Retrieve all the lists
    GET /lists

#### Create a list
    POST /lists
    
Parameters:

    | name | data type | required_or_optional | description |
    | ---- | --------- | -------------------- | ----------- |
    | name | string    | required             | the name of your list |
    
#### Retrieve a list
    GET /lists/:id    
     
Parameters:
    
    | name | data type | required_or_optional | description |
    | ---- | --------- | -------------------- | ----------- |
    | id | integer | required | id of your list |
    
#### Retrieve all the cards for a list
    GET /lists/:id/cards
    
Parameters:
    
    | name | data type | required_or_optional | description |
    | ---- | --------- | -------------------- | ----------- |
    | id | integer | required | id of your list |
        
#### Retrieve a card from a list
    GET /lists/:id/cards/:card_id       
     
Parameters:
    
    | name | data type | required_or_optional | description |
    | ---- | --------- | -------------------- | ----------- |
    | id | integer | required | id of your list |
    | card_id | integer | required | id of your the card|
    
        
#### Create a card for a list
    POST /lists/:id/cards

Parameters:

    | name | data type | required_or_optional | description |
    | ---- | --------- | -------------------- | ----------- |
    | title | string    | required             | the title of your card |
    | description | string    | required             | the title of your card |
    | due_date | date    | optional             | the date for which your card is to be completed by. Can not be in the past |
    | id | integer | required | id of your list |
    | card_id | integer | required | id of your the card|

    
#### Update a card for a list
        
    PUT /lists/:id/cards/:card_id
    
Parameters:

    | name | data type | required_or_optional | description |
    | ---- | --------- | -------------------- | ----------- |
    | title | string    | required             | the title of your card |
    | description | string    | required             | the title of your card |
    | due_date | date    | optional             | the date for which your card is to be completed by |
    | id | integer | required | id of your list |
    | card_id | integer | required | id of your the card|
    
#### Responses
    
**List** response body example:
    
    { 
        "id":1,
        "name":"foo",
        "created_at":"2018-03-11T09:34:48.164Z",
        "updated_at":"2018-03-11T09:34:48.164Z"
    }
    
**Card** response body example:

    {
        "id":1,
        "title":"bar",
        "description": "Duis ornare, neque vel tincidunt suscipit, risus velit venenatis augue, nec consectetur",
        "due_date":"2018-03-18",
        "due_date_soon":false,
        "overdue":false,
        "created_at":"2018-03-11T09:35:23.643Z",
        "updated_at":"2018-03-11T02:35:23.643Z",
        "list_id":1
    }
    