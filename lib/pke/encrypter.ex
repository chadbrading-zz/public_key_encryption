defmodule Pke.Encrypter do
  use GenServer
  @encryption_algorithm Application.get_env(:pke, :encryption_algorithm)

  def start_link(data) do
    GenServer.start_link(__MODULE__, data)
  end

  def signed_message(pid) do
    GenServer.call(pid, :signed_message)
  end

  def init(data) do
    signed_message = encrypt_message(data)
    |> attach_signature(data)
    {:ok, signed_message}
  end

  def handle_call(:signed_message, _from, signed_message) do
    {:reply, {:ok, signed_message}, signed_message}
  end

  def encrypt_message(data) do
    %{data: data, session_key: Pke.Keys.session_key}
    |> encrypt_data
    |> encrypt_session_key
  end

  def encrypt_data(%{data: data, session_key: session_key}) do
    %{data: encrypt(session_key, data), session_key: session_key}
  end

  def encrypt_session_key(%{data: encrypted_data, session_key: session_key}) do
    %{data: encrypted_data, session_key: encrypt(Pke.Keys.public_key, session_key)}
  end

  def attach_signature(%{data: encrypted_data, session_key: encrypted_session_key}, data) do
    %{message: %{data: encrypted_data, session_key: encrypted_session_key}, signature: encrypt(Pke.Keys.private_key, hash(data))}
  end

  def encrypt(key, data) when is_binary(key) and is_binary(data) do
    @encryption_algorithm.encrypt(key, data)
  end

  def hash(data) do
    :crypto.hash(:sha256, data)
  end
end
