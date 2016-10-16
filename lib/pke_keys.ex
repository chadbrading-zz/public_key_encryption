defmodule Pke.Keys do
  use GenServer
  @source Application.get_env(:pke, :keys)

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def public_key do
    GenServer.call(__MODULE__, :public_key)
  end

  def private_key do
    GenServer.call(__MODULE__, :private_key)
  end

  def session_key do
    GenServer.call(__MODULE__, :session_key)
  end

  def init([]) do
    {:ok, %{public_key: fetch_public_key, private_key: fetch_private_key, session_key: generate_session_key}}
  end

  def handle_call(:public_key, _from, %{public_key: key} = keys) do
    {:reply, key, keys}
  end

  def handle_call(:private_key, _from, %{private_key: key} = keys) do
    {:reply, key, keys}
  end

  def handle_call(:session_key, _from, %{session_key: key} = keys) do
    {:reply, key, keys}
  end

  defp fetch_public_key do
    @source.public_key
  end

  defp fetch_private_key do
    @source.private_key
  end

  defp generate_session_key do
    :crypto.strong_rand_bytes(32)
  end
end
