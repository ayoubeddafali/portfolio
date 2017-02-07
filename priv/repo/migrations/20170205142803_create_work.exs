defmodule Portfolio.Repo.Migrations.CreateWork do
  use Ecto.Migration

  def change do
    create table(:works) do

      timestamps()
    end

  end
end
