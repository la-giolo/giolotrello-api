defmodule GiolotrelloApi.Repo do
  use Ecto.Repo,
    otp_app: :giolotrello_api,
    adapter: Ecto.Adapters.Postgres
end
