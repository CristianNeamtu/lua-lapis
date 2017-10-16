import Widget from require "lapis.html"

class HomeHeader extends Widget
  content: =>
    div class: "head", ->
        div class: "menu",  "Le menu..."
