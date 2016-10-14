defmodule Pke.Keys do
  def public_key do
    source.public_key
  end

  def private_key do
    source.private_key
  end

  def generate_session_key do
    :crypto.strong_rand_bytes(32)
  end

  def source do
    Application.get_env(:pke, :keys)
  end
end
