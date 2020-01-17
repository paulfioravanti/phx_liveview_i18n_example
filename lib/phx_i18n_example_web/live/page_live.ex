defmodule PhxI18nExampleWeb.PageLive do
  use Phoenix.LiveView
  alias PhxI18nExampleWeb.{Endpoint, PageView}

  @locale_changes "locale-changes:"
  @dropdown_changes "dropdown-changes:"

  def mount(%{locale: locale, user_id: user_id}, socket) do
    Endpoint.subscribe(@locale_changes <> user_id)
    socket = assign(socket, %{locale: locale, user_id: user_id})
    {:ok, socket}
  end

  def render(assigns) do
    PageView.render("index.html", assigns)
  end

  def handle_event("hide-dropdown", _value, socket) do
    %{assigns: %{user_id: user_id}} = socket

    Endpoint.broadcast_from(
      self(),
      @dropdown_changes <> user_id,
      "hide-dropdown",
      %{}
    )

    {:noreply, socket}
  end

  def handle_info(%{event: "change-locale", payload: payload}, socket) do
    %{locale: locale} = payload
    socket = assign(socket, :locale, locale)
    {:noreply, socket}
  end
end
