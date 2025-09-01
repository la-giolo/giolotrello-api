defmodule GiolotrelloApi.ListsTest do
  use GiolotrelloApi.DataCase

  alias GiolotrelloApi.Lists
  alias GiolotrelloApi.Lists.{List, ListUser}
  alias GiolotrelloApi.ListsFixtures
  alias GiolotrelloApi.UsersFixtures

  describe "get_list!/1" do
    test "returns the list with given id" do
      list = ListsFixtures.list_fixture()
      assert Lists.get_list!(list.id).id == list.id
    end

    test "raises if list id does not exist" do
      assert_raise Ecto.NoResultsError, fn ->
        Lists.get_list!(-1)
      end
    end
  end

  describe "create_list_with_owner/2" do
    test "with valid data creates a list and list_user" do
      user = UsersFixtures.user_fixture()

      valid_attrs = %{"title" => "My List"}

      assert {:ok, %List{} = list} = Lists.create_list_with_owner(valid_attrs, user.id)
      assert list.title == "My List"

      list_user = Repo.get_by!(ListUser, list_id: list.id, user_id: user.id)
      assert list_user.list_id == list.id
      assert list_user.user_id == user.id
    end

    test "with invalid data returns error changeset" do
      user = UsersFixtures.user_fixture()

      invalid_attrs = %{"title" => nil}

      assert {:error, :list, %Ecto.Changeset{}} =
              Lists.create_list_with_owner(invalid_attrs, user.id)
    end

    test "with invalid user_id returns error changeset for list_user" do
      valid_attrs = %{"title" => "Another List"}

      assert {:error, :list_user, %Ecto.Changeset{}} =
              Lists.create_list_with_owner(valid_attrs, -1)
    end
  end

  describe "update_list/2" do
    test "with valid data updates the list" do
      list = ListsFixtures.list_fixture()
      update_attrs = %{"title" => "Updated Title"}

      assert {:ok, %List{} = updated_list} = Lists.update_list(list, update_attrs)
      assert updated_list.title == "Updated Title"
    end
  end

  describe "delete_list/1" do
    test "deletes the list" do
      list = ListsFixtures.list_fixture()
      assert {:ok, %List{}} = Lists.delete_list(list)

      assert_raise Ecto.NoResultsError, fn ->
        Lists.get_list!(list.id)
      end
    end
  end
end
