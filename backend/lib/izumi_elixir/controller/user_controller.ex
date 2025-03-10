defmodule Izumi.Controller.UserController do
  alias Izumi.Model.Entity
  alias Izumi.Model.User
  alias Izumi.Repository.UserRepository
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.send_resp(200, Jason.encode!(UserRepository.list(), pretty: true))
  end

  post "/" do
    case Entity.decode(User, conn.body_params) do
      {:ok, user} ->
        :ok = UserRepository.save(%User{user | password: Bcrypt.hash_pwd_salt(user.password)})
        IO.puts("User #{user.email} successfully registered")
        Plug.Conn.send_resp(conn, 200, "")
      {:error, reason} ->
        IO.inspect(reason)
        Plug.Conn.send_resp(conn, 400, "")
    end
  end

  post "/login" do
    case Entity.decode(User, conn.body_params) do
      {:ok, user} ->
        {:ok, user_bd} = UserRepository.find_by_email(user.email)
        case Bcrypt.verify_pass(user.password, user_bd.password) do
          true ->
            token = Izumi.Token.generate_and_sign!(%{"email" => user.email})
            token = "Bearer #{token}"
            IO.puts("User #{user.email} successfully logged-in \nToken = #{token}")
            conn
            |> Plug.Conn.put_resp_header("authorization", token)
            |> Plug.Conn.send_resp(200, "")
          false ->
            Plug.Conn.send_resp(conn, 401, "")
        end
      {:error, _} ->
        Plug.Conn.send_resp(conn, 400, "")
    end
  end

  get "/test" do
    authenticate(conn, fn (conn, claims) ->
      IO.puts("User #{claims["email"]} accessed restricted area")
      Plug.Conn.send_resp(conn, 200, "OK")
    end)
  end

  @spec authenticate(Plug.Conn.t(), function()) :: {:ok, Plug.Conn.t(), %{optional(binary()) => any()}} | Plug.Conn.t()
  def authenticate(conn, callback) do
    case Plug.Conn.get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        case Izumi.Token.verify_and_validate(token) do
          {:ok, claims} ->
            IO.puts("User successfully authenticated #{claims["email"]}")
            callback.(conn, claims)
          {:error, _reason} -> Plug.Conn.send_resp(conn, 401, "")
        end
      _ -> Plug.Conn.send_resp(conn, 400, "")
    end
  end
end
