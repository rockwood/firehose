defmodule Firehose.Repo.Migrations.CreateTrades do
  use Ecto.Migration

  def up do
    create table(:trades, primary_key: false) do
      add :timestamp, :naive_datetime, null: false
      add :sequence, :string, null: false
      add :trade_id, :integer, null: false
      add :price, :decimal, null: false
      add :amount, :float, null: false

      timestamps()
    end

    execute("SELECT create_hypertable('trades', 'timestamp')")
  end

  def down do
    drop table(:trades)
  end
end
