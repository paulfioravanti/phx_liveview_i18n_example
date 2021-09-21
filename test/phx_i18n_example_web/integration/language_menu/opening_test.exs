defmodule PhxI18nExampleWeb.LanguageMenu.OpeningTest do
  use PhxI18nExampleWeb.ConnCase
  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  require Translations

  setup %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    {:ok, [view: view]}
  end

  describe "default state" do
    setup %{view: view} do
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

  describe "opening the language menu" do
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

    test "language menu is visible", %{menu: menu} do
      assert menu =~ "flex"
      refute menu =~ "dn"
    end
  end
end
