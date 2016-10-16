defmodule Pke.KeysTest do
  use ExUnit.Case
  doctest Pke.Keys

  setup_all do
    Pke.Keys.start_link
    :ok
  end

  test "returns public key" do
    assert Pke.Keys.public_key == Pke.Keys.Mock.public_key
  end

  test "returns private key" do
    assert Pke.Keys.private_key == Pke.Keys.Mock.private_key
  end

  test "returns random session key" do
    assert Pke.Keys.session_key != Pke.Keys.private_key
    assert Pke.Keys.session_key != Pke.Keys.public_key
  end
end
