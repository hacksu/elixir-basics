defmodule ListServerTest do
  use ExUnit.Case
  doctest ListServer

  test "items can get added to the list" do
    {:ok, pid} = ListServer.start_link
    assert ListServer.get(pid) == []
    ListServer.add pid, :milk
    assert ListServer.get(pid) == [:milk]
  end

  test "items can get removed from the list" do
    {:ok, pid} = ListServer.start_link
    assert ListServer.get(pid) == []
    ListServer.add pid, :milk
    ListServer.add pid, :eggs
    ListServer.remove pid, :eggs
    assert ListServer.get(pid) == [:milk]
  end
end
