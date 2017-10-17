import Widget from require "lapis.html"

class HomeHeader extends Widget
  content: =>
    nav {"class": "navbar navbar-default"}, ->
      div class: "container-fluid", -> 
        div class: "navbar-header", ->
          button {
            "class":"navbar-toggle collapsed"
            "type":"button"
            "data-toggle": "collapse"
            "data-target":"#bs-example-navbar-collapse-1"
            "aria-expanded":"false"
            "aria-label":"Toggle navigation"
          }, ->
            span class:"sr-only", "Toggle navigation"
            span class:"icon-bar"
            span class:"icon-bar"
            span class:"icon-bar"
          element "a", class: "navbar-brand", "Lapis"