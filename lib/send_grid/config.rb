class SendGrid::Config
  attr_accessor :dummy_recipient, :override_recipient

  def initialize
    @dummy_recipient = "dummy@email.com"
    @override_recipient = nil
  end
end
