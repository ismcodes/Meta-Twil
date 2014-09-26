require 'nokogiri'
require 'open-uri'
require 'net/https'
require 'sinatra'
require 'twilio-ruby'

get '/sms-quickstart' do
	languages=["ruby","python", "java"]
	body=params[:Body]||"lang"
	body=body.downcase if body

	twiml = Twilio::TwiML::Response.new do |r|
	unless languages.include?(body)
    		r.Message "Sorry, that language isn't in Twilio's docs. But these are: #{languages}"
  		
	else
		r.Message get_twil(body)

	end
	end
	twiml.text
end
def get_twil(lang)
Nokogiri::HTML(open("https://www.twilio.com/docs/quickstart/#{lang}/sms/hello-monkey",:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE)).css('pre')[0].to_s.gsub!(/(?<=<)(.*)(?=>)/,'').gsub!(/<>/,'')
end