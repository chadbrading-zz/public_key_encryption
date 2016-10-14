defmodule Pke.Encrypter do
  @encryption_algorithm Application.get_env(:pke, :encryption_algorithm)

  def init(data, pid) do
    send(pid, {self, start(data)})
  end

  def start(data) do
    encrypt_message(data)
    |> attach_signature(data)
  end

  def encrypt_message(data) do
    %{data: data, session_key: Pke.Keys.generate_session_key}
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
