Listy2
================

Problems? Issues?
-----------

This is a personal project for my own use, but you're free to fork it and use it, and if you do something cool with it, send me a pull request--no promises, but maybe I'll merge it.

Getting Started
-------------

This application requires:

- Ruby 2.2.2
- Rails 4.2.1
- PostgreSql (though you can easily change this to your prefered DB in the gemfile / database.yml)
- a Mandrill account (with keys setup in .env)

```
cp .env.example .env # and edit to customize as necessary
cp config/database.yml.example config/database.yml # and edit to customize as necessary
rake db:reset # drops & recreates the db + schema and populates seed data
rake db:load:test_data # if you want some sample data to get started with
rspec && rubocop # these should run clean
foreman start # or just use rails s
```

Deploy
-------------

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

See [getting started with heroku and rails4](https://devcenter.heroku.com/articles/getting-started-with-rails4) for tips on getting started with Heroku.

See example.env in the project root for heroku environment variables that must be set in heroku. I recommend creating a production.env file (already .gitignore'd) and using it to set heroku variables using [heroku-config](https://github.com/ddollar/heroku-config).

Once you've deployed (and assuming you setup the heroku toolbelt), `heroku run db:migrate db:seed` to create the initial admin user based on your env variables.

Credits
--------------

This initial skeleton for this application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem
provided by the [RailsApps Project](http://railsapps.github.io/).

License
-------

MIT (see license.txt)
