require 'action_mailer'
require 'letter_opener'

ActionMailer::Base.add_delivery_method :letter_opener, LetterOpener::DeliveryMethod, location: File.expand_path('../tmp/letter_opener', __FILE__)
ActionMailer::Base.delivery_method = :letter_opener

class LalaMailer < ActionMailer::Base
  def notify
    attachments['roo.png'] = File.read('./roo.png')

    mail(
      to: 'ruby@australia.com',
      from: 'friendlyantz@pm.me',
      subject: 'Hello, World!'

    ) do |format|
      format.text { 'This is my text message' }
      format.html { '<h1>this is my html message</h1>' }

    end
  end
end

LalaMailer.notify.deliver_now
