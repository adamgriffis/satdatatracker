# README

# Notes 

- Can just access the running environment in Heroku: https://gentle-sierra-99423.herokuapp.com/. I'm on a free dyno so it may take a bit to start up the first time but it should be performant after that.
- I've included a postman collection in the root directory to assist there.
- I used rails becuase I was in a bit of a time crunch this weekend, similarly I used Grape for the API for the same reason. I did try to push myself on the tests a little, this is my first time testing w/o Rspec (Although the tests are pretty simiple so not a huge swing there.)

# How to Setup Local Environment

- I've set this up in Heroku so you don't have to if you don't want to. Probably easiet to follow the guide here for setting up rails: https://gorails.com/setup/osx/11.0-big-sur. You'll need to install rbenv, ruby, rails, postgres

- Once all that is done, you'd need to create the DB:

```rails db:create```

- To run tests
``` rails test ```

- To start up the server (and sidekiq -- background jobs processing. I used sidekiq because I originally had the idea to run it using a scheduled task, but turns out the major scheduled background jobs tools don't support sub-minute recurring jobs.)

```rails s```

```bundle exec sidekiq -c 2```

- You'll need to let it warm up first as it populates data for a few minutes
