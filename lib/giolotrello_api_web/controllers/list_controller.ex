defmodule GiolotrelloApiWeb.ListController do
  use GiolotrelloApiWeb, :controller

  alias GiolotrelloApi.Lists
  alias GiolotrelloApi.Lists.List

  action_fallback GiolotrelloApiWeb.FallbackController

  # POST /api/lists
  def create(conn, %{"list" => list_params}) do
    current_user = Guardian.Plug.current_resource(conn)

    with {:ok, %List{} = list} <- Lists.create_list_with_owner(list_params, current_user.id) do
      conn
      |> put_status(:created)
      |> render(:show, list: list)
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
