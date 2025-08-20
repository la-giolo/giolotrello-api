defmodule GiolotrelloApiWeb.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :giolotrello_api,
    module: GiolotrelloApi.Auth.Guardian,
    error_handler: GiolotrelloApiWeb.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
