defmodule Pke.Encrypter.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: Pke.Encrypter.Supervisor)
  end

  def init([]) do
    children = [
      worker(Pke.Encrypter, [])
    ]
    opts = [strategy: :simple_one_for_one, name: __MODULE__]
    supervise(children, opts)
  end

  def start_child(data) do
    Supervisor.start_child(__MODULE__, [data])
  end
end
