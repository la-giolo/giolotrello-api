defmodule GiolotrelloApiWeb.ListUserJSON do
  alias GiolotrelloApi.Lists.ListUser

  def index(%{users: users}) do
    %{data: (for lu <- users, do: data(lu))}
  end

  def show(%{list_user: lu}) do
    %{data: data(lu)}
  end

  defp data(%ListUser{} = lu) do
    %{
      id: lu.id,
      list_id: lu.list_id,
      user_id: lu.user_id,
      email: lu.user.email
    }
  end
end
