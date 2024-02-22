defmodule Myapp.PointsProcessor do

  alias Myapp.Transactions
  alias Myapp.Transactions.Transaction

  def calculate_points_balance (customer) do
    transactions = Transactions.get_transaction_by_customer_id(customer.id)
    Enum.reduce(transactions, 0, fn %{value: value, sign: sign}, acc ->
      operation = sign && 1 || -1
      acc + value * operation
    end)
  end
end
