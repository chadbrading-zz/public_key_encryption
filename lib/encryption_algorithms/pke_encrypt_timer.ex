defmodule Pke.Encrypt.Timer do
  # The instructions said to use the following implemention for the encryption algorithm:
  def encrypt(_key, data) do
    :timer.sleep(2000)
    data
  end
end
