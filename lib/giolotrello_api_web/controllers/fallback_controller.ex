defmodule GiolotrelloApiWeb.FallbackController do
  use GiolotrelloApiWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(GiolotrelloApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(GiolotrelloApiWeb.ErrorView)
    |> render(:"404")
  end
end
