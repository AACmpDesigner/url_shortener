desc "This task is called by the Heroku scheduler add-on"
task :remove_origin_short_url_pair => :environment do
  UrlShort.remove_origin_short_url_pair
end