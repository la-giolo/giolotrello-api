defmodule GiolotrelloApi.Users do
  @moduledoc """
  The Users context: manage users and authentication.
  """

  import Ecto.Query, warn: false
  alias GiolotrelloApi.Repo
  alias GiolotrelloApi.Users.User
  alias Bcrypt

  def get_user!(id), do: Repo.get(User, id)

  def get_user_by_email(email), do: Repo.get_by(User, email: email)


  @doc """
  Authenticate a user by email and password.
  Returns {:ok, user} or {:error, reason}.
  """
  def authenticate_user(email, password) do
    case get_user_by_email(email) do
      nil ->
        {:error, "Invalid credentials"}

      user ->
        if Bcrypt.verify_pass(password, user.hashed_password) do
          {:ok, user}
        else
          {:error, "Invalid credentials"}
        end
    end
  end

  @doc """
  Creates a new user with hashed password.
  Expects a map like %{email: "...", password: "..."}
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> put_hashed_password()
    |> Repo.insert()
  end

  # Hash the password before inserting into DB
  defp put_hashed_password(changeset) do
    case Ecto.Changeset.get_change(changeset, :password) do
      nil -> changeset
      plain_password ->
        hashed = Bcrypt.hash_pwd_salt(plain_password)
        changeset
        |> Ecto.Changeset.put_change(:hashed_password, hashed)
        |> Ecto.Changeset.delete_change(:password)
    end
  end
end
