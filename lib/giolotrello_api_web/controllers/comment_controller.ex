defmodule GiolotrelloApiWeb.CommentController do
  use GiolotrelloApiWeb, :controller

  alias GiolotrelloApi.Comments
  alias GiolotrelloApi.Comments.Comment

  action_fallback GiolotrelloApiWeb.FallbackController

  def index(conn, _params) do
    comments = Comments.list_comments()
    render(conn, :index, comments: comments)
  end

  # POST /api/tasks/:task_id/comments
  def create(conn, %{"task_id" => task_id, "comment" => comment_params}) do
    current_user = Guardian.Plug.current_resource(conn)

    attrs =
    comment_params
    |> Map.put("task_id", task_id)
    |> Map.put("user_id", current_user.id)

    with {:ok, %Comment{} = comment} <- Comments.create_comment(attrs) do
      conn
      |> put_status(:created)
      |> render(:show, comment: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Comments.get_comment!(id)
    render(conn, :show, comment: comment)
  end

  # PUT /api/tasks/:task_id/comments/:comment_id
  def update(conn, %{"task_id" => _task_id, "comment_id" => comment_id, "comment" => comment_params}) do
    comment = Comments.get_comment!(comment_id)

    with {:ok, %Comment{} = comment} <- Comments.update_comment(comment, comment_params) do
      render(conn, :show, comment: comment)
    end
  end

  # DELETE /api/tasks/:task_id/comments/:comment_id
  def delete(conn, %{"task_id" => _task_id, "comment_id" => comment_id}) do
    comment = Comments.get_comment!(comment_id)

    with {:ok, %Comment{}} <- Comments.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
