defmodule Indicators.ModelsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Indicators.Models` context.
  """

  @doc """
  Generate a unit.
  """
  def unit_fixture(attrs \\ %{}) do
    {:ok, unit} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Indicators.Models.create_unit()

    unit
  end
end
