require "sinatra"
require "sinatra/reloader" if development?

get '/' do
    @title = "Maggie Johnson's Portfolio"
    @description = "This site showcases all of the awesome things that Maggie Johnson has done."
    @index = "active"
    erb :index
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
    
        @search_results = client.search("mags_johnson", result_type: "mixed").take(30).collect do |tweet|
      "#{tweet.user.screen_name}: #{tweet.text}"
            tweet
        end
    
    @title = "My ____ Tweets"
    @description = "This page contains my tweets that ____."
    @tweets = "active"
    erb :tweets
 end


#instagram
get '/news' do
    require 'google-search'
    query = "Mercer football"
    #@results = "test"
    @results = Array.new
    Google::Search::News.new do |search|
        search.query = query
        search.size = :large
    end.each { |item| @results.push item }
    
    @title = "News about ___"
    @description = "These are news stories about ___"
    @news = "active"
    erb :news
end



