defmodule Decoction.User do
  use Decoction.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(email), [])
    |> validate_required([:email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def registeration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
