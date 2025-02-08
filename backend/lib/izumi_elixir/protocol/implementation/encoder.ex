defimpl Jason.Encoder, for: BSON.ObjectId do
  @spec encode(BSON.ObjectId.t(), any()) :: binary()
  @spec encode(BSON.ObjectId.t()) :: binary()
  def encode(val, _opts \\ []) do
    BSON.ObjectId.encode!(val)
    |> Jason.encode!()
  end
end
