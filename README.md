# To run for development
$ docker-compose up --build
$ docker-compose run web rake db:setup
$ docker-compose run --no-deps web rake assets:precompile

# To stop running
$ docker-compose down
