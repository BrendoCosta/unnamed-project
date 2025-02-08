defmodule Mongo.Migrations.Mongo.AddUsersIndexes do
  def up() do
    # The `up` functions will be executed when running `mix mongo.migrate`
    indexes = [
      [key: [email: 1], name: "email_index", unique: true]
    ]
    Mongo.create_indexes(:mongo, "users", indexes)
  end

  def down() do
    # The `down` functions will be executed when running `mix mongo.drop`
    Mongo.drop_index(:mongo, "users", "email_index")
  end
end
