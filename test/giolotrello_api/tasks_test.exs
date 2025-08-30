defmodule GiolotrelloApi.TasksTest do
  use GiolotrelloApi.DataCase

  alias GiolotrelloApi.Tasks
  alias GiolotrelloApi.Tasks.Task
  alias GiolotrelloApi.TasksFixtures
  alias GiolotrelloApi.ListsFixtures

  describe "get_task!/1" do
    test "returns the task with given id" do
      task = TasksFixtures.task_fixture()
      assert Tasks.get_task!(task.id).id == task.id
    end
  end

  describe "list_tasks/0" do
    test "returns all tasks" do
      task = TasksFixtures.task_fixture()
      assert Tasks.list_tasks() == [task]
    end
  end

  describe "create_task/1" do
    test "with valid data creates a task" do
      list = ListsFixtures.list_fixture()

      valid_attrs = %{
        "title" => "New task",
        "description" => "Some description",
        "list_id" => list.id
      }

      assert {:ok, %Task{} = task} = Tasks.create_task(valid_attrs)
      assert task.title == "New task"
      assert task.description == "Some description"
      assert task.list_id == list.id
      assert task.position == 1000
    end

    test "with invalid data returns error changeset" do
      list = ListsFixtures.list_fixture()

      invalid_attrs = %{"title" => nil, "description" => nil, "list_id" => list.id}

      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(invalid_attrs)
    end
  end

  describe "update_task/2" do
    test "with valid data updates the task" do
      task = TasksFixtures.task_fixture()
      update_attrs = %{"title" => "Updated title"}

      assert {:ok, %Task{} = updated_task} = Tasks.update_task(task, update_attrs)
      assert updated_task.title == "Updated title"
    end

    test "with invalid data returns error changeset" do
      task = TasksFixtures.task_fixture()
      invalid_attrs = %{"title" => nil}

      assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, invalid_attrs)
    end
  end

  describe "delete_task/1" do
    test "deletes the task" do
      task = TasksFixtures.task_fixture()
      assert {:ok, %Task{}} = Tasks.delete_task(task)

      assert_raise Ecto.NoResultsError, fn ->
        Tasks.get_task!(task.id)
      end
    end
  end
end
