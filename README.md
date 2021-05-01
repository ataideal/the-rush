# the-rush

## Setup

- Install docker and docker-compose
- Clone this repository
- Run `docker-compose up`
- Open on your browser [http://locahost:8080](http://locahost:8080)

## Tests

- After finished setup open a new terminal
- Run `docker exec -it the_rush_backend bash`
- Inside container run `MIX_ENV=test mix coveralls.html`
- Open `cover/excoveralls.html` on you browser
