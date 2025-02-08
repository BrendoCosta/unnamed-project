defmodule Izumi.Endpoint do

  use Plug.Router

  #require Logger

  plug Plug.Parsers,
    parsers: [:json, :urlencoded],
    json_decoder: Jason
  plug :match
  plug :dispatch
  #plug Plug.Logger

  # Forwarding
  # forward "/v2", to: Izumi.V2.Router
  forward "/users", to: Izumi.Controller.UserController

  # You should put a catch-all here
  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
