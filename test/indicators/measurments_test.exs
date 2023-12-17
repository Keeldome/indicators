defmodule Indicators.MeasurmentsTest do
  use Indicators.DataCase

  alias Indicators.Measurments

  describe "measurements" do
    alias Indicators.Measurments.Measurement

    import Indicators.MeasurmentsFixtures

    @invalid_attrs %{temperature: nil, humidity: nil}

    test "list_measurements/0 returns all measurements" do
      measurement = measurement_fixture()
      assert Measurments.list_measurements() == [measurement]
    end

    test "get_measurement!/1 returns the measurement with given id" do
      measurement = measurement_fixture()
      assert Measurments.get_measurement!(measurement.id) == measurement
    end

    test "create_measurement/1 with valid data creates a measurement" do
      valid_attrs = %{temperature: 120.5, humidity: 120.5}

      assert {:ok, %Measurement{} = measurement} = Measurments.create_measurement(valid_attrs)
      assert measurement.temperature == 120.5
      assert measurement.humidity == 120.5
    end

    test "create_measurement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Measurments.create_measurement(@invalid_attrs)
    end

    test "update_measurement/2 with valid data updates the measurement" do
      measurement = measurement_fixture()
      update_attrs = %{temperature: 456.7, humidity: 456.7}

      assert {:ok, %Measurement{} = measurement} = Measurments.update_measurement(measurement, update_attrs)
      assert measurement.temperature == 456.7
      assert measurement.humidity == 456.7
    end

    test "update_measurement/2 with invalid data returns error changeset" do
      measurement = measurement_fixture()
      assert {:error, %Ecto.Changeset{}} = Measurments.update_measurement(measurement, @invalid_attrs)
      assert measurement == Measurments.get_measurement!(measurement.id)
    end

    test "delete_measurement/1 deletes the measurement" do
      measurement = measurement_fixture()
      assert {:ok, %Measurement{}} = Measurments.delete_measurement(measurement)
      assert_raise Ecto.NoResultsError, fn -> Measurments.get_measurement!(measurement.id) end
    end

    test "change_measurement/1 returns a measurement changeset" do
      measurement = measurement_fixture()
      assert %Ecto.Changeset{} = Measurments.change_measurement(measurement)
    end
  end

  describe "measurements" do
    alias Indicators.Measurments.Measurement

    import Indicators.MeasurmentsFixtures

    @invalid_attrs %{}

    test "list_measurements/0 returns all measurements" do
      measurement = measurement_fixture()
      assert Measurments.list_measurements() == [measurement]
    end

    test "get_measurement!/1 returns the measurement with given id" do
      measurement = measurement_fixture()
      assert Measurments.get_measurement!(measurement.id) == measurement
    end

    test "create_measurement/1 with valid data creates a measurement" do
      valid_attrs = %{}

      assert {:ok, %Measurement{} = measurement} = Measurments.create_measurement(valid_attrs)
    end

    test "create_measurement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Measurments.create_measurement(@invalid_attrs)
    end

    test "update_measurement/2 with valid data updates the measurement" do
      measurement = measurement_fixture()
      update_attrs = %{}

      assert {:ok, %Measurement{} = measurement} = Measurments.update_measurement(measurement, update_attrs)
    end

    test "update_measurement/2 with invalid data returns error changeset" do
      measurement = measurement_fixture()
      assert {:error, %Ecto.Changeset{}} = Measurments.update_measurement(measurement, @invalid_attrs)
      assert measurement == Measurments.get_measurement!(measurement.id)
    end

    test "delete_measurement/1 deletes the measurement" do
      measurement = measurement_fixture()
      assert {:ok, %Measurement{}} = Measurments.delete_measurement(measurement)
      assert_raise Ecto.NoResultsError, fn -> Measurments.get_measurement!(measurement.id) end
    end

    test "change_measurement/1 returns a measurement changeset" do
      measurement = measurement_fixture()
      assert %Ecto.Changeset{} = Measurments.change_measurement(measurement)
    end
  end
end
