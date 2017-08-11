defmodule Firehose.Events.Trade do
  use Ecto.Schema
  import Ecto.Changeset
  alias Firehose.Events.Trade

  @primary_key {:timestamp, :naive_datetime, []}

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
end
