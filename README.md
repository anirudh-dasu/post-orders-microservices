# Post Orders Microservices

A sample setup to show how to handle and setup a microservices architecture using Ruby and RabbitMQ without any frameworks. 

Gems used are
  - [Sequel] - ORM for database connections
  - [Rack] - Thin webserver
  - [Rake] - Build utility for ruby
  - [Bunny] - Ruby client for RabbitMQ
  - [Hanami Router] - Simple DSL router for Ruby
  - [Hanami Controller] - Simple micro controller library for Ruby

# How it works

  - order-microservice exposes an API **/orders** for order creation
  - Once an order is created and stored in the db, its pushed to **orders** RabbitMQ queue
  - invoice-microservice consumes from the orders queue, generates an invoice, stores in db and pushes the order+invoice payload to two queues - **invoices_sms** and **invoices_email**
  - email-microservice and sms-microservice consume from their respective queues and send email/sms

# Set up locally
- Install rabbitmq, ruby, postgresql and clone the repo. Make sure rabbitmq service is running
- Create postgresql databases orders and invoices
```
createdb orders
createdb invoices
```
- Install the gems in each service
```
cd order-microservice
bundle install
cd ../invoice-microservice
bundle install
cd ../email-microservice
bundle install
cd ../sms-microservice
bundle install
```
- Start the server in the order-microservice and consumers in the other services, each in their own bash sessions
```
cd order-microservice
rackup --port 3000

cd invoice-microservice
rake consumer_orders

cd email-microservice
rake consume_invoices

cd sms-microservice
rake consume_invoices

```

- Make a POST call to the orders-service to create an order and see it pass through the queues till both an sms and email can be generated
```
curl -X POST -d '{"product_name": "jeans","quantity":"17","email":"example@gmail.com","phone":"9999999999","address": "asdasda"}' http://localhost:3000/order -H "Content-Type: application/json"

```


[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)
   [Sequel]: <https://github.com/jeremyevans/sequel>
   [Rack]: <https://github.com/rack/rack>
   [Rake]: <https://github.com/ruby/rake>
   [Bunny]: <https://github.com/ruby-amqp/bunny/>
   [Hanami Router]: <https://github.com/hanami/router>
   [Hanami Controller]: <https://github.com/hanami/controller>
