defmodule HttpService.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HttpService.Telemetry,
      HttpService.Endpoint,
      EtsService
    ]

    opts = [strategy: :one_for_one, name: HttpService.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    HttpService.Endpoint.config_change(changed, removed)
    :ok
  end
end