defmodule Izumi.V1.Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  post "/registrar" do
    # Pega os dados e valida

    {:ok, body, conn} = Plug.Conn.read_body(conn)
    dados_login = Jason.decode!(body)

    # Imagina que nessa parte aqui a gente salva num banco de dados...
    # ...

    IO.puts("Novo usuário cadastrado #{inspect(dados_login)}")

    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.resp(200, "")
    |> Plug.Conn.send_resp()
  end

  get "/login" do
    signer = Joken.Signer.create("HS256", "secret")
    {:ok, token, claims} = Izumi.Token.generate_and_sign(%{"email" => "teste@exemplo.com", "password" => "1234"}, signer)
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, token)
  end

  get "/ping" do
    signer = Joken.Signer.create("HS256", "secret")
    {:ok, claims} = Izumi.Token.verify_and_validate("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKb2tlbiIsImVtYWlsIjoidGVzdGVAZXhlbXBsby5jb20iLCJleHAiOjE3Mzg2MzU3NTUsImlhdCI6MTczODYyODU1NSwiaXNzIjoiSm9rZW4iLCJqdGkiOiIzMGdkaXRkbmxsMWE4aWM2dDQwMDAwMDkiLCJuYmYiOjE3Mzg2Mjg1NTUsInBhc3N3b3JkIjoiMTIzNCJ9.hsp7UIKv3WUGTZKjn0fEiORzV1EnwKfvGWYAE2NaHXg", signer)
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, Jason.encode!(claims))
  end
end
