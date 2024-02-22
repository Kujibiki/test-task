defmodule MyappWeb.BalanceJSON do
  alias Myapp.Balances.Balance

  @doc """
  Renders a list of balances.
  """
  def index(%{balances: balances}) do
    %{data: for(balance <- balances, do: data(balance))}
  end

  @doc """
  Renders a single balance.
  """
  def show(%{balance: balance}) do
    %{data: data(balance)}
  end

  defp data(%Balance{} = balance) do
    %{
      id: balance.id,
      value: balance.value,
      currency: balance.currency
    }
  end
end
