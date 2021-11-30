class EventsLogger
  def initialize(logger)
    @logger = logger
  end

  def call(event)
    logger.info "#{event.event_type} published.  Data: #{event.data.inspect}"
  end

  private

  attr_reader :logger
end
