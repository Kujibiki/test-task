defmodule MyappWeb.CustomerController do
  use MyappWeb, :controller

  alias Myapp.Customers
  alias Myapp.Customers.Customer

  action_fallback MyappWeb.FallbackController

  def index(conn, _params) do
    customers = Customers.list_customers()
    render(conn, :index, customers: customers)
  end

  def get_points(conn, params) do
    customer = Customers.get_customer_by_email_or_phone(params)
    if(customer == nil) do
      conn
      |> put_status(:not_found)
      |> json( %{error: "Customer not found"})
    end
    total_points = customer.points_wallet.value
    json(conn,%{total_points: total_points})
  end

  def change_grade(conn, %{"grade" => grade_params, "customer" => customer_params}) do
    customer = Customers.get_customer_by_email_or_phone(customer_params)
    if(customer == nil) do
      conn
      |> put_status(:not_found)
      |> json( %{error: "Customer not found"})
    end

    params = %{grade_id: grade_params["id"]}

    with {:ok, %Customer{} = customer} <-Customers.update_customer(customer, params) do
      conn
        |> put_status(:ok)
        |> render(:show, customer: customer)
    end
  end

  def change_grade(conn, _) do
    conn
    |> put_status(:bad_request)
    |> json( %{error: "Not enough data in request"})
  end

  def create(conn, %{"customer" => customer_params}) do
    with {:ok, %Customer{} = customer} <- Customers.create_customer(customer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/customers/#{customer}")
      |> render(:show, customer: customer)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Customers.get_customer!(id)
    render(conn, :show, customer: customer)
  end

  def update(conn, %{"id" => id, "customer" => customer_params}) do
    customer = Customers.get_customer!(id)

    with {:ok, %Customer{} = customer} <- Customers.update_customer(customer, customer_params) do
      render(conn, :show, customer: customer)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Customers.get_customer!(id)

    with {:ok, %Customer{}} <- Customers.delete_customer(customer) do
      send_resp(conn, :no_content, "")
    end
  end
end
