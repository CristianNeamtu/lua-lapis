import config from require "lapis.config"

dbConfig = require("en_vars")

config "development", ->
    num_workers 1
    port 8080
    measure_performance true
    logging: {
        queries: true
        requests: true
    }
    postgres ->
        host dbConfig.host
        user dbConfig.user
        password dbConfig.password
        database dbConfig.database

config "production", ->
    num_workers 2
    port 80
    postgres ->
        host dbConfig.host
        user dbConfig.user
        password dbConfig.password
        database dbConfig.database
