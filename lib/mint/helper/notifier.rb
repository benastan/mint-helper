require 'mail'
require 'erb'
require 'premailer'

module Mint
  module Helper
    class Notifier
      def initialize(template = nil)
        @template = template || 'notification'
      end

      def send
        html = render_html

        mail = Mail.new do
          to Mint::Email
          from 'no-reply@example.com'
          subject 'It\'s %s - Time for your hourly financial checkup' % Time.new.strftime('%D %T')

          text_part do
            body 'This is plain text'
          end

          html_part do
            content_type 'text/html; charset=UTF-8'
            body Premailer.new(html, with_html_string: true).to_inline_css
          end

          delivery_method :smtp, { 
            address: ENV['SMTP_HOST'],
            port: ENV['SMTP_PORT'],
            user_name: ENV['SMTP_USER'],
            password: ENV['SMTP_PASSWORD'],
            authentication: :plain,
            enable_starttls_auto: true
          }
        end

        mail.deliver!
      end

      def write(target)
        file = File.new(target, 'wb+')
        file.write(render_html)
        file.close
      end

      def render_html
        ERB.new(template_data).result(binding)
      end

      def template_data
        Pathname('./templates/%s.erb' % @template).read
      end
    end
  end
end
  