defmodule Blog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :password, :string

      timestamps()
    end
    create index :users, :name, unique: true
  end
end
