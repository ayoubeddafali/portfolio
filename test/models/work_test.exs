defmodule Portfolio.WorkTest do

  use ExUnit.Case

  alias Portfolio.Work

  doctest Portfolio.Work

  @valid_attrs %{
    "name"    => "Hello",
    "url"     => "http://grafikart.fr",
    "screens" => "aze\naze\n \naze",
    "content" => "fake content here"
  }
  @invalid_attrs %{
    "name" => "",
    "screens" => ""
  }

  test "changeset with valid attributes" do
    changeset = Work.changeset(%Work{name: "hello"}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Work.changeset(%Work{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changes are applied correctly" do
    work = %Work{name: "azeaezeazee"}
    changeset = Work.changeset(work, @valid_attrs)
    assert %Work{name: "Hello"} = Work.apply(work, changeset)
  end
end
