defmodule Myapp.PointsProcessor do

  alias Myapp.Transactions
  alias Myapp.PointsWallets
  alias Myapp.PointsWallets.PointsWallet

  def calc_and_update_points_wallet (customer) do
    transactions = Transactions.get_transaction_by_customer_id(customer.id)

    total_points = Enum.reduce(transactions, 0, fn %{value: value, sign: sign}, acc ->
      operation = sign && 1 || -1
      acc + value * operation
    end)

    point_wallet = PointsWallets.get_points_wallet!(customer.points_wallet.id) #most fresh wallet

    case PointsWallets.update_points_wallet(point_wallet,%{value: total_points}) do #race condition point
      {:ok, %PointsWallet{}} -> {:ok, %PointsWallet{},total_points}
      {:error, %Ecto.Changeset{}} -> {:error, %Ecto.Changeset{}}
    end

  end
end
