lapis = require "lapis"
console = require "lapis.console"
import respond_to from require "lapis.application"
import Model from require "lapis.db.model"
import split from require "moonscript.util"
import after_dispatch from require "lapis.nginx.context"
import to_json from require "lapis.util"
import capture_errors_json, yield_error, assert_error from require "lapis.application"

class Posts extends Model
    @timestamp: true
    @relations: {
        {"user", belongs_to: "Users"}
    }

class Users extends Model
    @relations: {
      {"posts", has_many: "Posts"}
    }

class Tags extends Model

class App extends lapis.Application
    views_prefix: "views"
    @enable "etlua"

    @before_filter =>
        after_dispatch ->
          print to_json(ngx.ctx.performance)

    handle_error: (err, trace) =>
        trace = trace\gsub "\t", ""
        status: 500, json: {
                error: err
                trace: split trace, "\n"
        }

    default_route: =>
        status: 404, json: "Nothing over here"

    "/": =>
        @html ->
            h1 class: "header", "Hello"
            div class: "body", ->
              text "Welcome to Lapis #{require "lapis.version"}!"

    "/new-user": =>
        render: "form"

    "/posts": =>
        @users = Posts\select!
        render: "posts"

    "/dashboard": =>
        render: "dashboard"

    "/api/users": respond_to {
        GET: =>
            users = Users\select!
            json: users

        POST: =>
            user = Users\create {
                name: @params.name
                email: @params.email
                display_name: @params.display_name
            }
            json: user
    }

    "/api/users/:id[%d]": respond_to {
        GET: capture_errors_json =>
            user = assert_error Users\find id: @params.id, "User does not exist"
            json: user
        DELETE: =>
            user = Users\find @params.id
            user\delete!
            json: user
    }

    "/api/users/:id[%d]/post": respond_to {
        POST: =>
            post = Posts\create {
                user_id: @params.id
                title: @params.title
                description: @params.description
            }
            json: post
    }

    "/api/tags": respond_to {
        POST: =>
            tag = Tags\create {
                name: @params.name
            }
            json: tag
    }

    "/api/tags": respond_to {
        GET: =>
            tags = Tags\select!
            json: tags
    }

    "/api/tags/:id[%d]": respond_to {
        GET: =>
            tag = Tags\find @params.id
            json: tag
        DELETE: =>
            tag = Tags\find @params.id
            tag\delete!
            json: tag
    }

    "/api/posts": respond_to {
        GET: =>
            posts = Posts\select!
            json: posts
    }

    "/api/posts/:id[%d]": respond_to {
        GET: =>
            post = Posts\find @params.id
            json: post
        DELETE: =>
            post = Posts\find @params.id
            post\delete!
            json: post
    }

    "/console": console.make!