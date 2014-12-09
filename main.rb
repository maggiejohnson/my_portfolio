require "sinatra"
require "sinatra/reloader" if development?

get '/' do
    @title = "Maggie Johnson's Portfolio"
    @description = "This site showcases all of the awesome things that Maggie Johnson has done."
    @layout = "active"
    erb :home
end

get '/about' do
    @title = "About Me"
    @description = "This page provides a short bio for Maggie Johnson."
    @about = "active"
    erb :about
end

get '/works' do
    @title = "My Clips"
    @description = "This page provides links to Maggie Johnson's published clips."
    @works = "active"
    erb :works
end

get '/tweets' do
    require 'twitter'
    client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "AZvBJSCRcuwvo8wdX4bYRqLjW"
        config.consumer_secret     = "qLGPwHZVR2iU4a4gxJ56yQqQkg19kwVmYSqhZeM40R5rOyBELH"
        config.access_token        = "347006995-xnBO5LLihK1VnkxLjMdxykSuCaDpNOQaUTRP1H3n"
        config.access_token_secret = "xIhyFVEZXqQqxEkOZSiWvY9undTULRLeNQRA0Z9e5q8wt"
    end
    
        @search_results = client.search("allmanbrothersband", result_type: "mixed").take(30).collect do |tweet|
      "#{tweet.user.screen_name}: #{tweet.text}"
            tweet
        end
    
    @title = "Tweets"
    @description = "This page contains my tweets that have the hashtag #allmanbrothersband."
    @tweets = "active"
    erb :tweets
 end


get '/insta' do
    require 'instagram'
    @title = "My Instagram"
    @description = "My Instagram photos"
    @insta = "active"


    Instagram.configure do |config|
      config.client_id = "d832519fa80f4d13ad2e73ccd3a6fbd8"
      config.client_secret = "1bf09a1c6bbd4b4985b3b59f516aa7e1"
    end


    client = Instagram.client(:access_token => session[:access_token])
    @photos = Array.new
    for photo in client.user_recent_media(26873334)
        @photos.push photo
    end
    erb :insta

end



