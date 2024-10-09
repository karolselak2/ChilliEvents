# ChilliEvents

App needs Docker and Docker Compose to run. Basic commands:
 - setup before first start: `bin/setup`
 - databases creation: `sudo bin/run rails db:create && sudo bin/run rails db:create RAILS_ENV=test`
 - migration: `sudo bin/run rails db:migrate`
 - seed: `sudo bin/run rails db:seed`
 - starting the app on `localhost:3000`: `sudo docker compose up`
 - running tests: `sudo bin/run bundle exec rspec`
 - list endpoints: `sudo bin/run rails routes`

