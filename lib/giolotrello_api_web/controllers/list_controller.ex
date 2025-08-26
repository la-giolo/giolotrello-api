defmodule GiolotrelloApiWeb.ListController do
  use GiolotrelloApiWeb, :controller

  alias GiolotrelloApi.Lists
  alias GiolotrelloApi.Lists.List

  action_fallback GiolotrelloApiWeb.FallbackController

  # GET /api/lists
  def index(conn, _params) do
    current_user = Guardian.Plug.current_resource(conn)

    lists = Lists.get_user_lists_with_tasks(current_user.id)

    render(conn, GiolotrelloApiWeb.ListJSON, "index.json", lists: lists)
  end

  # POST /api/lists
  def create(conn, %{"list" => list_params}) do
    current_user = Guardian.Plug.current_resource(conn)

    with {:ok, %List{} = list} <- Lists.create_list_with_owner(list_params, current_user.id) do
      conn
      |> put_status(:created)
      |> render(:show, list: list)
    end
  end

  # PUT /api/lists/:id
  def update(conn, %{"id" => id, "list" => list_params}) do
    current_user = Guardian.Plug.current_resource(conn)

    list = Lists.get_list!(id)

    if Lists.user_can_update_list?(list.id, current_user.id) do
      with {:ok, %List{} = updated_list} <- Lists.update_list(list, list_params) do
        render(conn, :show, list: updated_list)
      end
    else
      conn
      |> put_status(:forbidden)
      |> json(%{error: "You are not authorized to update this list"})
    end
  end

  # DELETE /api/lists/:id
  def delete(conn, %{"id" => id}) do
    list = Lists.get_list!(id)

    with {:ok, %List{}} <- Lists.delete_list(list) do
      send_resp(conn, :no_content, "")
    end
  end
end
