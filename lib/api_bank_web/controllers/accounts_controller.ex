defmodule ApiBankWeb.AccountsController do
  use ApiBankWeb, :controller

  alias ApiBank.Banks
  alias ApiBank.Banks.Accounts

  action_fallback ApiBankWeb.FallbackController

  def index(conn, _params) do
    accounts = Banks.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  @spec create(any(), map()) :: any()
  def create(conn, %{"accounts" => accounts_params}) do
    with {:ok, %Accounts{} = accounts} <- Banks.create_accounts(accounts_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/accounts/#{accounts}")
      |> render(:show, accounts: accounts)
    end
  end

  def show(conn, %{"id" => id}) do
    accounts = Banks.get_accounts!(id)
    render(conn, :show, accounts: accounts)
  end

  def update(conn, %{"id" => id, "accounts" => accounts_params}) do
    accounts = Banks.get_accounts!(id)

    with {:ok, %Accounts{} = accounts} <- Banks.update_accounts(accounts, accounts_params) do
      render(conn, :show, accounts: accounts)
    end
  end

  def delete(conn, %{"id" => id}) do
    accounts = Banks.get_accounts!(id)

    with {:ok, %Accounts{}} <- Banks.delete_accounts(accounts) do
      send_resp(conn, :no_content, "")
    end
  end
end
