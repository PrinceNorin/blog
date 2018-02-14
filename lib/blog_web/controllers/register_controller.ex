defmodule BlogWeb.RegisterController do
  use BlogWeb, :controller

  alias Blog.Account
  alias Blog.Account.User
  alias Ecto.Changeset

  def new(conn, _params) do
    render conn, "new.html", chset: Account.new_user
  end

  def create(conn, %{"user" => attrs}) do
    case Account.create_user(attrs) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Your account have been created")
        |> redirect(to: session_path(conn, :new))

      {:error, chset} ->
        render conn, "new.html", chset: chset
    end
  end
end
