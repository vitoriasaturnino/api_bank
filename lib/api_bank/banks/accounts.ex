defmodule ApiBank.Banks.Accounts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :owner, :string
    field :number, :string
    field :balance, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(accounts, attrs) do
    accounts
    |> cast(attrs, [:number, :owner, :balance])
    |> validate_required([:number, :owner, :balance])
  end
end
