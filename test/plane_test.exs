defmodule PlaneTest do
  use ExUnit.Case
  use Plane

  setup do
    on_exit fn ->
      File.rm_rf("testdb")
    end
  end
  
  test "A database can be created" do
    with_level "testdb" do
      assert Exleveldb.is_empty?(db)
    end
  end

  test "A database can be destroyed" do
    with_level "testdb" do
      Exleveldb.destroy "testdb"
    end
  end

  test "A database is closed when leaving the with_level scope" do
    with_level "testdb" do
      :stuff_happens_in_here
    end
    
    assert_raise ArgumentError, fn ->
      Exleveldb.close(db)
    end
  end
end
