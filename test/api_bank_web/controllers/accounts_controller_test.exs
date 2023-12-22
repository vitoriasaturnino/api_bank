defmodule ApiBankWeb.AccountsControllerTest do
  use ApiBankWeb.ConnCase

  import ApiBank.BanksFixtures

  alias ApiBank.Banks.Accounts

  @create_attrs %{
    owner: "some owner",
    number: "some number",
    balance: 42
  }
  @update_attrs %{
    owner: "some updated owner",
    number: "some updated number",
    balance: 43
  }
  @invalid_attrs %{owner: nil, number: nil, balance: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, ~p"/api/accounts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create accounts" do
    test "renders accounts when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts", accounts: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "balance" => 42,
               "number" => "some number",
               "owner" => "some owner"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts", accounts: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update accounts" do
    setup [:create_accounts]

    test "renders accounts when data is valid", %{conn: conn, accounts: %Accounts{id: id} = accounts} do
      conn = put(conn, ~p"/api/accounts/#{accounts}", accounts: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "balance" => 43,
               "number" => "some updated number",
               "owner" => "some updated owner"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, accounts: accounts} do
      conn = put(conn, ~p"/api/accounts/#{accounts}", accounts: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete accounts" do
    setup [:create_accounts]

    test "deletes chosen accounts", %{conn: conn, accounts: accounts} do
      conn = delete(conn, ~p"/api/accounts/#{accounts}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/accounts/#{accounts}")
      end
    end
  end

  defp create_accounts(_) do
    accounts = accounts_fixture()
    %{accounts: accounts}
  end
end
