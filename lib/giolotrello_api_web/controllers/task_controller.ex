defmodule GiolotrelloApiWeb.TaskController do
  use GiolotrelloApiWeb, :controller

  alias GiolotrelloApi.Tasks
  alias GiolotrelloApi.Tasks.Task
  alias GiolotrelloApiWeb.TaskJSON

  action_fallback GiolotrelloApiWeb.FallbackController

  # GET /api/tasks
  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    json(conn, TaskJSON.index(%{tasks: tasks}))
  end

  # POST /api/tasks
  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
      conn
      |> put_status(:created)
      |> json(TaskJSON.show(%{task: task}))
    end
  end

  # PUT /api/tasks/:task_id
  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{} = task} <- Tasks.update_task(task, task_params) do
      json(conn, TaskJSON.show(%{task: task}))
    end
  end

  # DELETE /api/tasks/:task_id
  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{}} <- Tasks.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
