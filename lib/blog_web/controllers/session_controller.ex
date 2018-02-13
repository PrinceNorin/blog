defmodule BlogWeb.SessionController do
  use BlogWeb, :controller

  alias Blog.Auth
  alias Blog.Account
  alias Blog.Account.User
  alias Blog.Auth.Guardian

  def new(conn, _params) do
    render conn, "new.html", changeset: Account.change_user(%User{})
  end

  def create(conn, %{"user" => %{"name" => name, "password" => password}}) do
    Auth.authenticate(name, password) |> login(conn)
  end

  def destroy(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: session_path(conn, :new))
  end

  defp login({:ok, user}, conn) do
    conn
    |> Guardian.Plug.sign_in(user)
    |> put_flash(:info, "Welcome back!")
    |> redirect(to: page_path(conn, :secret))
  end

  defp login({:error, message}, conn) do
    conn
    |> put_flash(:error, message)
    |> redirect(to: session_path(conn, :new))
  end
end
