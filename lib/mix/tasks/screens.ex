defmodule Mix.Tasks.Portfolio.Screens do

  use Mix.Task

  @shortdoc "Génère les captures"

   def run(_) do
    Portfolio.Database.start_link(:portfolio_db, Application.get_env(:portfolio, :paths)[:database])
    works = Portfolio.Database.get_works(:portfolio_db)
    works
      |> Enum.map(&(&1.screens))
      |> Enum.reduce([], fn (x, acc) -> x ++ acc end)
      |> Enum.map(fn (screen) ->
        Portfolio.Screenshot.capture("priv/static/screens", screen, 1280, 1064)
       end)
      |> IO.inspect
   end

end