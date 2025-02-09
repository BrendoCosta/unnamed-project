defmodule Izumi.Repository.UserRepository do
  alias Izumi.Model.Entity
  alias Izumi.Model.User

  @collection "users"

  @spec list() :: [User.t()]
  def list() do
    :mongo
    |> Mongo.find(@collection, %{})
    |> Enum.to_list()
  end

  def find_by_email(email) do
    case Mongo.find_one(:mongo, @collection, %{email: email}) do
      data when is_map(data) -> Entity.decode(User, data)
      nil -> {:ok, nil}
      {:error, _} = error -> error
    end
  end

  @spec save(User.t()) :: :ok | :error
  def save(user) do
    case :mongo
         |> Mongo.find_one_and_replace(@collection, %{email: user.email}, user |> Map.from_struct(), upsert: true)
    do
      {:ok, _} -> :ok
      {:error, error} ->
        IO.puts("MongoDB error #{inspect(error)}")
        :error
    end
  end
end
