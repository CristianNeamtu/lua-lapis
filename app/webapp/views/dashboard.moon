import Widget from require "lapis.html"

Header = require "widgets.header"
Sidebar = require "widgets.sidebar"

class Index extends Widget
  content: =>
    head ->
        link {
            "rel": "stylesheet"
            "href": "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
        }
        script {"src": "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"}
    body ->
        div class: "header", ->
            widget Header
        div class: "body", ->
            widget Sidebar
