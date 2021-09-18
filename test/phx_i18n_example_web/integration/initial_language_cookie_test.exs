defmodule PhxI18nExampleWeb.InitialLanguageCookieTest do
  use PhxI18nExampleWeb.ConnCase
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  require Translations

  @cookie "phxi18nexamplelanguage"

  setup %{conn: conn, language: language} do
    {:ok, view, _html} =
      conn
      |> put_req_cookie(@cookie, language)
      |> live("/")

    heading =
      view
      |> element("h1")
      |> render()

    {:ok, [heading: heading, title: page_title(view)]}
  end

  @tag language: "en"
  test "displays English when initial language cookie is set to English",
       %{heading: heading, title: title} do
    assert heading =~ Translations.english_body()
    assert title == Translations.english_title()
  end

  @tag language: "it"
  test "displays Italian when initial language cookie is set to Italian",
       %{heading: heading, title: title} do
    assert heading =~ Translations.italian_body()
    assert title == Translations.italian_title()
  end

  @tag language: "ja"
  test "displays Japanese when initial language cookie is set to Japanese",
       %{heading: heading, title: title} do
    assert heading =~ Translations.japanese_body()
    assert title == Translations.japanese_title()
  end

  @tag language: "fr"
  test """
       displays English when initial language cookie is set to an
       unknown language
       """,
       %{heading: heading, title: title} do
    assert heading =~ Translations.english_body()
    assert title == Translations.english_title()
  end

  @tag language: ""
  test "displays English when initial language cookie is blank",
       %{heading: heading, title: title} do
    assert heading =~ Translations.english_body()
    assert title == Translations.english_title()
  end
end
