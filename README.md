# README

Location is constant to lessen the amount of requests using test account

Location ID (key): 287676 which is equivalent for Cheboksary city

There's no city filtering in API though it's not a problem to add it in the future if needed.

Due to limitations of the API usage it worth setting up the scheduled data fetching based on requests quota. 

Though it was described to define AIP urls like /weather/current, I decided to use also versioning namespace and api prefix for further convenience.

Environment variable ACCU_WEATHER_API_KEY should be set to make AccuWeather API requests possible

Tolerance for finding current weather is set to 1 hour from now to the past. Tolerance for finding the temperature by timestamp is set to 1 hour to both directions from the given timestamp

For testing purposes caching is configured in memory. Otherwise it could be appropriate to use Redis.

To enable caching in development environment run:

```bash
bundle exec rails dev:cache
```

I didn't use city in the cache or filters because it is constant and used in fetching data from AccuWeather only. In real system these filters and cache markers should be used.