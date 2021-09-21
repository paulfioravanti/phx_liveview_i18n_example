defmodule PhxI18nExampleWeb.LanguageMenu.ClosingTest do
  use PhxI18nExampleWeb.ConnCase
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  require Translations

  setup %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    view
    |> element("p")
    |> render_click()

    {:ok, [view: view]}
  end

  describe "closing the language menu by clicking the open menu" do
    setup %{view: view} do
      view
      |> element("p")
      |> render_click()

      menu =
        view
        |> element("ul")
        |> render()

      {:ok, [menu: menu]}
    end

    test "language menu is not visible", %{menu: menu} do
      assert menu =~ "dn"
      refute menu =~ "flex"
    end
  end

  describe "closing the language menu by clicking elsewhere on the page" do
    setup %{view: view} do
      view
      |> element("article")
      |> render_click()

      menu =
        view
        |> element("ul")
        |> render()

      {:ok, [menu: menu]}
    end

    test "language menu is not visible", %{menu: menu} do
      assert menu =~ "dn"
      refute menu =~ "flex"
    end
  end

  describe "closing the language menu by changing language" do
    setup %{view: view} do
      view
      |> element("li", Translations.japanese_menu_label())
      |> render_click()

      menu =
        view
        |> element("ul")
        |> render()

      {:ok, [menu: menu]}
    end

    test "language menu is not visible", %{menu: menu} do
      assert menu =~ "dn"
      refute menu =~ "flex"
    end
  end
end
