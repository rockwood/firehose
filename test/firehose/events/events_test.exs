defmodule Firehose.EventsTest do
  use Firehose.DataCase

  alias Firehose.Events

  describe "trades" do
    alias Firehose.Events.Trade

    @valid_attrs %{amount: 42, price: 42, sequence: "some sequence",
                   timestamp: ~N[2010-04-17 14:00:00.000000], trade_id: 123}
    @update_attrs %{amount: 43, price: 43, sequence: "some updated sequence", trade_id: 123}
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
      assert Events.get_trade!(trade.timestamp) == trade
    end

    test "create_trade/1 with valid data creates a trade" do
      assert {:ok, %Trade{} = trade} = Events.create_trade(@valid_attrs)
      assert trade.amount == 42
      assert trade.sequence == "some sequence"
      assert trade.timestamp == ~N[2010-04-17 14:00:00.000000]
      assert trade.trade_id == 123
    end

    test "create_trade/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_trade(@invalid_attrs)
    end

    test "update_trade/2 with valid data updates the trade" do
      trade = trade_fixture()
      assert {:ok, trade} = Events.update_trade(trade, @update_attrs)
      assert %Trade{} = trade
      assert trade.amount == 43
      assert trade.sequence == "some updated sequence"
      assert trade.trade_id == 123
    end

    test "update_trade/2 with invalid data returns error changeset" do
      trade = trade_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_trade(trade, @invalid_attrs)
      assert trade == Events.get_trade!(trade.timestamp)
    end

    test "delete_trade/1 deletes the trade" do
      trade = trade_fixture()
      assert {:ok, %Trade{}} = Events.delete_trade(trade)
      assert_raise Ecto.NoResultsError, fn -> Events.get_trade!(trade.timestamp) end
    end

    test "change_trade/1 returns a trade changeset" do
      trade = trade_fixture()
      assert %Ecto.Changeset{} = Events.change_trade(trade)
    end
  end
end
