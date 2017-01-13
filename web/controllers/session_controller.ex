defmodule Decoction.SessionController do
  use Decoction.Web, :controller
  alias Decoction.User

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Decoction.Auth.verify_email_and_password(conn, email, password, repo: Repo) do
      {:ok, user, conn} ->
        conn
        |> Decoction.Auth.login(user)
        |> put_flash(:info, "Signed in successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username/password combination.")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Decoction.Auth.logout()
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: "/")
  end
end
