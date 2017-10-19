use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pumpkin, PumpkinWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :pumpkin, Pumpkin.Repo,
  adapter: Ecto.Adapters.Postgres,
  # username: "postgres",
  # password: "postgres",
  database: "pumpkin_ex_test",
  # hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :pumpkin, :task_supervisor, Pumpkin.TestTaskSupervisor
config :pumpkin, :auth_token, "secret"
