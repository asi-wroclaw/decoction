defmodule Decoction.PageController do
  use Decoction.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
