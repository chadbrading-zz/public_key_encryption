defmodule Pke.Keys.Mock do
  @public_key :crypto.strong_rand_bytes(16)
  @private_key :crypto.strong_rand_bytes(16)

  def public_key do
    @public_key
  end

  def private_key do
    @private_key
  end
end
