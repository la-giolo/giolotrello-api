defmodule GiolotrelloApi.TasksFixtures do
  alias GiolotrelloApi.Repo
  alias GiolotrelloApi.Lists
  alias GiolotrelloApi.Tasks.Task
  alias GiolotrelloApi.UsersFixtures

  def task_fixture(attrs \\ %{}) do
    user = UsersFixtures.user_fixture()
    {:ok, list} = Lists.create_list_with_owner(%{title: "Test list"}, user.id)

    attrs =
      Enum.into(attrs, %{
        title: "Test task",
        description: "Some description",
        list_id: list.id
      })

    {:ok, task} =
      %Task{}
      |> Task.changeset(attrs)
      |> Repo.insert()

    task
  end
end
