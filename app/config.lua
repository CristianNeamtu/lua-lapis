local config = require("lapis.config")
config("development", {
    mysql = {
        host = "127.0.0.1",
        user = "lapis_webapp",
        password = "supertorent",
        database = "lapis_test_db"
    }
})