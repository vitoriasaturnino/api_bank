defmodule ApiBank.BanksTest do
  use ApiBank.DataCase

  alias ApiBank.Banks

  describe "accounts" do
    alias ApiBank.Banks.Accounts

    import ApiBank.BanksFixtures

    @invalid_attrs %{owner: nil, number: nil, balance: nil}

    test "list_accounts/0 returns all accounts" do
      accounts = accounts_fixture()
      assert Banks.list_accounts() == [accounts]
    end

    test "get_accounts!/1 returns the accounts with given id" do
      accounts = accounts_fixture()
      assert Banks.get_accounts!(accounts.id) == accounts
    end

    test "create_accounts/1 with valid data creates a accounts" do
      valid_attrs = %{owner: "some owner", number: "some number", balance: 42}

      assert {:ok, %Accounts{} = accounts} = Banks.create_accounts(valid_attrs)
      assert accounts.owner == "some owner"
      assert accounts.number == "some number"
      assert accounts.balance == 42
    end

    test "create_accounts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Banks.create_accounts(@invalid_attrs)
    end

    test "update_accounts/2 with valid data updates the accounts" do
      accounts = accounts_fixture()
      update_attrs = %{owner: "some updated owner", number: "some updated number", balance: 43}

      assert {:ok, %Accounts{} = accounts} = Banks.update_accounts(accounts, update_attrs)
      assert accounts.owner == "some updated owner"
      assert accounts.number == "some updated number"
      assert accounts.balance == 43
    end

    test "update_accounts/2 with invalid data returns error changeset" do
      accounts = accounts_fixture()
      assert {:error, %Ecto.Changeset{}} = Banks.update_accounts(accounts, @invalid_attrs)
      assert accounts == Banks.get_accounts!(accounts.id)
    end

    test "delete_accounts/1 deletes the accounts" do
      accounts = accounts_fixture()
      assert {:ok, %Accounts{}} = Banks.delete_accounts(accounts)
      assert_raise Ecto.NoResultsError, fn -> Banks.get_accounts!(accounts.id) end
    end

    test "change_accounts/1 returns a accounts changeset" do
      accounts = accounts_fixture()
      assert %Ecto.Changeset{} = Banks.change_accounts(accounts)
    end
  end
end
