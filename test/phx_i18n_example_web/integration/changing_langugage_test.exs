defmodule PhxI18nExampleWeb.ChangingLanguageTest do
  use PhxI18nExampleWeb.ConnCase
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  require Cookie
  require Translations

  @moduletag cookie: ""

  setup %{conn: conn, language: language, cookie: cookie} do
    {:ok, view, _html} =
      conn
      |> put_req_cookie(Cookie.key(), cookie)
      |> live("/")

    view
    |> element("p")
    |> render_click()

    view
    |> element("li", language)
    |> render_click()

    heading =
      view
      |> element("h1")
      |> render()

    {:ok, [heading: heading, title: page_title(view)]}
  end

  @tag language: Translations.italian_menu_label()
  test "displays Italian when language changed to Italian",
       %{heading: heading, title: title} do
    assert heading =~ Translations.italian_body()
    assert title == Translations.italian_title()
  end

  @tag language: Translations.japanese_menu_label()
  test "displays Japanese when language changed to Japanese",
       %{heading: heading, title: title} do
    assert heading =~ Translations.japanese_body()
    assert title == Translations.japanese_title()
  end

  @tag cookie: "ja"
  @tag language: Translations.english_menu_label()
  test "displays English when language changed to English",
       %{heading: heading, title: title} do
    assert heading =~ Translations.english_body()
    assert title == Translations.english_title()
  end
end
