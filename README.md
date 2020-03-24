# README

This project consists of an API route available at `/tickets` that accepts a JSON payload that looks like:

```json
{
  "user_id" : 1234,
  "title" : "My title",
  "tags" : ["tag1", "tag2"]
}
```

### Validations &amp; notes
* `user_id` and `title` must be present.
* `tags` can be empty, but must also be fewer than 5. All tags are lowercased before being saved to the database.
* A running count for each tag is stored.
* If an invalid request is sent, the endpoint responds with an HTTP 422 and a JSON payload explaining the validation errors.
* Upon submission of a valid request, a JSON payload of the following format is sent to the configured webhook url:

```json
{ "max_tag": "name of most frequently occurring tag" }
```

### Ruby version

This has been tested against Ruby v2.6.3 and Rails v6.0.2.2.

### Configuration

The only required configuration is to set the `WEBHOOK_URL` environment variable. You can set this by copying `.env.example` to `.env` and supplying the appropriate url. The `dotenv-rails` gem will load this into the environment at runtime.


### Database creation

Execute `bundle exec rake db:migrate` to create the database and all application tables.

### Testing

Execute `bundle exec rake spec` to run the test suite.

### Running the application

Execute `bundle exec rails s` to serve this application at port 3000. POST JSON payloads to "http://localhost:3000/tickets" following the format described above.
