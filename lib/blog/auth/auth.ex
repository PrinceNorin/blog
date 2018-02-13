defmodule Blog.Auth do
  @moduledoc """
  The Authentication context.
  """

  import Ecto.Query, warn: false

  alias Blog.Repo
  alias Comeonin.Bcrypt
  alias Blog.Account.User

  @doc """
  Authenticate a user.

  ## Example

      iex> authenticate("username", "password")
      {:ok, %User{}}

      iex> authenticate("username", "password")
      {:error, "error message"}

  """
  def authenticate(name, password) do
    User
    |> where(name: ^name)
    |> Repo.one()
    |> check_password(password)
  end

  defp check_password(nil, _), do: {:error, "Invalid username or password"}
  defp check_password(user, password) do
    case Bcrypt.checkpw(password, user.password) do
      true -> {:ok, user}
      false -> {:error, "Invalid username or password"}
    end
  end
end
