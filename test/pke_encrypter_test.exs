defmodule Pke.EncrypterTest do
  use ExUnit.Case
  doctest Pke.Encrypter

  test "encrypt_message return data and session_key" do
    %{data: _data, session_key: _session_key} = Pke.Encrypter.encrypt_message("foo")
  end

  test "attach_signature returns message and signature" do
    %{message: _message, signature: _signature} = Pke.Encrypter.attach_signature(%{data: "f2o2o2", session_key: "1234567890"}, "foo")
  end

  test "signed_message returns message with data, session_key and signature" do
    {:ok, pid} = Pke.Encrypter.start_link("foo")
    {:ok, %{message: %{data: _data, session_key: _session_key}, signature: _signature}} = Pke.Encrypter.signed_message(pid)
  end
end

