defmodule Screenshot do

  use ExUnit.Case, async: true

  @tag :skip
  test "capture a webpage" do
    path = Portfolio.Screenshot.capture("test/data/screenshots", "https://grafikart.fr", 1280, 720)
    assert File.exists?(path) == true
    File.rm(path)
  end

end
