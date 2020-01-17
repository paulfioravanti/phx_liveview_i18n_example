defmodule PhxI18nExampleWeb.LanguageDropdownLive do
  use Phoenix.LiveView
  alias PhxI18nExampleWeb.{Endpoint, LanguageDropdownView}

  @locales Gettext.known_locales(PhxI18nExampleWeb.Gettext)
  @locale_changes "locale-changes:"
  @dropdown_changes "dropdown-changes:"

  def mount(%{locale: locale, user_id: user_id}, socket) do
    Endpoint.subscribe(@dropdown_changes <> user_id)
    socket = init_dropdown_state(socket, locale, user_id)
    {:ok, socket}
  end

  def render(assigns) do
    LanguageDropdownView.render("language_dropdown.html", assigns)
  end

  def handle_event("hide", _value, socket) do
    socket = assign(socket, :show_available_locales, false)
    {:noreply, socket}
  end

  def handle_event("toggle", _value, socket) do
    %{assigns: %{show_available_locales: show_available_locales}} = socket
    socket = assign(socket, :show_available_locales, !show_available_locales)
    {:noreply, socket}
  end

  def handle_event("locale-changed", %{"locale" => locale}, socket) do
    %{assigns: %{user_id: user_id}} = socket

    Endpoint.broadcast_from(
      self(),
      @locale_changes <> user_id,
      "change-locale",
      %{locale: locale}
    )

    socket = init_dropdown_state(socket, locale, user_id)
    {:noreply, socket}
  end

  def handle_info(%{event: "hide-dropdown"}, socket) do
    socket = assign(socket, :show_available_locales, false)
    {:noreply, socket}
  end

  defp init_dropdown_state(socket, locale, user_id) do
    selectable_locales = List.delete(@locales, locale)

    assign(
      socket,
      %{
        user_id: user_id,
        locale: locale,
        selectable_locales: selectable_locales,
        show_available_locales: false
      }
    )
  end
end
