defmodule PhxI18nExampleWeb.PageLive do
  use Phoenix.LiveView
  alias PhxI18nExampleWeb.{Endpoint, PageView}

  @locale_changes "locale-changes"
  @dropdown_changes "dropdown-changes"

  def mount(%{locale: locale}, socket) do
    Endpoint.subscribe(@locale_changes)
    socket = assign(socket, locale: locale)
    {:ok, socket}
  end

  def render(assigns) do
    PageView.render("index.html", assigns)
  end

  def handle_event("hide-dropdown", _value, socket) do
    Endpoint.broadcast_from(self(), @dropdown_changes, "hide-dropdown", %{})
    {:noreply, socket}
  end

  def handle_info(%{event: "change-locale", payload: payload}, socket) do
    %{locale: locale} = payload
    socket = assign(socket, :locale, locale)
    {:noreply, socket}
  end
end
