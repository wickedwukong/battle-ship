defmodule BattleshipHallWeb.GameView do
  use BattleshipHallWeb, :view

  def grid_glyph(size) do
    content_tag :div, class: "grid-glyph" do
      for _row <- 1..size do
        content_tag :div, class: "row" do
          for _col <- 1..size do
            content_tag(:span, "", class: "box")
          end
        end
      end
    end
  end
end
