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

    should return an array of lists
#### Create a list
    POST /lists
    
Parameters:

 | name | data type | required or optional | description |
 | ---- | --------- | -------------------- | ----------- |
 | name | string    | required             | the name of your list |
 
should return the list object you created
    
#### Retrieve a list
    GET /lists/:id    
     
Parameters:
    
| name | data type | required_or_optional | description |
| ---- | --------- | -------------------- | ----------- |
| id | integer | required | id of the list you want to get |
    
should the list object

#### Retrieve all the cards for a list
    GET /lists/:id/cards
    
Parameters:
    
| name | data type | required or optional | description |
| ---- | --------- | -------------------- |          --- |
| id | integer | required | id of your list you want to retrieve all the cards from |
        
#### Retrieve a card from a list
    GET /lists/:id/cards/:card_id
    
should return the card object from a list
     
Parameters:
    
| name | data type | required or optional | description |
| ---- | --------- | -------------------- | ----------- |
| id | integer | required | id of your list |
| card_id | integer | required | id of your the card you want to find|
    
        
#### Create a card for a list
    POST /lists/:id/cards

Parameters:

| name | data type | required or optional | description |
| ---- | --------- | -------------------- | ----------- |
| title | string    | required             | the title of your card |
| description | string    | required             | the title of your card |
| due_date | date    | optional             | the date for which your card is to be completed by. Can not be in the past |
| id | integer | required | id of your list |

 should return the card object you created
    
#### Update a card for a list
        
    PUT /lists/:id/cards/:card_id
    
Parameters:

| name | data type | required or optional | description |
| ---- | --------- | -------------------- | ----------- |
| title | string    | required             | the title of your card |
| description | string    | required             | the title of your card |
| due_date | date    | optional             | the date for which your card is to be completed by |
| id | integer | required | id of your list |
| card_id | integer | required | id of your the card you want to update|

 should return the card object you updated

#### Move a card from one list to another

    PUT /cards/:id/change_list/:list_id
    
Parameters:
    
| name | data type | required_or_optional | description |
| ---- | --------- | -------------------- | ----------- |
| id | integer | required | id of your card |
| list_id | integer | required | id of your the list you are moving it to|

 should return the card object with an updated list_id

#### Delete a card from a list

    DELETE /lists/:id/cards/:card_id

Parameters:
 
| name | data type | required_or_optional | description |
| ---- | --------- | -------------------- | ----------- |
| id | integer | required | id of your list |
| card_id | integer | required | id of your the card you want to delete|

should return nothing

## Responses

These are examples for the response body for a list or card you can expect from successful request.
    
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
        "updated_at":"2018-03-11T09:35:23.643Z",
        "list_id":1
    }
    
## Rake task

I've added a rake task to update a cards status and it can be run by the following command:

    rake card_status:update

This will update card and will determine whether the due date is soon or whether it is overdue. This could be run daily on a cron job.    
