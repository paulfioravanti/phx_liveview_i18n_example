defmodule PhxI18nExampleWeb.LayoutStyle do
  @moduledoc false

  @body_classes ~w[
    bg-dark-pink
    overflow-container
    pt3
    sans-serif
    vh-100
    white
  ] |> Enum.join(" ")

  def body, do: @body_classes
end
