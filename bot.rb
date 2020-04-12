require 'twitter'

client = Twitter::REST::Client.new do |config|
	config.consumer_key = "JgcW9EPLNvwsPvJHcmQG3rMHW"
	config.consumer_secret = "zoyV2zpMaa4m4HoVGZFlJTSPpoMMlZaUM5PzaaoBVhP2DUGYSL"
	config.access_token = "1249453468441407488-5rCDT1YqBofBctAuiSkluL7EUn4LM5"
	config.access_token_secret = "Y6pHXBxFGkCKYpViejLIhnysIxDVLFIAYDCwvyTkIgprh"
end

def tweet_wouf(client)
	client.search('chien').take(10).each do |tweet|
		if ((!tweet.text.include? "RT") && (!tweet.user.screen_name.include? "chien") && (tweet.lang == 'fr'))
			client.update('@'+tweet.user.screen_name+' wouf', in_reply_to_status_id: tweet.id)
		end
	end
end

def every_so_many_seconds(seconds)
  last_tick = Time.now
  loop do
    sleep 0.1
    if Time.now - last_tick >= seconds
      last_tick += seconds
      yield
    end
  end
end

every_so_many_seconds(30) do
  tweet_wouf(client)
  puts Time.now
end

puts 'Err !'