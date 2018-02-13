defmodule Blog.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Comeonin.Bcrypt
  alias Blog.Account.User


  schema "users" do
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :password])
    |> validate_required([:name, :password])
    |> unique_constraint(:name)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = chset) do
    change(chset, password: Bcrypt.hashpwsalt(password))
  end
  defp put_pass_hash(chset), do: chset
end
