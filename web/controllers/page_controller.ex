defmodule Portfolio.PageController do
  use Portfolio.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, %{"password" => password}) do
    if Portfolio.Database.auth(:portfolio_db, password) do
      conn
        |> Guardian.Plug.sign_in(%Portfolio.User{})
        |> redirect(to: page_path(conn, :index))
    else
      redirect(conn, to: page_path(conn, :login))
    end
  end

  def login(conn, params) do
    render conn, "login.html"
  end

end
