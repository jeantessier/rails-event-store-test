# Event Test

This sample app showcases the `rails_event_store` gem to do event-based
development in Ruby on Rails.

### Produce Events

Based on [the documentation](https://railseventstore.org/docs/v2/publish/).

```ruby
stream = 'book-reviews.users'
event = UserAddedEvent.new(data: {
  id: "1e3d71ad-3065-49aa-bf7f-80dae484dc8d",
  name: "Administrator",
  email: "admin@bookreviews.com",
  password: "abcd1234",
  roles: %w(ROLE_ADMIN ROLE_USER),
})
Rails.configuration.event_store.publish(event, stream_name: stream)
```

The `EventLogger` subscriber will echo the event to the logs.

### See All Events

```ruby
client = RailsEventStore::Client.new
client.read.count
client.read.each { |e| puts e.event_type }
client.read.each { |e| puts e.data[:email] }
```

Refer to [the documentation](https://railseventstore.org/docs/v2/read/) for
more.
