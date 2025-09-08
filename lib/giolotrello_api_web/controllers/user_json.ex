defmodule GiolotrelloApiWeb.UserJSON do
  alias GiolotrelloApi.Users.User

  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  def show(%User{} = user), do: data(user)

  defp data(%User{} = user) do
    %{
      "id" => user.id,
      "email" => user.email
    }
  end
end
