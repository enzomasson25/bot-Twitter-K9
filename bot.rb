require 'twitter'

puts "-------DEMARRAGE DU BOT WOUF-------"

client = Twitter::REST::Client.new do |config|
	config.consumer_key = "JgcW9EPLNvwsPvJHcmQG3rMHW"
	config.consumer_secret = "zoyV2zpMaa4m4HoVGZFlJTSPpoMMlZaUM5PzaaoBVhP2DUGYSL"
	config.access_token = "1249453468441407488-5rCDT1YqBofBctAuiSkluL7EUn4LM5"
	config.access_token_secret = "Y6pHXBxFGkCKYpViejLIhnysIxDVLFIAYDCwvyTkIgprh"
end

puts "Connexion au compte réussi :)"
tab_tweet = []
def tweet_wouf(client,tab_tweet)
	client.search('wouf').take(1).each do |tweet|
		if ((!tweet.text.include? "RT") && (!tweet.user.screen_name.include? "wouf") && (tweet.lang == 'fr') && (!tab_tweet.include?(tweet.id)))
			client.update('@'+tweet.user.screen_name+' wouf', in_reply_to_status_id: tweet.id)
			tab_tweet << tweet.id
			puts "Tweeted at "+ Time.now.to_s
			break
		end
	end
end

def respond_with_media(client,tab_tweet)
	client.search('@WoufBot').take(1).each do |tweet|
		if ((!tweet.text.include? "RT") && (!tab_tweet.include?(tweet.id)))
			media = "C:\\Users\\33762\\Desktop\\code\\ruby\\botTwitter\\img\\"
			media = media + rand(47).to_s + ".png"
			client.update_with_media('@'+tweet.user.screen_name+' Wouf', media, in_reply_to_status_id: tweet.id)
			tab_tweet << tweet.id
			puts "Tweeted with media at "+ Time.now.to_s
			break
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

every_so_many_seconds(15) do
   tweet_wouf(client,tab_tweet)
   respond_with_media(client,tab_tweet)
end

puts 'Err !'