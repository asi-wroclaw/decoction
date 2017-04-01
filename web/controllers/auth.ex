defmodule Decoction.Auth do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Plug.Conn, only: [put_status: 2]
  import Phoenix.Controller, only: [redirect: 2, put_flash: 3]

  def verify_email_and_password(conn, email, given_password, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(Decoction.User, email: email)

    cond do
      user && checkpw(given_password, user.encrypted_password) ->
        {:ok, user, conn}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end

  def logout(conn) do
    conn
    |> Guardian.Plug.sign_out()
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> put_flash(:error, "Please log in first")
    |> redirect(to: "/login")
  end
end
