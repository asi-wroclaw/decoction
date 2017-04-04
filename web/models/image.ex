defmodule Decoction.Image do
  use Decoction.Web, :model
  use Arc.Ecto.Schema

  schema "images" do
    field :image, Decoction.ImageUpload.Type
    field :text, :string
    field :source_link, :string
    field :tags, :string
    field :nsfw, :boolean, default: false
    belongs_to :user, Decoction.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :image, :source_link, :tags, :nsfw])
    |> cast_attachments(params, [:image])
    |> validate_required([:image])
  end

end
