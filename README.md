# Rails Event Store Test

This sample app showcases the `rails_event_store` gem to do event-based
development in Ruby on Rails.

### Produce Events

Based on [the documentation](https://railseventstore.org/docs/v2/publish/).

```ruby
stream_name = 'book-reviews.users'
event = UserAddedEvent.new(data: {
  id: SecureRandom.uuid,
  name: 'Administrator',
  email: 'admin@bookreviews.com',
  password: 'abcd1234',
  roles: %w(ROLE_ADMIN ROLE_USER),
})
Rails.configuration.event_store.publish(event, stream_name: stream_name)
```

You can persist events with `#publish`, which notifies listening handlers.  The
`stream_name` parameter is optional.

You can persist them with `#append`, which does not notify the handlers.  Again,
the `stream_name` parameter is optional.

You can add an event to a stream automatically within the call to either
`#publish` or `#append`.  You can also use `#link` to add events to streams
independently.  [The documentation](https://railseventstore.org/docs/v2/link/)
has an example where they use a handler to automatically link events to
additional streams when these events are published.

### Listen To Events

Handlers are called when events are published, based on which event types they
listen for.  The streams to which the events participate has nothing to do with
how the events are handled.

In this app, we register handlers in an initializer.

For example, `NewUserNotifier` only listens to `UserAddedEvent`.

```ruby
event_store.subscribe(NewUserNotifier.new(Rails.logger), to: [UserAddedEvent])
```

In contrast, `EventLogger` listens to all events.

```ruby
event_store.subscribe_to_all_events(EventsLogger.new(Rails.logger))
```

### See All Events

```ruby
client = RailsEventStore::Client.new
client.read.count
client.read.each { |ev| puts ev.event_type }
client.read.each { |ev| puts ev.data[:email] }
```

Refer to [the documentation](https://railseventstore.org/docs/v2/read/) for
more.

### See Events On A Stream

```ruby
stream_name = 'book-reviews.users'
client = RailsEventStore::Client.new
client.read.stream(stream_name).count
client.read.stream(stream_name).each { |ev| puts ev.event_type }
client.read.stream(stream_name).each { |ev| puts ev.data[:email] }
```

Refer to [the documentation](https://railseventstore.org/docs/v2/read/) for
more.

### See Events In the Browser

Use the Rails Event Store Viewer at: http://localhost:3000/res
