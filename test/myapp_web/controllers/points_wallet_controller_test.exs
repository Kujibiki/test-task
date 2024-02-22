defmodule MyappWeb.PointsWalletControllerTest do
  use MyappWeb.ConnCase

  import Myapp.PointsWalletsFixtures

  alias Myapp.PointsWallets.PointsWallet

  @create_attrs %{
    value: 42
  }
  @update_attrs %{
    value: 43
  }
  @invalid_attrs %{value: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all points_wallets", %{conn: conn} do
      conn = get(conn, ~p"/api/points_wallets")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create points_wallet" do
    test "renders points_wallet when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/points_wallets", points_wallet: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/points_wallets/#{id}")

      assert %{
               "id" => ^id,
               "value" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/points_wallets", points_wallet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update points_wallet" do
    setup [:create_points_wallet]

    test "renders points_wallet when data is valid", %{conn: conn, points_wallet: %PointsWallet{id: id} = points_wallet} do
      conn = put(conn, ~p"/api/points_wallets/#{points_wallet}", points_wallet: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/points_wallets/#{id}")

      assert %{
               "id" => ^id,
               "value" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, points_wallet: points_wallet} do
      conn = put(conn, ~p"/api/points_wallets/#{points_wallet}", points_wallet: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete points_wallet" do
    setup [:create_points_wallet]

    test "deletes chosen points_wallet", %{conn: conn, points_wallet: points_wallet} do
      conn = delete(conn, ~p"/api/points_wallets/#{points_wallet}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/points_wallets/#{points_wallet}")
      end
    end
  end

  defp create_points_wallet(_) do
    points_wallet = points_wallet_fixture()
    %{points_wallet: points_wallet}
  end
end
