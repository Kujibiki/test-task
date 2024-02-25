defmodule MyappWeb.OrderController do
  use MyappWeb, :controller
  alias Myapp.Orders
  alias Myapp.Orders.Order
  alias Myapp.Customers
  alias Myapp.Customers.Customer
  require Logger

  action_fallback MyappWeb.FallbackController

  def index(conn, _params) do
    orders = Orders.list_orders()
    render(conn, :index, orders: orders)
  end

  # Сделать пустую ответку Лишнее удалить


  def create(conn, %{"order" => order_params, "customer" => customer_params}) do
    case Customers.get_customer_by_email_or_phone(customer_params) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json( %{error: "Customer not found"})
      %Customer{} = customer ->
        order_params = put_in(order_params["external_id"], order_params["id"])
        case Myapp.OrderProcessor.award_points(customer,order_params) do
          {:ok, results} ->
            conn
            |> put_status(:created)
            |> json(results)
          _ ->
            conn
            |> put_status(:service_unavailable)
            |> json(%{error: "Something went wrong while calculating points"})
        end
    end
   end

  def create(conn, _) do
    conn
    |> put_status(:bad_request)
    |> json( %{error: "Not enough data in request"})
  end

  def show(conn, %{"id" => id}) do
    order = Orders.get_order!(id)
    render(conn, :show, order: order)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Orders.get_order!(id)

    with {:ok, %Order{} = order} <- Orders.update_order(order, order_params) do
      render(conn, :show, order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Orders.get_order!(id)

    with {:ok, %Order{}} <- Orders.delete_order(order) do
      send_resp(conn, :no_content, "")
    end
  end
end
