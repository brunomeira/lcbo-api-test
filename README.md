## Overview
This small project allows users to fetch products, by keyword, registered on https://lcboapi.com/ and also to use a "I am feeling lucky" button.

We are allowing users to sign up, in which case we register a history of actions taken by them. The actions registered are split in 2 different groups, viewed products and searched products. For the case where user is signed in, the "I am feeling lucky" feature will not send already viewed products.

## Tech Stack
1. Redis
2. PostgreSQL
3. Ruby On Rails
4. React

## Documentation
Documentation can be found on https://brunomeira.github.io/lcbo-api-test/

## Tests
This project is using Rspec for Unit tests. Ideally we should write functional tests too. This can be done in the future.
Files that have test coverage:
1. All service entities
2. All NoSQL models

To run test suite, please run 
```
rspec spec
```

## User flow
The diagrams below will give you a quick overview on how the app works for two different scenarios. Other scenarios follow a very similar approach. 

1. Feeling Lucky
![feeling_lucky](https://github.com/brunomeira/lcbo-api-test/blob/master/docs/diagrams/feeling_lucky.png)
2. Fetch Products
![fetch_products](https://github.com/brunomeira/lcbo-api-test/blob/master/docs/diagrams/fetch_products.png)

## Make Sure
1. Your secrets.yml contains lcbo_api_access_key with a valid key from www.lcboapi.com
1.1 Rename secrets_template.yml to secrets.yml and add your LCBO api key
2. Postgres is up and running
2.1 Rename database_template.yml to database.yml and add your username and password
3. Redis is up and running
