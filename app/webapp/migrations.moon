import create_table, types from require("lapis.db.schema")
{
    =>
        create_table "users", {
            {"id", types.serial}
            {"name", types.varchar}
            {"email", types.varchar}
            "PRIMARY KEY (id)"

        }
    =>
        create_table "posts" , {
           {"id", types.serial}
           {"user_id", types.foreign_key}
           {"title", types.varchar}
           {"description", types.text}
           {"created_at", types.time}
           {"updated_at", types.time}
           "PRIMARY KEY (id)"
        }

    =>
        create_table "tags" , {
            {"id", types.serial }
            {"name", types.varchar}
        }

    =>
        create_table "mappings" , {
            {"id", types.serial }
            {"post_id", types.foreign_key}
            {"tag_id", types.foreign_key}
        }
}
