defmodule Portfolio.WorkController do

  use Portfolio.Web, :controller

  alias Portfolio.Work

  def index(conn, _params) do
    changeset = Work.changeset(%Work{})
    Portfolio.Database.sync(:portfolio_db)
    render conn, "index.html", changeset: changeset
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
