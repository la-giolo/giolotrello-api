defmodule GiolotrelloApi.ListsFixtures do
  alias GiolotrelloApi.Lists
  alias GiolotrelloApi.UsersFixtures

  def list_fixture(attrs \\ %{}) do
    user = UsersFixtures.user_fixture()

    attrs =
      Enum.into(attrs, %{
        title: "some title"
      })

    {:ok, list} = Lists.create_list_with_owner(attrs, user.id)
    list
  end
end
