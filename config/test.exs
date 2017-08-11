use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :firehose, FirehoseWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :firehose, Firehose.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "firehose_test",
  hostname: "localhost",
  port: 55432,
  pool: Ecto.Adapters.SQL.Sandbox
