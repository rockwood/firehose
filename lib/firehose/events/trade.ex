defmodule Firehose.Events.Trade do
  use Ecto.Schema
  import Ecto.Changeset
  alias Firehose.Events.Trade

  @primary_key {:timestamp, :naive_datetime, []}

  defimpl Phoenix.Param do
    def to_param(%{timestamp: timestamp}) do
      NaiveDateTime.to_iso8601(timestamp)
    end
  end

  schema "trades" do
    field :amount, :float
    field :price, :decimal
    field :sequence, :string
    field :trade_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Trade{} = trade, attrs) do
    trade
    |> cast(attrs, [:sequence, :trade_id, :timestamp, :price, :amount])
    |> validate_required([:sequence, :trade_id, :timestamp, :price, :amount])
  end

  defmodule Query do
    import Ecto.Query

    def latest(query \\ Trade, count) do
      from query, order_by: [desc: :timestamp], limit: ^count
    end
  end
end
