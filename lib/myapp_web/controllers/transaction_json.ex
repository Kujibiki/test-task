defmodule MyappWeb.TransactionJSON do
  alias Myapp.Transactions.Transaction

  @doc """
  Renders a list of transation.
  """
  def index(%{transation: transaction}) do
    %{data: for(transaction <- transaction, do: data(transaction))}
  end

  @doc """
  Renders a single transaction.
  """
  def show(%{transaction: transaction}) do
    %{data: data(transaction)}
  end

  defp data(%Transaction{} = transaction) do
    %{
      id: transaction.id,
      value: transaction.value,
      sign: transaction.sign,
    }
  end
end
