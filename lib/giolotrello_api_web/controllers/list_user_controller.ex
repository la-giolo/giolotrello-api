defmodule GiolotrelloApiWeb.ListUserController do
  use GiolotrelloApiWeb, :controller

  alias GiolotrelloApi.Lists

  action_fallback GiolotrelloApiWeb.FallbackController

  # GET /lists/:list_id/users
  def index(conn, %{"list_id" => list_id}) do
    users = Lists.list_users_for_list(list_id)
    render(conn, "index.json", users: users)
  end

  # POST /lists/:list_id/users
  def create(conn, %{"list_id" => list_id, "user_id" => user_id}) do
    with {:ok, list_user} <- Lists.add_user_to_list(list_id, user_id) do
      conn
      |> put_status(:created)
      |> render("show.json", list_user: list_user)
    end
  end

  # DELETE /lists/:list_id/users/:user_id
  def delete(conn, %{"list_id" => list_id, "user_id" => user_id}) do
    with {:ok, _} <- Lists.remove_user_from_list(list_id, user_id) do
      send_resp(conn, :no_content, "")
    end
  end
end
