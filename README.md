# API DOC 

We are using [apidoc](http://apidocjs.com) to generate the documentation
for this application.

To generate the api documentation, please install `npm install apidoc
-g` and run `apidoc -i ./ -o apidoc/`. A newly generated folder `/apidoc`
would be generated to illustrate the api

open the api through `/apidoc/index.html` in your browser

cheers, and have a :coffee: for the read

# Docker

Use this command to run an sql query in you postgress sql
`docker-compose exec db psql -h localhost -U postgres -c "SQL QUERY"`

To add a role
`docker-compose exec db psql -h localhost -U postgres -c "CREATE USER user WITH PASSWORD 'password';"`

create db
`docker-compose exec app rails db:create`

Migrate
`docker-compose exec app rails db:migrate`
