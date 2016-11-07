module SendGrid
  class MailInterceptor
    def self.delivering_email(mail)
      sendgrid_header = mail.instance_variable_get(:@sendgrid_header)

      if override_recipient = SendGrid.config.override_recipient
        sendgrid_header.add_recipients(override_recipient)
        mail.header['to'] = override_recipient
        mail.header['cc'] = nil
        mail.header['bcc'] = nil
      else
        sendgrid_header.add_recipients(mail.to)
        sendgrid_header.add_recipients(mail.cc)
        sendgrid_header.add_recipients(mail.bcc)
      end

      mail.header['X-SMTPAPI'] = sendgrid_header.to_json if sendgrid_header.data.present?
    end
  end
end
