defmodule MyappWeb.BalanceControllerTest do
  use MyappWeb.ConnCase

  import Myapp.BalancesFixtures

  alias Myapp.Balances.Balance

  @create_attrs %{
    value: 42,
    currency: "some currency",
    points: 42
  }
  @update_attrs %{
    value: 43,
    currency: "some updated currency",
    points: 43
  }
  @invalid_attrs %{value: nil, currency: nil, points: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all balances", %{conn: conn} do
      conn = get(conn, ~p"/api/balances")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create balance" do
    test "renders balance when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/balances", balance: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/balances/#{id}")

      assert %{
               "id" => ^id,
               "currency" => "some currency",
               "points" => 42,
               "value" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/balances", balance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update balance" do
    setup [:create_balance]

    test "renders balance when data is valid", %{conn: conn, balance: %Balance{id: id} = balance} do
      conn = put(conn, ~p"/api/balances/#{balance}", balance: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/balances/#{id}")

      assert %{
               "id" => ^id,
               "currency" => "some updated currency",
               "points" => 43,
               "value" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, balance: balance} do
      conn = put(conn, ~p"/api/balances/#{balance}", balance: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete balance" do
    setup [:create_balance]

    test "deletes chosen balance", %{conn: conn, balance: balance} do
      conn = delete(conn, ~p"/api/balances/#{balance}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/balances/#{balance}")
      end
    end
  end

  defp create_balance(_) do
    balance = balance_fixture()
    %{balance: balance}
  end
end
