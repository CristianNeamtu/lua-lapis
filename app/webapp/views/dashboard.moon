import Widget from require "lapis.html"

Header = require "widgets.header"
Sidebar = require "widgets.sidebar"

class Index extends Widget
  content: =>
    div class: "header", ->
        widget Header
    div class: "body", ->
        widget Sidebar
