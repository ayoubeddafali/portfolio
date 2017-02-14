defmodule Portfolio.Screenshot do

  @doc """
  Capture a webpage
  """
  @spec capture(String.t, String.t, Integer.t, Integer.t) :: String.test
  def capture(directory, url, width, height) when is_integer(width) do
     capture(directory, url, Integer.to_string(width), Integer.to_string(height))
  end

  @spec capture(String.t, String.t, String.t, String.t) :: String.test
  def capture(directory, url, width, height) do
    dirname = directory |> Path.absname()
    filename = md5(url)
    filepath = Path.join(dirname, filename <> ".jpg")
    if File.exists?(filepath) do
      {:error, "File already exists"}
    else
      if !File.exists?(dirname) do
        File.mkdir_p!(dirname)
      end
      if !File.exists?(filepath) do
        System.cmd("pageres", [url, "#{width}x#{height}", "--filename", filename, "--crop", "--format=jpg"], cd: dirname)
      end
      {:ok, filepath}
    end
  end

  defp resize(file) do
      with = "0"
      height = "0"
      path = file
      %{err: nil} = Porcelain.exec "convert", [
      "tmp.png",
      "-resize",
      "#{width}x#{height}^",
      "-gravity",
      "North",
      "-crop",
      "#{width}x#{height}+0+0",
      path <> ".jpg"]
  end

  defp md5(data) do
    Base.encode16(:erlang.md5(data), case: :lower)
  end

end
