defmodule Firehose.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Firehose.Repo, []),
      supervisor(FirehoseWeb.Endpoint, []),
      worker(Firehose.Importer, []),
    ]

    opts = [strategy: :one_for_one, name: Firehose.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    FirehoseWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
