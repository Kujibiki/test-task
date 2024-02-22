# Myapp

Some Test task.
  * Get to know Elixir and Phoenix - done
  * Main task - done
  * Extra task - done

I decided to use Elixir for this project. It was the first time I used it. The Postgres database contains a list of users, each user has a Grade which determines how many percent of the order is awarded to him in the form of points. The Grade of a user can be changed. The accrual is done in a transactional style. The current number of points is stored in a separate table. For data consistency, the Transactions database mechanism and Optimistic Locks are used during changes to the wallet.

Process new order example 
curl --location --request POST 'http://localhost:4000/api/orders/new' \
--header 'Content-Type: application/json' \
--data-raw '{
    "order" : {"id": "4dd6bc88-1b33-46ad-aa3f-a58a3fa06ac3", "paid": 9546, "currency": "jpy"},
    "customer" : {"email": "someemail3@test.com", "phone": "76734545234"}
}'

Fetch available grades example 
curl --location --request GET 'http://localhost:4000/api/grades' 

Change Grade Example
curl --location --request POST 'http://localhost:4000/api/customers/grade' \
--header 'Content-Type: application/json' \
--data '{
    "grade" : {"id": "8c630efb-1079-4b7a-9efa-54a9be82f642"},
    "customer" : {"phone": "76734545234"}
}'

Fetch points
curl --location --request GET 'http://localhost:4000/api/customers/points/?email=someemail3%40test.com

Add \ deduct point. Depends on sign {true: add points, false: deduct} Example
curl --location --request POST 'http://localhost:4000/api/transactions/new' \
--header 'Content-Type: application/json' \
--data '{
    "transaction" : {"value": 10, "sign": false},
    "customer" : {"phone": "76734545234"}
}'


To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Run `mix ecto.migrate` to setup database
  * Run `mix run priv/repo/seeds.exs` to seed database
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


