defmodule PkeTest do
  use ExUnit.Case
  doctest Pke

  test "returns error when data isn't binary" do
    {:error, "Data must be binary."} = Pke.encrypt(5932023)
  end

  test "returns message and signature" do
    {:ok, %{message: %{data: _data, session_key: _session_key}, signature: _signature}} = Pke.encrypt("foo")
  end
end
