defmodule Pke.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      worker(Pke.Keys, []),
      supervisor(Pke.Encrypter.Supervisor, [], name: Pke.Encrypter.Supervisor)
    ]

    supervise(children, strategy: :one_for_one)
  end
end
