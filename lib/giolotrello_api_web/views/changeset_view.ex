defmodule GiolotrelloApiWeb.ChangesetView do
  def render("error.json", %{changeset: changeset}) do
    # Translate and return the errors from the changeset
    %{errors: translate_errors(changeset)}
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      # Basic translation without Gettext
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
