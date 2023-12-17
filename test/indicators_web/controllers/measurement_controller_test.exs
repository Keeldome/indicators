defmodule IndicatorsWeb.MeasurementControllerTest do
  use IndicatorsWeb.ConnCase

  import Indicators.MeasurmentsFixtures

  alias Indicators.Measurments.Measurement

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all measurements", %{conn: conn} do
      conn = get(conn, ~p"/api/measurements")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create measurement" do
    test "renders measurement when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/measurements", measurement: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/measurements/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/measurements", measurement: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update measurement" do
    setup [:create_measurement]

    test "renders measurement when data is valid", %{conn: conn, measurement: %Measurement{id: id} = measurement} do
      conn = put(conn, ~p"/api/measurements/#{measurement}", measurement: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/measurements/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, measurement: measurement} do
      conn = put(conn, ~p"/api/measurements/#{measurement}", measurement: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete measurement" do
    setup [:create_measurement]

    test "deletes chosen measurement", %{conn: conn, measurement: measurement} do
      conn = delete(conn, ~p"/api/measurements/#{measurement}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/measurements/#{measurement}")
      end
    end
  end

  defp create_measurement(_) do
    measurement = measurement_fixture()
    %{measurement: measurement}
  end
end
