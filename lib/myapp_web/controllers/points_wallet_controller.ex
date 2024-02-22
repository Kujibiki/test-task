defmodule MyappWeb.PointsWalletController do
  use MyappWeb, :controller

  alias Myapp.PointsWallets
  alias Myapp.PointsWallets.PointsWallet

  action_fallback MyappWeb.FallbackController

  def index(conn, _params) do
    points_wallets = PointsWallets.list_points_wallets()
    render(conn, :index, points_wallets: points_wallets)
  end

  def create(conn, %{"points_wallet" => points_wallet_params}) do
    with {:ok, %PointsWallet{} = points_wallet} <- PointsWallets.create_points_wallet(points_wallet_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/points_wallets/#{points_wallet}")
      |> render(:show, points_wallet: points_wallet)
    end
  end

  def show(conn, %{"id" => id}) do
    points_wallet = PointsWallets.get_points_wallet!(id)
    render(conn, :show, points_wallet: points_wallet)
  end

  def update(conn, %{"id" => id, "points_wallet" => points_wallet_params}) do
    points_wallet = PointsWallets.get_points_wallet!(id)

    with {:ok, %PointsWallet{} = points_wallet} <- PointsWallets.update_points_wallet(points_wallet, points_wallet_params) do
      render(conn, :show, points_wallet: points_wallet)
    end
  end

  def delete(conn, %{"id" => id}) do
    points_wallet = PointsWallets.get_points_wallet!(id)

    with {:ok, %PointsWallet{}} <- PointsWallets.delete_points_wallet(points_wallet) do
      send_resp(conn, :no_content, "")
    end
  end
end
