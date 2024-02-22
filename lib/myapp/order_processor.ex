defmodule Myapp.OrderProcessor do

  alias Myapp.Transactions
  alias Myapp.Transactions.Transaction
  alias Myapp.PointsWallets
  alias Myapp.PointsWallets.PointsWallet
  alias Myapp.Orders
  alias Myapp.Orders.Order
  alias Myapp.PointsProcessor
  alias Myapp.Repo

  def award_points(customer,order_params) do
    Myapp.Repo.transaction fn ->
      with {:ok, %Order{} = order} <- Orders.create_order(customer, order_params) do

        bonus_percentage = customer.grade.bonus_percentage
        order_paid = order.paid
        points_to_earn = floor(order_paid * (bonus_percentage / 100))

        Transactions.create_transaction!(customer, %{value: points_to_earn, sign: true, customer: customer})
        point_wallet = PointsWallets.get_points_wallet!(customer.points_wallet.id) #most fresh wallet
        total_points = PointsProcessor.calculate_points_balance(customer)
        PointsWallets.update_points_wallet!(point_wallet,%{value: total_points}) #race condition point

        %{earned_points: points_to_earn, total_points: total_points}
      end
    end
  end
end
