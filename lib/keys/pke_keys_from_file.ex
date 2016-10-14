defmodule Pke.Keys.FromFile do
  # The instructions said to assume keys would be stored in a file on disk.
  def public_key do
    {:ok, key} = File.read("rsa.pub")
    key
  end

  def private_key do
    {:ok, key} = File.read("rsa.priv")
    key
  end
end
