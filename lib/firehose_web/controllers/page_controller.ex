defmodule FirehoseWeb.PageController do
  use FirehoseWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
