Rails.configuration.to_prepare do
  Rails.configuration.event_store = event_store = RailsEventStore::Client.new
  # add subscribers here
  event_store.subscribe_to_all_events(EventsLogger.new(Rails.logger))
end
