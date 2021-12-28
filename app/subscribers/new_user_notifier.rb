class NewUserNotifier
  def initialize(logger)
    @logger = logger
  end

  def call(event)
    logger.info "New user #{event.data[:name]} <#{event.data[:email]}> was just added."
  end

  private

  attr_reader :logger
end
