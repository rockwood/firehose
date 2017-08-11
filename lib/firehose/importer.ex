defmodule Firehose.Importer do
  alias Firehose.Events

  @host "api.bitfinex.com"
  @path "/ws"
  @pairs ["BTCUSD", "LTCUSD", "LTCBTC", "ETHUSD", "ETHBTC", "ETCUSD", "ETCBTC", "RRTUSD", "RRTBTC",
          "ZECUSD", "ZECBTC"]

  def start_link() do
    Task.start_link(__MODULE__, :run, [])
  end

  def run() do
    socket = Socket.Web.connect!(@host, path: @path, secure: true)
    subscribe(socket)
    loop_recv(socket)
  end

  defp loop_recv(socket) do
    case Socket.Web.recv!(socket) do
      {:text, message} -> handle_text(socket, message)
      {:ping, message} -> handle_ping(socket, message)
    end

    loop_recv(socket)
  end

  def subscribe(socket) do
    for pair <- @pairs do
      message = Poison.encode!(%{event: "subscribe", channel: "trades", pair: pair})
      Socket.Web.send!(socket, {:text, message})
    end
  end

  def handle_ping(socket, _message) do
    Socket.Web.send!(socket, {:pong, ""})
  end

  def handle_text(_socket, message) do
    case Poison.decode!(message) do
      [_, "tu", sequence, trade_id, timestamp, price, amount] ->
        {:ok, _trade} = Events.create_trade(%{sequence: sequence,
                                              trade_id: trade_id,
                                              timestamp: DateTime.from_unix!(timestamp),
                                              price: price,
                                              amount: amount})
      %{"event" => _} = message ->
        IO.inspect(message)
      _ ->
        {:error, :unknown_message}
    end
  end
end
