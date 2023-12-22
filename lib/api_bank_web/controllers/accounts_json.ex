defmodule ApiBankWeb.AccountsJSON do
  alias ApiBank.Banks.Accounts

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(accounts <- accounts, do: data(accounts))}
  end

  @doc """
  Renders a single accounts.
  """
  def show(%{accounts: accounts}) do
    %{data: data(accounts)}
  end

  defp data(%Accounts{} = accounts) do
    %{
      id: accounts.id,
      number: accounts.number,
      owner: accounts.owner,
      balance: accounts.balance
    }
  end
end
