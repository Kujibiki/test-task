defmodule Myapp.PointsWallets do
  @moduledoc """
  The PointsWallets context.
  """

  import Ecto.Query, warn: false
  alias Myapp.Repo

  alias Myapp.PointsWallets.PointsWallet

  @doc """
  Returns the list of points_wallets.

  ## Examples

      iex> list_points_wallets()
      [%PointsWallet{}, ...]

  """
  def list_points_wallets do
    Repo.all(PointsWallet)
  end

  @doc """
  Gets a single points_wallet.

  Raises `Ecto.NoResultsError` if the Points wallet does not exist.

  ## Examples

      iex> get_points_wallet!(123)
      %PointsWallet{}

      iex> get_points_wallet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_points_wallet!(id), do: Repo.get!(PointsWallet, id)

  @doc """
  Creates a points_wallet.

  ## Examples

      iex> create_points_wallet(%{field: value})
      {:ok, %PointsWallet{}}

      iex> create_points_wallet(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_points_wallet(attrs \\ %{}) do
    %PointsWallet{}
    |> PointsWallet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a points_wallet.

  ## Examples

      iex> update_points_wallet(points_wallet, %{field: new_value})
      {:ok, %PointsWallet{}}

      iex> update_points_wallet(points_wallet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_points_wallet(%PointsWallet{} = points_wallet, attrs) do
    points_wallet
    |> PointsWallet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a points_wallet.

  ## Examples

      iex> delete_points_wallet(points_wallet)
      {:ok, %PointsWallet{}}

      iex> delete_points_wallet(points_wallet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_points_wallet(%PointsWallet{} = points_wallet) do
    Repo.delete(points_wallet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking points_wallet changes.

  ## Examples

      iex> change_points_wallet(points_wallet)
      %Ecto.Changeset{data: %PointsWallet{}}

  """
  def change_points_wallet!(%PointsWallet{} = points_wallet, attrs \\ %{}) do
    PointsWallet.changeset(points_wallet, attrs)
  end
end
