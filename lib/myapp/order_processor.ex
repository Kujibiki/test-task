defmodule Myapp.OrderProcessor do

  alias Myapp.Transactions
  alias Myapp.PointsWallets.PointsWallet
  alias Myapp.Orders
  alias Myapp.Orders.Order
  alias Myapp.PointsProcessor
  alias Myapp.Repo

  def award_points(customer,order_params) do
    Repo.transaction fn ->
      with {:ok, %Order{} = order} <- Orders.create_order(customer, order_params) do

        bonus_percentage = customer.grade.bonus_percentage
        order_paid = order.paid
        points_to_earn = floor(order_paid * (bonus_percentage / 100))

        Transactions.create_transaction!(customer, %{value: points_to_earn, sign: true, customer: customer})

        case PointsProcessor.calc_and_update_points_wallet(customer) do
          {:ok, %PointsWallet{}, total_points} -> %{points_to_earn: points_to_earn, total_points: total_points}
          {:error, rest} -> %{error: rest}
        end

      end
    end
  end
end
