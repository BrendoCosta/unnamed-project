defprotocol Izumi.Model.EntitySchema do
  @spec schema(module | struct) :: any
  def schema(struct)
end

defmodule Izumi.Model.Entity do
  @spec decode(module | struct, any) :: {:ok, struct} | {:error, any}
  def decode(target, data) do
    case Peri.validate(Izumi.Model.EntitySchema.schema(target.__struct__()), data) do
      {:ok, data} -> {:ok, struct(target.__struct__(), data)}
      {:error, reason} -> {:error, reason}
    end
  end
end
