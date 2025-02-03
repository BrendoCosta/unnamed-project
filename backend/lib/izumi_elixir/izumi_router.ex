defmodule Izumi.V1.Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/ping" do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello worldssssss")
  end
end
