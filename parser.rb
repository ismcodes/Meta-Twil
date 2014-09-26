require 'nokogiri'
require 'open-uri'
require 'net/https'
site = Nokogiri::HTML(open("https://www.twilio.com/docs/quickstart/python/sms/hello-monkey",:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
puts site.css('pre')[0].to_s.gsub!(/(?<=<)(.*)(?=>)/,'').gsub!(/<>/,'')