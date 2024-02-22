defmodule MyappWeb.Router do
  use MyappWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MyappWeb do
    pipe_through :api
    get "/customers/points/" , CustomerController, :get_points
    post "/customers/grade" , CustomerController, :change_grade
    post "/orders/new/", OrderController, :create
    post "/transactions/new/", TransactionController, :create
    get "/grades" , GradeController, :index
  end
end
