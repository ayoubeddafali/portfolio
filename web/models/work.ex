defmodule Portfolio.Work do

  @derive {Poison.Encoder, only: [:name, :url, :content, :screens, :tags]}

  use Portfolio.Web, :model

  schema "works" do
    field :name, :string
    field :url, :string
    field :content, :string
    field :screens, {:array, :string}
    field :tags, {:array, :string}
  end

  def apply(work, changeset) do
    Map.merge(work, changeset.changes)
  end

  defp parse_screens(screens) do
    screens
      |> String.split("\n")
      |> Stream.map(fn (line) -> String.trim(line) end)
      |> Stream.filter(fn (line) -> line != "" end)
      |> Enum.to_list()
  end

  defp parse_tags(tags) do
    tags 
      |> String.split(",")
      |> Stream.map(fn (line) -> String.trim(line) end)
      |> Stream.filter(fn (line) -> line != "" end)
      |> Enum.to_list()
  end

  def changeset(struct, params = %{"screens" => screens}) when is_binary(screens) do
    params = Map.put(params, "screens", parse_screens(screens))
    changeset(struct, params)
  end

  def changeset(struct, params = %{"tags" => tags}) when is_binary(tags) do
    params = Map.put(params, "tags", parse_tags(tags))
    changeset(struct, params)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :url, :content, :screens])
    |> validate_required([:name, :url, :screens])
  end

end
