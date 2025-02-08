defmodule Izumi.Controller.UserController do
  alias Izumi.Model.User
  alias Izumi.Repository.UserRepository
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    conn
    |> Plug.Conn.put_resp_content_type("application/json")
    |> Plug.Conn.send_resp(400, Jason.encode!(UserRepository.list(), pretty: true))
  end

  post "/" do
    case User.user(conn.body_params) do
      {:ok, data} ->
        user = struct(User, data)
        :ok = UserRepository.save(%User{user | password: Bcrypt.hash_pwd_salt(user.password)})
        IO.puts("User #{user.email} successfully registered")
        Plug.Conn.send_resp(conn, 200, "")
      {:error, errors} ->
        IO.inspect(errors)
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.send_resp(400, Jason.encode!(errors |> Enum.map(&(&1.message)), pretty: true))
      #{:error, [%Peri.Error{} | _rest] = validation_errors} -> for error <- validation_errors do
      #  case error do
      #    %Peri.Error{key: :password} -> IO.puts("Password validation error")
      #    _ -> IO.puts("Another validation error")
      #  end
      #end
    end
  end

  post "/login" do
    case User.user(conn.body_params) do
      {:ok, data} ->
        user = struct(User, data)
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
    {:ok, conn, claims} = authenticate(conn)
    IO.puts("User #{claims["email"]} accessed restricted area")
    Plug.Conn.send_resp(conn, 200, "OK")
  end

  @spec authenticate(Plug.Conn.t()) :: {:ok, Plug.Conn.t(), %{optional(binary()) => any()}} | Plug.Conn.t()
  def authenticate(conn) do
    case Plug.Conn.get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        case Izumi.Token.verify_and_validate(token) do
          {:ok, claims} ->
            IO.puts("User successfully authenticated #{claims["email"]}")
            {:ok, conn, claims}
          {:error, _reason} -> Plug.Conn.send_resp(conn, 401, "")
        end
      _ -> Plug.Conn.send_resp(conn, 400, "")
    end
  end
end
