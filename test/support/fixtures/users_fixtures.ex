defmodule GiolotrelloApi.UsersFixtures do
  alias GiolotrelloApi.Repo
  alias GiolotrelloApi.Users.User

  def user_fixture(attrs \\ %{}) do
    password = "password123"
    hashed_password = Bcrypt.hash_pwd_salt(password)

    attrs =
      Enum.into(attrs, %{
        email: "user#{System.unique_integer()}@example.com",
        password: password,
        hashed_password: hashed_password
      })

    %User{}
    |> struct(attrs)
    |> Repo.insert!()
  end
end
