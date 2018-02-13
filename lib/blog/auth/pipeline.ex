defmodule Blog.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :blog,
    module: Blog.Auth.Guardian,
    error_handler: Blog.Auth.ErrorHandler

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
