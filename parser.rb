require 'nokogiri'
require 'open-uri'
require 'net/https'
require 'sinatra'
require 'twilio-ruby'

post '/' do
	languages=["ruby","python", "java", "csharp", "php"]
	body=params[:Body]
	body=body.downcase if body

	twiml = Twilio::TwiML::Response.new do |r|

	unless languages.include?(body)
    		if body=="about"||body=="hi"||body=="what"
    			r.Message "MetaTwil made by Isaac Moldofsky. Text 'ruby' to see how to use Twilio!"
    		else
    		r.Message "Sorry, that language isn't in Twilio's docs. But these are: #{languages}"
  			end
	else
		r.Message get_twil(body)

	end
	end
	twiml.text
end
def get_twil(lang)
Nokogiri::HTML(open("https://www.twilio.com/docs/quickstart/#{lang}/sms/hello-monkey",:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE)).css('pre')[0].to_s.gsub!(/(?<=<)(.*)(?=>)/,'').gsub!(/<>/,'')
end