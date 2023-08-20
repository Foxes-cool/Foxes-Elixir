HTTPoison.start

defmodule Foxes do
  defp _internal(name, object) do
    if :ets.whereis(:foxes_table) == :undefined do
      :ets.new(:foxes_table, [:named_table])
    end
    time = floor(:os.system_time(:second)/86400)
    if :ets.lookup(:foxes_table, name) == [] || :ets.lookup(:foxes_table, name)[:time] != time do
      :ets.insert(:foxes_table, {name, %{
        time: time,
        counts: Integer.parse(HTTPoison.get!("https://foxes.cool/counts/" <> name).body) |> elem(0),
      }})
    end
    params = Enum.map_join(object, "&", fn {key, value} -> "#{key}" <> "=" <> "#{value}" end)
    id = :rand.uniform((:ets.lookup(:foxes_table, name) |> List.first |> elem(1))[:counts])-1
    url = "https://img.foxes.cool/" <> name <> "/" <> Integer.to_string(id) <> ".jpg"
    if params == "" do
      url
    else
      url <> "?" <> params
    end
  end

  def fox(object) do _internal("fox", object) end
  def curious(object) do _internal("curious", object) end
  def happy(object) do _internal("happy", object) end
  def scary(object) do _internal("scary", object) end
  def sleeping(object) do _internal("sleeping", object) end
end
