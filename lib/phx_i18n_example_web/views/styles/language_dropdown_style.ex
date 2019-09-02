defmodule PhxI18nExampleWeb.LanguageDropdownStyle do
  @caret_classes ~w[
    absolute
    ml2
  ] |> Enum.join(" ")

  @current_selection_classes ~w[
    b--white
    ba
    br2
    pa2
    pointer
    tc
    w4
  ] |> Enum.join(" ")

  @current_selection_link_classes ~w[
    no-underline
    white
  ] |> Enum.join(" ")

  @dropdown_container_classes ~w[
    center
    f3
    flex
    h3
    items-center
    justify-end
    w-90
  ] |> Enum.join(" ")

  @dropdown_list_classes ~w[
    absolute
    b--white
    bb
    bl
    br
    br--bottom
    br2
    items-center
    list
    mt5
    pl0
    pointer
    pr0
    pt1
    tc
    top-0
    w4
  ] |> Enum.join(" ")

  @dropdown_list_item_classes ~w[
    hover-bg-white
    hover-dark-pink
    ph1
    pv2
    pt0
    w-100
  ] |> Enum.join(" ")

  @dropdown_list_item_link_classes ~w[
    no-underline
    w-100
    white
  ] |> Enum.join(" ")

  @main_classes ~w[
    bg-dark-pink
    overflow-container
    pt3
    sans-serif
    vh-100
    white
  ] |> Enum.join(" ")

  def caret, do: @caret_classes

  def current_selection(show_available_locales) do
    display_classes =
      if show_available_locales do
        " br--top"
      else
        ""
      end

    @current_selection_classes <> display_classes
  end

  def current_selection_link, do: @current_selection_link_classes

  def dropdown_container, do: @dropdown_container_classes

  def dropdown_list(show_available_locales) do
    display_classes =
      if show_available_locales do
        " flex flex-column"
      else
        " dn"
      end

    @dropdown_list_classes <> display_classes
  end

  def dropdown_list_item, do: @dropdown_list_item_classes
  def dropdown_list_item_link, do: @dropdown_list_item_link_classes

  def main, do: @main_classes
end
