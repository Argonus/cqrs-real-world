module UserAggregateRoot
  def load(stream_name, event_store: default_event_store)
    @version = -1
    event_store.read.stream(stream_name).forward.each do |event|
      apply(event)
      @version += 1
    end

    @stream_name = stream_name
    @unpublished_events = []
  end

  def apply(event)
    send("apply_#{event.class.to_s.demodulize.underscore}", event)

    unpublished_events.push(event)
  end

  def store(event_store: default_event_store)
    unpublished_events.each do |event|
      event_store.publish(
        event,
        stream_name: @stream_name,
        expected_version: version
      )

      @version += 1
    end

    @unpublished_events = []
  end

  def unpublished_events
    @unpublished_events ||= []
  end

  private

  def version
    @version ||= -1
  end

  def default_event_store
    @default_event_store ||= Rails.configuration.event_store
  end
end