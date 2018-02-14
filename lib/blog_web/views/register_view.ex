defmodule BlogWeb.RegisterView do
  use BlogWeb, :view

  def form_control_class(f, name) do
    if Keyword.has_key?(f.errors, name) do
      "form-control is-invalid"
    else
      "form-control"
    end
  end
end
