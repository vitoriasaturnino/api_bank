defmodule ApiBankWeb.AccountsController do
  use ApiBankWeb, :controller

  alias ApiBank.Banks
  alias ApiBank.Banks.Accounts

  def index(conn, _params) do
    accounts = Banks.list_accounts()
    render(conn, :index, accounts_collection: accounts)
  end

  def new(conn, _params) do
    changeset = Banks.change_accounts(%Accounts{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"accounts" => accounts_params}) do
    case Banks.create_accounts(accounts_params) do
      {:ok, accounts} ->
        conn
        |> put_flash(:info, "Accounts created successfully.")
        |> redirect(to: ~p"/accounts/#{accounts}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    accounts = Banks.get_accounts!(id)
    render(conn, :show, accounts: accounts)
  end

  def edit(conn, %{"id" => id}) do
    accounts = Banks.get_accounts!(id)
    changeset = Banks.change_accounts(accounts)
    render(conn, :edit, accounts: accounts, changeset: changeset)
  end

  def update(conn, %{"id" => id, "accounts" => accounts_params}) do
    accounts = Banks.get_accounts!(id)

    case Banks.update_accounts(accounts, accounts_params) do
      {:ok, accounts} ->
        conn
        |> put_flash(:info, "Accounts updated successfully.")
        |> redirect(to: ~p"/accounts/#{accounts}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, accounts: accounts, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    accounts = Banks.get_accounts!(id)
    {:ok, _accounts} = Banks.delete_accounts(accounts)

    conn
    |> put_flash(:info, "Accounts deleted successfully.")
    |> redirect(to: ~p"/accounts")
  end
end
