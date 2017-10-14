lapis = require "lapis"
console = require "lapis.console"
import respond_to from require "lapis.application"
import Model from require "lapis.db.model"
import split from require "moonscript.util"
class Users extends Model

class Posts extends Model

class Tags extends Model

class extends lapis.Application
    handle_error: (err, trace) =>
        trace = trace\gsub "\t", ""
        status: 500, json: {
                error: err
                trace: split trace, "\n"
        }

    default_route: =>
        status: 404, json: "Nothing over here"

    "/": =>
        "Hello from Lapis #{require "lapis.version"}!"


    "/api/users":    respond_to {
        GET: =>
            users = Users\select!
            json: users

        POST: =>
            user = Users\create {
                name: @params.name
                email: @params.email
            }
            json: user
    }

    "/api/users/:id": respond_to {
        GET: =>
            user = Users\find @params.id
            json: user
        DELETE: =>
            user = Users\find @params.id
            user\delete!
            json: user
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

    "/api/tags/:id": respond_to {
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

    "/api/posts/:id": respond_to {
        GET: =>
            post = Posts\find @params.id
            json: post
        DELETE: =>
            post = Posts\find @params.id
            post\delete!
            json: post
    }

    "/console": respond_to {
        GET: =>
            console.make!
    }