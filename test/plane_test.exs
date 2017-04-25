defmodule PlaneTest do
  use ExUnit.Case
  use Plane
  
  test "A database can be created" do
    with_level "testdb1" do
      assert Exleveldb.is_empty?(db)
    end
  end

  test "A database can be destroyed" do
    with_level "testdb2" do
      Exleveldb.destroy "testdb2"
    end
  end

  test "A database is closed when leaving the with_level scope" do
    with_level "testdb3" do
      :stuff_happens_in_here
    end
    
    assert_raise ArgumentError, fn ->
      Exleveldb.close(db)
    end
  end

  for x <- ["testdb1", "testdb2", "testdb3"], do: Exleveldb.destroy(x)
end
