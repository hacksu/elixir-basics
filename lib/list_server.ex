defmodule ListServer do
  use GenServer
  @moduledoc """
  ListServer stores a list as the state of a process, and provides functionality
  to interact with that list in basic ways.
  """

  # Client API
  def start_link do
    GenServer.start_link(ListServer, [])
  end

  @doc """
  Retreives the current state of the list server

  #### Usage

      iex> {:ok, server} = ListServer.start_link
      iex> ListServer.get server
      []

  """
  def get(pid) do
    GenServer.call(pid, :get)
  end

  @doc """
  Add an item to the list

  #### Usage

      iex> {:ok, server} = ListServer.start_link
      iex> ListServer.add server, :hello
      iex> ListServer.get server
      [:hello]

  """
  def add(pid, item) do
    GenServer.call(pid, {:add, item})
  end

  @doc """
  Remove an item from the list

  ## Usage

      iex> {:ok, server} = ListServer.start_link
      iex> ListServer.add server, :hello
      iex> ListServer.remove server, :hello
      iex> ListServer.get server
      []

  """
  def remove(pid, item) do
    GenServer.call(pid, {:remove, item})
  end

  # GenServer API
  def handle_call(:get, _from, list) do
    {:reply, list, list}
  end

  def handle_call({:add, item}, _from, list) do
    {:reply, item, [item] ++ list}
  end

  def handle_call({:remove, item}, _from, list) do
    {:reply, item, List.delete(list, item)}
  end

end
