defmodule Firehose.EventsTest do
  use Firehose.DataCase

  alias Firehose.Events

  describe "trades" do
    alias Firehose.Events.Trade

    @valid_attrs %{age: 42, name: "some name"}
    @update_attrs %{age: 43, name: "some updated name"}
    @invalid_attrs %{age: nil, name: nil}

    def trade_fixture(attrs \\ %{}) do
      {:ok, trade} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_trade()

      trade
    end

    test "list_trades/0 returns all trades" do
      trade = trade_fixture()
      assert Events.list_trades() == [trade]
    end

    test "get_trade!/1 returns the trade with given id" do
      trade = trade_fixture()
      assert Events.get_trade!(trade.id) == trade
    end

    test "create_trade/1 with valid data creates a trade" do
      assert {:ok, %Trade{} = trade} = Events.create_trade(@valid_attrs)
      assert trade.age == 42
      assert trade.name == "some name"
    end

    test "create_trade/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_trade(@invalid_attrs)
    end

    test "update_trade/2 with valid data updates the trade" do
      trade = trade_fixture()
      assert {:ok, trade} = Events.update_trade(trade, @update_attrs)
      assert %Trade{} = trade
      assert trade.age == 43
      assert trade.name == "some updated name"
    end

    test "update_trade/2 with invalid data returns error changeset" do
      trade = trade_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_trade(trade, @invalid_attrs)
      assert trade == Events.get_trade!(trade.id)
    end

    test "delete_trade/1 deletes the trade" do
      trade = trade_fixture()
      assert {:ok, %Trade{}} = Events.delete_trade(trade)
      assert_raise Ecto.NoResultsError, fn -> Events.get_trade!(trade.id) end
    end

    test "change_trade/1 returns a trade changeset" do
      trade = trade_fixture()
      assert %Ecto.Changeset{} = Events.change_trade(trade)
    end
  end

  describe "trades" do
    alias Firehose.Events.Trade

    @valid_attrs %{amount: 42, price: 42, sequence: "some sequence", timestamp: ~N[2010-04-17 14:00:00.000000], trade_id: "some trade_id"}
    @update_attrs %{amount: 43, price: 43, sequence: "some updated sequence", timestamp: ~N[2011-05-18 15:01:01.000000], trade_id: "some updated trade_id"}
    @invalid_attrs %{amount: nil, price: nil, sequence: nil, timestamp: nil, trade_id: nil}

    def trade_fixture(attrs \\ %{}) do
      {:ok, trade} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_trade()

      trade
    end

    test "list_trades/0 returns all trades" do
      trade = trade_fixture()
      assert Events.list_trades() == [trade]
    end

    test "get_trade!/1 returns the trade with given id" do
      trade = trade_fixture()
      assert Events.get_trade!(trade.id) == trade
    end

    test "create_trade/1 with valid data creates a trade" do
      assert {:ok, %Trade{} = trade} = Events.create_trade(@valid_attrs)
      assert trade.amount == 42
      assert trade.price == 42
      assert trade.sequence == "some sequence"
      assert trade.timestamp == ~N[2010-04-17 14:00:00.000000]
      assert trade.trade_id == "some trade_id"
    end

    test "create_trade/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_trade(@invalid_attrs)
    end

    test "update_trade/2 with valid data updates the trade" do
      trade = trade_fixture()
      assert {:ok, trade} = Events.update_trade(trade, @update_attrs)
      assert %Trade{} = trade
      assert trade.amount == 43
      assert trade.price == 43
      assert trade.sequence == "some updated sequence"
      assert trade.timestamp == ~N[2011-05-18 15:01:01.000000]
      assert trade.trade_id == "some updated trade_id"
    end

    test "update_trade/2 with invalid data returns error changeset" do
      trade = trade_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_trade(trade, @invalid_attrs)
      assert trade == Events.get_trade!(trade.id)
    end

    test "delete_trade/1 deletes the trade" do
      trade = trade_fixture()
      assert {:ok, %Trade{}} = Events.delete_trade(trade)
      assert_raise Ecto.NoResultsError, fn -> Events.get_trade!(trade.id) end
    end

    test "change_trade/1 returns a trade changeset" do
      trade = trade_fixture()
      assert %Ecto.Changeset{} = Events.change_trade(trade)
    end
  end
end
