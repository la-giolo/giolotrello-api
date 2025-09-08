defmodule GiolotrelloApiWeb.UserController do
  use GiolotrelloApiWeb, :controller

  alias GiolotrelloApi.Users

  # GET /api/users
  def index(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

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
