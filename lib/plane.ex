defmodule Plane do
  @moduledoc """
  A DSL for working with LevelDB
  """

  @doc false
  defmacro __using__(_) do
    quote do
      import Plane
      import Exleveldb, only: is_empty?/1
    end
  end

  @doc """
  Create a scope for a datastore.
  """
  defmacro with_level(db_name, db_opts \\ [create_if_missing: true], do: block) do
    quote do
      {:ok, var!(db)} = Exleveldb.open(unquote(db_name), unquote(db_opts))
      unquote(block)
      Exleveldb.close(var!(db))
    end
  end

  defmacro put(key, val) do
    quote do
      Exleveldb.put(var!(db), unquote(key), unquote(val))
    end
  end

  defmacro get(key) do
    quote do
      Exleveldb.get(var!(db), unquote(key))
    end
  end

  defmacro delete(key) do
    quote do
      Exleveldb.delete(var!(db), key)
    end
  end

  def destroy(db_name), do: Exleveldb.destroy(db_name)
end
