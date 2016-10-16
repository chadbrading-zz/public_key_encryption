defmodule Pke.Encrypter.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: Pke.Encrypter.Supervisor)
  end

  def init([]) do
    {:ok,
      {{:simple_one_for_one, 3, 5},
        [{Pke.Encrypter, {Pke.Encrypter, :start_link, []}, :permanent, 5000,
          :worker, [Pke.Encrypter]}]}}
  end

  def start_child(data) do
    Supervisor.start_child(__MODULE__, [data])
  end
end
