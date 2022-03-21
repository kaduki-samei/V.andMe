class MessageMailer < ApplicationMailer

  def send_mail(message)
    @message = message
    mail to:   ENV['TOMAIL'], subject: '【V&Meお問い合わせ】' + @message.title
  end

end
