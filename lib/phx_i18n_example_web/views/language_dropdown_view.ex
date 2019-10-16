defmodule PhxI18nExampleWeb.LanguageDropdownView do
  use PhxI18nExampleWeb, :view
  alias PhxI18nExampleWeb.LanguageDropdownStyle

  @locale_strings %{
    "en" => "English",
    "it" => "Italiano",
    "ja" => "日本語"
  }

  defdelegate caret, to: LanguageDropdownStyle

  defdelegate current_selection(show_available_locales),
    to: LanguageDropdownStyle

  defdelegate dropdown_container, to: LanguageDropdownStyle
  defdelegate dropdown_list(show_available_locales), to: LanguageDropdownStyle
  defdelegate dropdown_list_item, to: LanguageDropdownStyle

  def locale_to_string(locale), do: @locale_strings[locale]

  def current_locale(current_locale, show_available_locales) do
    content_tag(:p,
      class: current_selection(show_available_locales),
      id: current_locale,
      name: "current_locale",
      "phx-click": "toggle",
      "phx-hook": "currentLocale"
    ) do
      [
        content_tag(:span, locale_to_string(current_locale)),
        content_tag(:span, "▾", class: caret())
      ]
    end
  end

  def locale_list_item(locale) do
    content_tag(
      :li,
      locale_to_string(locale),
      id: locale,
      class: dropdown_list_item(),
      role: "selectable_locale",
      "phx-click": "change-locale",
      "phx-value-locale": locale
    )
  end
end
