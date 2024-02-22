defmodule MyappWeb.BalanceController do
  use MyappWeb, :controller

  alias Myapp.Balances
  alias Myapp.Balances.Balance

  action_fallback MyappWeb.FallbackController

  def index(conn, _params) do
    balances = Balances.list_balances()
    render(conn, :index, balances: balances)
  end

  def create(conn, %{"balance" => balance_params}) do
    with {:ok, %Balance{} = balance} <- Balances.create_balance(balance_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/balances/#{balance}")
      |> render(:show, balance: balance)
    end
  end

  def show(conn, %{"id" => id}) do
    balance = Balances.get_balance!(id)
    render(conn, :show, balance: balance)
  end

  def update(conn, %{"id" => id, "balance" => balance_params}) do
    balance = Balances.get_balance!(id)

    with {:ok, %Balance{} = balance} <- Balances.update_balance(balance, balance_params) do
      render(conn, :show, balance: balance)
    end
  end

  def delete(conn, %{"id" => id}) do
    balance = Balances.get_balance!(id)

    with {:ok, %Balance{}} <- Balances.delete_balance(balance) do
      send_resp(conn, :no_content, "")
    end
  end
end
