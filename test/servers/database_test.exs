defmodule DatabaseTest do

  use ExUnit.Case, async: true

  alias Portfolio.Database

  setup do
    {:ok, db} = Database.start_link(:test_db)
    {:ok, db: db}
  end

  test "It add works", %{db: db} do
    Database.add_work(db, %Portfolio.Work{name: "1"})
    assert length(Database.get_works(db)) == 1
  end

  test "It prepends a new work", %{db: db} do
    Database.add_work(db, %Portfolio.Work{name: "1"})
    Database.add_work(db, %Portfolio.Work{name: "2"})
    assert [%{name: "2"}, %{name: "1"}] = Database.get_works(db)
  end

  test "It removes a work", %{db: db} do
    Database.add_work(db, %Portfolio.Work{name: "1"})
    Database.add_work(db, %Portfolio.Work{name: "2"})
    Database.delete_work(db, 1)
    assert [%{name: "2"}] = Database.get_works(db)
  end

  test "It loads data from json" do
    {:ok, db} = Database.start_link(:test_db_with_file, "test/data/portfolio.json")
    assert [%{name: "Hello", tags: [_, _]}] = Database.get_works(db)
  end

end
