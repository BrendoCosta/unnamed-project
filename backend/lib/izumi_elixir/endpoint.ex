defmodule Izumi.Endpoint do

  use Plug.Router

  #require Logger

  plug :match
  plug :dispatch
  #plug Plug.Logger
  plug Plug.Parsers,
    parsers: [:json, :urlencoded],
    json_decoder: Jason

  # Forwarding
  # forward "/v2", to: Izumi.V2.Router
  forward "/v1", to: Izumi.V1.Router

  # You should put a catch-all here
  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
