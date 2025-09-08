defmodule GiolotrelloApiWeb.UserController do
  use GiolotrelloApiWeb, :controller

  alias GiolotrelloApi.Users
  alias GiolotrelloApi.Users.User
  alias GiolotrelloApiWeb.UserJSON

  # POST /api/users
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> json(UserJSON.show(user))
    end
  end
end
