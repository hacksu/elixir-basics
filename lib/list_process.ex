defmodule ListProcess do
  def start_link do
    Task.start_link fn -> loop([]) end
  end

  def loop(list) do
    receive do
      {:get, caller} ->
        send caller, list
        loop list
      {:add, item} ->
        loop list ++ [item]
      {:remove, item} ->
        loop List.delete(list, item)
    end
  end
end