defmodule GiolotrelloApi.Auth.Guardian do
  use Guardian, otp_app: :giolotrello_api

  alias GiolotrelloApi.Users
  alias GiolotrelloApi.Users.User

  @impl Guardian
  def subject_for_token(%User{id: id}, _claims) do
    {:ok, to_string(id)}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  @impl Guardian
  def resource_from_claims(%{"sub" => id}) do
    case Users.get_user!(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
