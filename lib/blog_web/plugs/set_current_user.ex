defmodule BlogWeb.Plugs.SetCurrentUser do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    user =
      conn
      |> Guardian.Plug.current_resource()

    conn
    |> assign(:current_user, user)
  end
end
