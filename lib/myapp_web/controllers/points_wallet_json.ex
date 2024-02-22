defmodule MyappWeb.PointsWalletJSON do
  alias Myapp.PointsWallets.PointsWallet

  @doc """
  Renders a list of points_wallets.
  """
  def index(%{points_wallets: points_wallets}) do
    %{data: for(points_wallet <- points_wallets, do: data(points_wallet))}
  end

  @doc """
  Renders a single points_wallet.
  """
  def show(%{points_wallet: points_wallet}) do
    %{data: data(points_wallet)}
  end

  defp data(%PointsWallet{} = points_wallet) do
    %{
      id: points_wallet.id,
      value: points_wallet.value
    }
  end
end
