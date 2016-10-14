defmodule Pke do
  def encrypt(data) when is_binary(data) do
    {pid, ref} = spawn_monitor(Pke.Encrypter, :init, [data, self])
    receive do
      {^pid, encrypted_message} ->
        Process.demonitor(ref, [:flush])
        {:ok, encrypted_message}
      {"DOWN", ^ref, :process, ^pid, reason} ->
        {:error, reason}
      _ ->
        {:error}
    after
      10000 ->
        {:error, :timeout}
    end
  end

  def encrypt(_data) do
    {:error, "Data must be binary."}
  end
end
