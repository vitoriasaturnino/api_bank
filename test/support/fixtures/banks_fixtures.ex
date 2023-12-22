defmodule ApiBank.BanksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApiBank.Banks` context.
  """

  @doc """
  Generate a accounts.
  """
  def accounts_fixture(attrs \\ %{}) do
    {:ok, accounts} =
      attrs
      |> Enum.into(%{
        balance: 42,
        number: "some number",
        owner: "some owner"
      })
      |> ApiBank.Banks.create_accounts()

    accounts
  end
end
