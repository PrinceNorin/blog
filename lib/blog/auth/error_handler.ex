defmodule Blog.Auth.ErrorHandler do
  import Phoenix.Controller
  import BlogWeb.Router.Helpers

  def auth_error(conn, {:unauthenticated, _reason}, _opts) do
    conn
    |> put_flash(:error, "You need to login to access this page")
    |> redirect(to: session_path(conn, :new))
  end

  def auth_error(conn, {:already_authenticated, _reason}, _opts) do
    conn
    |> put_flash(:error, "You've already logged in")
    |> redirect(to: page_path(conn, :index))
  end
end
