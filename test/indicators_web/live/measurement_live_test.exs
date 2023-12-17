defmodule IndicatorsWeb.MeasurementLiveTest do
  use IndicatorsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Indicators.MeasurmentsFixtures

  @create_attrs %{temperature: 120.5, humidity: 120.5}
  @update_attrs %{temperature: 456.7, humidity: 456.7}
  @invalid_attrs %{temperature: nil, humidity: nil}

  defp create_measurement(_) do
    measurement = measurement_fixture()
    %{measurement: measurement}
  end

  describe "Index" do
    setup [:create_measurement]

    test "lists all measurements", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/measurements")

      assert html =~ "Listing Measurements"
    end

    test "saves new measurement", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/measurements")

      assert index_live |> element("a", "New Measurement") |> render_click() =~
               "New Measurement"

      assert_patch(index_live, ~p"/measurements/new")

      assert index_live
             |> form("#measurement-form", measurement: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#measurement-form", measurement: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/measurements")

      html = render(index_live)
      assert html =~ "Measurement created successfully"
    end

    test "updates measurement in listing", %{conn: conn, measurement: measurement} do
      {:ok, index_live, _html} = live(conn, ~p"/measurements")

      assert index_live |> element("#measurements-#{measurement.id} a", "Edit") |> render_click() =~
               "Edit Measurement"

      assert_patch(index_live, ~p"/measurements/#{measurement}/edit")

      assert index_live
             |> form("#measurement-form", measurement: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#measurement-form", measurement: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/measurements")

      html = render(index_live)
      assert html =~ "Measurement updated successfully"
    end

    test "deletes measurement in listing", %{conn: conn, measurement: measurement} do
      {:ok, index_live, _html} = live(conn, ~p"/measurements")

      assert index_live |> element("#measurements-#{measurement.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#measurements-#{measurement.id}")
    end
  end

  describe "Show" do
    setup [:create_measurement]

    test "displays measurement", %{conn: conn, measurement: measurement} do
      {:ok, _show_live, html} = live(conn, ~p"/measurements/#{measurement}")

      assert html =~ "Show Measurement"
    end

    test "updates measurement within modal", %{conn: conn, measurement: measurement} do
      {:ok, show_live, _html} = live(conn, ~p"/measurements/#{measurement}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Measurement"

      assert_patch(show_live, ~p"/measurements/#{measurement}/show/edit")

      assert show_live
             |> form("#measurement-form", measurement: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#measurement-form", measurement: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/measurements/#{measurement}")

      html = render(show_live)
      assert html =~ "Measurement updated successfully"
    end
  end
end
