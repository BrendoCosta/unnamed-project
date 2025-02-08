defmodule Izumi.Model.User do
  import Peri

  defstruct [
    :email,
    :password
  ]

  @type t() :: %__MODULE__{
    email: String.t(),
    password: String.t()
  }

  defschema :user, %{
    email: {:required, :string},
    password: {:required, :string}
  }
end
