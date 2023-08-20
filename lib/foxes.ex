:ets.new(:buckets_registry, [:named_table])

HTTPoison.start

defmodule Foxes do
  defp _internal(name, object) do
    time = floor(:os.system_time(:second)/86400)
    if :ets.lookup(:buckets_registry, name) == [] || :ets.lookup(:buckets_registry, name)[:time] != time do
      :ets.insert(:buckets_registry, {name, %{
        time: time,
        counts: Integer.parse(HTTPoison.get!("https://foxes.cool/counts/" <> name).body) |> elem(0),
      }})
    end
    params = Enum.map_join(object, "&", fn {key, value} -> "#{key}" <> "=" <> Kernel.inspect(value) end)
    id = :rand.uniform((:ets.lookup(:buckets_registry, name) |> List.first |> elem(1))[:counts])-1
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
