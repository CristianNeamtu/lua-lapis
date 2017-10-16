lapis = require "lapis"
import Model from require "lapis.db.model"
class Users extends Model
class Posts extends Model
    @timestamp: true
class Tags extends Model

users = Users\select!
print(json:users)