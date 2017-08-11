# Firehose

Demo showing [TimescaleDB](timescale.com) in Phoenix.

# Setup

  * Install docker and docker-compose
  * `docker-compose up -d`
  * `mix ecto.create && mix.ecto.migrate`
  * `mix phx.server`
  * `open http://localhost:4000`

# TimescaleDB

The `trades` table is stored in TimescaleDB hypertable which optimizes quering data accross time. To
see, run the query:

```sql
EXPLAIN SELECT * FROM trades;
```

For more info, see the `[TimescaleDB docs](docs.timescale.com)`
