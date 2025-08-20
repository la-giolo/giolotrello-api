defmodule GiolotrelloApi.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :giolotrello_api,
                              module: GiolotrelloApi.Auth.Guardian,
                              error_handler: GiolotrelloApi.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.LoadResource, allow_blank: true
end
