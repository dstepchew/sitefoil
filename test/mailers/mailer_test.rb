require 'test_helper'

class MailerTest < ActionMailer::TestCase
  test "email_action" do
    mail = Mailer.email_action
    assert_equal "Email action", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
