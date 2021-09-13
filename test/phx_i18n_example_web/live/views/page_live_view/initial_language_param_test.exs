defmodule PhxI18nExampleWeb.PageLiveView.InitialLanguageParamTest do
  use PhxI18nExampleWeb.ConnCase
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  require Constants

  setup %{conn: conn, language: language} do
    {:ok, view, _html} = live(conn, "/?locale=#{language}")

    heading =
      view
      |> element("h1")
      |> render()

    {:ok, [heading: heading, title: page_title(view)]}
  end

  @tag language: "en"
  test "displays English when initial language param is set to English",
       %{heading: heading, title: title} do
    assert heading =~ Constants.english_body()
    assert title == Constants.english_title()
  end

  @tag language: "it"
  test "displays Italian when initial language param is set to Italian",
       %{heading: heading, title: title} do
    assert heading =~ Constants.italian_body()
    assert title == Constants.italian_title()
  end

  @tag language: "ja"
  test "displays Japanese when initial language param is set to Japanese",
       %{heading: heading, title: title} do
    assert heading =~ Constants.japanese_body()
    assert title == Constants.japanese_title()
  end

  @tag language: "fr"
  test """
       displays English when initial language param is set to an
       unknown language
       """,
       %{heading: heading, title: title} do
    assert heading =~ Constants.english_body()
    assert title == Constants.english_title()
  end

  @tag language: ""
  test "displays English when initial language param is blank",
       %{heading: heading, title: title} do
    assert heading =~ Constants.english_body()
    assert title == Constants.english_title()
  end
end
