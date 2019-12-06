use Mix.Config

config :aph,
  storage: "espeak",
  hostname: "http://localhost:4001",
  google_key: "replaceme"

# Configure your database!
config :aph, Aph.Repo,
  username: "lu",
  database: "aph_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# You can set the port here, as well as whether to receive fancy HTML errors
# and such.
config :aph, AphWeb.Endpoint,
  http: [port: 4001],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# For CORS support, you can specify allowed origins here.
config :cors_plug,
  origin: ["http://localhost:1234"]

config :logger, :console, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime
