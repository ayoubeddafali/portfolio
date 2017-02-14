defmodule Portfolio.WorkController do

  use Portfolio.Web, :controller

  alias Portfolio.Work

  plug Guardian.Plug.EnsureAuthenticated when action in [:create]

  def index(conn, _params) do
    works = Portfolio.Database.get_works(:portfolio_db)
    render conn, "index.html", works: works
  end

  def create(conn, %{"work" => params}) do
    changeset = Work.changeset(%Work{}, params)
    if changeset.valid? do
      work = Map.merge(%Work{}, changeset.changes)
      Portfolio.Database.add_work(:portfolio_db, work)
      Portfolio.Database.sync(:portfolio_db)
      changeset = Work.changeset(%Work{})
    end 
    render conn, "index.html", changeset: changeset
  end

end
