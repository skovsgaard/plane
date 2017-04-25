defmodule Plane do
  @moduledoc """
  A DSL for working with LevelDB
  """

  @doc false
  defmacro __using__(_) do
    quote do
      import Plane
    end
  end

  @doc """
  Create a datastore.
  """
  defmacro with_level(db_name, db_opts \\ [create_if_missing: true], do: block) do
    quote do
      {:ok, var!(db)} = Exleveldb.open(unquote(db_name), unquote(db_opts))
      unquote(block)
      Exleveldb.close(var!(db))
    end
  end

  def destroy(db_name), do: Exleveldb.destroy(db_name)
end
