class InvalidMessage < StandardError
  def initialize(msg='Invalid message.')
    super
  end
end
