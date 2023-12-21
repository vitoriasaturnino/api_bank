defmodule ApiBank.Repo do
  use Ecto.Repo,
    otp_app: :api_bank,
    adapter: Ecto.Adapters.Postgres
end
