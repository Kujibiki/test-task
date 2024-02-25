defmodule MyappWeb.TransactionController do
  use MyappWeb, :controller

  alias Myapp.Transactions
  alias Myapp.Transactions.Transaction
  alias Myapp.Customers
  alias Myapp.Customers.Customer
  alias Myapp.PointsWallets
  alias Myapp.PointsWallets.PointsWallet
  alias Myapp.OrderProcessor
  alias Myapp.PointsProcessor

  action_fallback MyappWeb.FallbackController

  def index(conn, _params) do
    transaction = Transactions.list_transaction()
    render(conn, :index, transaction: transaction)
  end

  def create(conn, %{"transaction" => transaction_params, "customer" => customer_params}) do
    case Customers.get_customer_by_email_or_phone(customer_params) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json( %{error: "Customer not found"})
      %Customer{} = customer ->
        changeset = Transaction.changeset(%Transaction{}, transaction_params)
        if(not changeset.valid?) do
          conn
          |> put_status(:bad_request)
          |> json( %{error: "Transaction data is invalid"})
        else
          current_points_balance = customer.points_wallet.value
          transaction_value = transaction_params["value"]

          transaction_value = case is_binary(transaction_value) do
            true -> String.to_integer(transaction_value)
            _ -> transaction_value
          end

          if(!transaction_params["sign"] && (current_points_balance < transaction_value)) do
            conn
            |> put_status(:not_acceptable)
            |> json( %{error: "insufficient points balance"})
          else
            Myapp.Repo.transaction fn ->
              with {:ok, %Transaction{} = _transaction} <- Transactions.create_transaction!(customer,transaction_params) do
                PointsProcessor.calc_and_update_points_wallet(customer)
                conn
                |> put_status(:created)
                |> json( %{message: "Transaction created"})
              end
            end
          end
        end
      end
  end


  def create(conn, _) do
    conn
    |> put_status(:bad_request)
    |> json( %{error: "Not enough data in request"})
  end

  def show(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)
    render(conn, :show, transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Transactions.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <- Transactions.update_transaction(transaction, transaction_params) do
      render(conn, :show, transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Transactions.get_transaction!(id)

    with {:ok, %Transaction{}} <- Transactions.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
