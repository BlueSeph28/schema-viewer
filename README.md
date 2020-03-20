# Schema viewer

a viewer for databases.
This project uses schemaspy and nginx

Originally is adapted only for postgresql 11 to get instantly all the data of a database.

## Environment

- db_name: name of database to connect (Required)
- db_user: username to access to the db (Required)
- db_password: password to access to the db (Required)
- db_host: Host to connect (Required)
- db_port: Port where is hosted (Required)

## Want to use this container with other database?

Make an Issue or pull request is issue to adapt this project with all databases compatible with schemaspy.

This project have some drivers to setup some databases.

[SchemaSpy Docs](https://schemaspy.readthedocs.io/en/stable/configuration.html#selection)