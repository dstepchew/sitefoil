class Mailer < ActionMailer::Base
  default from: "support@sitefoil.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.email_action.subject
  #
  def email_action opts={}
    @text = opts[:text]

    mail(to: opts[:to_email], subject: opts[:subject])
  end

end
