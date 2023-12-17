defmodule Indicators.ModelsTest do
  use Indicators.DataCase

  alias Indicators.Models

  describe "units" do
    alias Indicators.Models.Unit

    import Indicators.ModelsFixtures

    @invalid_attrs %{name: nil}

    test "list_units/0 returns all units" do
      unit = unit_fixture()
      assert Models.list_units() == [unit]
    end

    test "get_unit!/1 returns the unit with given id" do
      unit = unit_fixture()
      assert Models.get_unit!(unit.id) == unit
    end

    test "create_unit/1 with valid data creates a unit" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Unit{} = unit} = Models.create_unit(valid_attrs)
      assert unit.name == "some name"
    end

    test "create_unit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Models.create_unit(@invalid_attrs)
    end

    test "update_unit/2 with valid data updates the unit" do
      unit = unit_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Unit{} = unit} = Models.update_unit(unit, update_attrs)
      assert unit.name == "some updated name"
    end

    test "update_unit/2 with invalid data returns error changeset" do
      unit = unit_fixture()
      assert {:error, %Ecto.Changeset{}} = Models.update_unit(unit, @invalid_attrs)
      assert unit == Models.get_unit!(unit.id)
    end

    test "delete_unit/1 deletes the unit" do
      unit = unit_fixture()
      assert {:ok, %Unit{}} = Models.delete_unit(unit)
      assert_raise Ecto.NoResultsError, fn -> Models.get_unit!(unit.id) end
    end

    test "change_unit/1 returns a unit changeset" do
      unit = unit_fixture()
      assert %Ecto.Changeset{} = Models.change_unit(unit)
    end
  end
end
