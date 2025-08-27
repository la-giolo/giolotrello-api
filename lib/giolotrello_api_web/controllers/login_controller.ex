defmodule GiolotrelloApiWeb.LoginController do
  use GiolotrelloApiWeb, :controller
  alias GiolotrelloApi.Users
  alias GiolotrelloApi.Auth.Guardian

  # POST /api/login
  def create(conn, %{"email" => email, "password" => password}) do
    case Users.authenticate_user(email, password) do
      {:ok, user} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user)
        json(conn, %{token: token})

      {:error, reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: reason})
    end
  end
end
