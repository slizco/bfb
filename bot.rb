require 'slack-ruby-bot'

class BFB < SlackRubyBot::Bot
    match /(\s|^)(((L|l)iz)|(<@UBK54S109>))(\s|$|!|\?|\.)/ do |client, data, match|
      puts "matched liz (#{data}, responding)"
      client.say(channel: data.channel, text: "BEST FRIEND LIZ!")
      puts "responded in #{data.channel}"
    end
    match /(\s|^)(B|b)est(\s*)friend(\s|$|!|\?|\.)/ do |client, data, match|
      puts "matched best friend (#{data}, responding)"
      display_name = client.store.users[data.user]['profile']['display_name']
      client.say(channel: data.channel, text: "<@#{data.user}>, you're my best friend :heart:.")
      puts "responded in #{data.channel} to #{display_name}"
    end
end

puts "starting bot"
BFB.run
