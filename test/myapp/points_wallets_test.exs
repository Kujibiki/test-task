defmodule Myapp.PointsWalletsTest do
  use Myapp.DataCase

  alias Myapp.PointsWallets

  describe "points_wallets" do
    alias Myapp.PointsWallets.PointsWallet

    import Myapp.PointsWalletsFixtures

    @invalid_attrs %{value: nil}

    test "list_points_wallets/0 returns all points_wallets" do
      points_wallet = points_wallet_fixture()
      assert PointsWallets.list_points_wallets() == [points_wallet]
    end

    test "get_points_wallet!/1 returns the points_wallet with given id" do
      points_wallet = points_wallet_fixture()
      assert PointsWallets.get_points_wallet!(points_wallet.id) == points_wallet
    end

    test "create_points_wallet/1 with valid data creates a points_wallet" do
      valid_attrs = %{value: 42}

      assert {:ok, %PointsWallet{} = points_wallet} = PointsWallets.create_points_wallet(valid_attrs)
      assert points_wallet.value == 42
    end

    test "create_points_wallet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PointsWallets.create_points_wallet(@invalid_attrs)
    end

    test "update_points_wallet/2 with valid data updates the points_wallet" do
      points_wallet = points_wallet_fixture()
      update_attrs = %{value: 43}

      assert {:ok, %PointsWallet{} = points_wallet} = PointsWallets.update_points_wallet(points_wallet, update_attrs)
      assert points_wallet.value == 43
    end

    test "update_points_wallet/2 with invalid data returns error changeset" do
      points_wallet = points_wallet_fixture()
      assert {:error, %Ecto.Changeset{}} = PointsWallets.update_points_wallet(points_wallet, @invalid_attrs)
      assert points_wallet == PointsWallets.get_points_wallet!(points_wallet.id)
    end

    test "delete_points_wallet/1 deletes the points_wallet" do
      points_wallet = points_wallet_fixture()
      assert {:ok, %PointsWallet{}} = PointsWallets.delete_points_wallet(points_wallet)
      assert_raise Ecto.NoResultsError, fn -> PointsWallets.get_points_wallet!(points_wallet.id) end
    end

    test "change_points_wallet/1 returns a points_wallet changeset" do
      points_wallet = points_wallet_fixture()
      assert %Ecto.Changeset{} = PointsWallets.change_points_wallet(points_wallet)
    end
  end
end
