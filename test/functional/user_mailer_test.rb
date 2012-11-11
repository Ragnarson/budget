require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def test_invite_email
    user = users(:user3)
 
    # Send the email, then test that it got queued
    email = UserMailer.invite_email(user).deliver
    assert !ActionMailer::Base.deliveries.empty?
 
    # Test the body of the sent email contains what we expect it to
    assert_equal [user.email], email.to
    assert_equal "Welcome to Budget application", email.subject
    assert_match(/<h1>Welcome #{user.email}<\/h1>/, email.encoded)
  end
end
