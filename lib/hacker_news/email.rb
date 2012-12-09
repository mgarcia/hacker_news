require 'rubygems'
require 'net/smtp'


module HackerNews
  class  Email

    def initialize(options = {host:'localhost', port:25})
      @host = options[:host]
      @port = options[:port]
    end

    def send(options={})
      from    = options[:from]
      to      = options[:to]
      subject = options[:subject]
      msg     = options[:msg]

      # Build Message
      msg_body = "From: #{from}\nTo: #{to}\nSubject: #{subject}\n\n#{msg}"

      # Send message by email
      Net::SMTP.start(@host, @port) do |smtp|
          smtp.send_message msg_body, from, to
      end

    end
  end
end

