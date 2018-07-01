# GEOCODE LOCATIONS

Sending a POST request to `api/location` with the following params `name`, `phone`, `address`, `postcode`, `city`, `country`, `latitude`, `longitude` creates a new location, which is geocoded through a sidekiq worker if no longitude and latitude are provided.

## HOW TO RUN

- Clone this project and cd into it
- `bundle install`

- You will need a google api geocoding key. Keep it in an ENV variable called `GOOGLE_GEOCODING_API`
- You will need redis, if you use Homebrew:  `brew install redis`
- Run redis: `redis-server`
- Run sidekiq: `sidekiq`
- Run rails: `rails s`

- Run tests: `rspec`

*Note*
Manually test worker by accessing the console `rails c`, and creating a new location: `Location.create(name:'Starbucks', address: 'Hauptbahnhof, Trankgasse 11', postcode: '50667', city: 'Cologne', country: 'DE')`

In the sidekiq output you should see something like this:
`2018-07-01T08:44:04.731Z 36134 TID-oxbs0usa2 LocationsGeocoderWorker JID-6d105906bde22d9467120a87 INFO: start
2018-07-01T08:44:04.885Z 36134 TID-oxbs0usa2 LocationsGeocoderWorker JID-6d105906bde22d9467120a87 INFO: done: 0.154 sec`

And no output generated if both latitude and longitude are provided.

## TO DO NEXT

- Improve tests, test worker geocoding with sidekiq
- Add validations to the model
- Improve geocoder (add more location parameters to the query to improve precision)
