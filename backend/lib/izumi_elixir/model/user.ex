defmodule Izumi.Model.User do
  defstruct [
    :email,
    :password
  ]

  @type t() :: %__MODULE__{
    email: String.t(),
    password: String.t()
  }

  defimpl Izumi.Model.EntitySchema do
    @spec schema(module | struct) :: any
    def schema(_) do
      %{
        email: {:required, :string},
        password: {:required, :string}
      }
    end
  end
end
