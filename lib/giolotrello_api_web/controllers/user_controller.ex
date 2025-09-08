defmodule GiolotrelloApiWeb.UserController do
  use GiolotrelloApiWeb, :controller

  alias GiolotrelloApi.Users
  alias GiolotrelloApi.Users.User
  alias GiolotrelloApiWeb.UserJSON

  # POST /api/users
  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render(:show, user: user)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(json: GiolotrelloApiWeb.ChangesetJSON)
        |> render("error.json", changeset: changeset)
    end
  end
end
