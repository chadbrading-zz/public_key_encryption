defmodule Pke do
  use Application

  def start(_type, _args) do
   Pke.Supervisor.start_link
  end

  def encrypt(data) when is_binary(data) do
    {:ok, pid} = Pke.Encrypter.Supervisor.start_child(data)
    Pke.Encrypter.signed_message(pid)
  end

  def encrypt(_data) do
    {:error, "Data must be binary."}
  end
end
