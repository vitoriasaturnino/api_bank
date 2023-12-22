defmodule ApiBankWeb.AccountsController do
  use ApiBankWeb, :controller

  alias ApiBank.Banks
  alias ApiBank.Banks.Accounts

  action_fallback ApiBankWeb.FallbackController

  def index(conn, _params) do
    accounts = Banks.list_accounts()

    conn
    |> put_status(:ok)
    |> render(:index, accounts: accounts)
  end

  @spec create(any(), map()) :: any()
  def create(conn, %{"accounts" => accounts_params}) do
    case Banks.create_accounts(accounts_params) do
      {:ok, %Accounts{} = accounts} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/accounts/#{accounts}")
        |> render(:show, accounts: accounts)

      error ->
        error
    end
  end

  def show(conn, %{"id" => id}) do
    accounts = Banks.get_accounts!(id)

    conn
    |> put_status(:ok)
    |> render(:show, accounts: accounts)
  end

  def update(conn, %{"id" => id, "accounts" => accounts_params}) do
    accounts = Banks.get_accounts!(id)

    case Banks.update_accounts(accounts, accounts_params) do
      {:ok, %Accounts{} = accounts} ->
        conn
        |> put_status(:ok)
        |> render(:show, accounts: accounts)

      error ->
        error
    end
  end

  def delete(conn, %{"id" => id}) do
    accounts = Banks.get_accounts!(id)

    case Banks.delete_accounts(accounts) do
      {:ok, %Accounts{}} ->
        send_resp(conn, :no_content, "")

      error ->
        error
    end
  end
end
