defmodule Pke.Keys.FromFile do
  @public_key_file "rsa.pub"
  @private_key_file "rsa.priv"

  # The instructions said to assume keys would be stored in a file on disk.
  def public_key do
    {:ok, key} = File.read(@public_key_file)
    key
  end

  def private_key do
    {:ok, key} = File.read(@private_key_file)
    key
  end
end
