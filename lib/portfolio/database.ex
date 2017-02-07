defmodule Portfolio.Database do

  use GenServer

  def start_link(db_name, db_path \\ false) do
    state = %{
      database: db_path,
      works: []
    }
    GenServer.start_link(__MODULE__, state, name: db_name)
  end

  def get_works(pid) do
    GenServer.call(pid, :get_works)
  end

  def add_work(pid, work) do
    GenServer.call(pid, {:add_work, work})
  end

  def delete_work(pid, index) do
    GenServer.call(pid, {:delete_work, index})
  end

  def sync(pid) do
    GenServer.cast(pid, :sync)
  end
  

  ## Server

  def init(state) do
    if state.database do
      {:ok, Map.merge(state, load_json(state.database))}
    else
      {:ok, state}
    end
  end

  defp load_json(path) do
    case File.read(path) do
      {:ok, body} -> Poison.decode!(body, keys: :atoms)
      _ -> %{}
    end
  end

  @doc """
  Retrieve all works
  """
  def handle_call(:get_works, _from, state) do
    {:reply, Map.get(state, :works), state}
  end

  @doc """
  Add a new work
  """
  def handle_call({:add_work, work}, _from, state) do
    state = Map.put(state, :works, [work | Map.get(state, :works)])
    {:reply, work, state}
  end

  @doc """
  Delete a work
  """
  def handle_call({:delete_work, index}, _from, state) do
    new_works = Map.get(state, :works) |> List.delete_at(index)
    new_state = Map.put(state, :works, new_works)
    {:reply, :ok, new_state}
  end

  @doc """
  Write the database inside a JSON
  """
  def handle_cast(:sync, state) do
    if state.database do
      {:ok, json} = Poison.encode_to_iodata(state)
      File.write!(state.database, json)
    end
    {:noreply, state}
  end

end
