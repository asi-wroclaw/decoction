defmodule Decoction.Repo.Migrations.CreateImage do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :text, :string, default: "", null: false
      add :image, :string, null: false
      add :source_link, :string, default: "", null: false
      add :tags, :string, default: "", null: false
      add :nsfw, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:images, [:user_id])

  end
end
