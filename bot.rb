# De følgende kommandoer fungerere indtil videre:
# !lodtrækning [antal] - vælger tilfældigt det antal personer som der er defineret ud fra gruppen.
# !coinflip - plat eller krone
# !github - linker til projektets Github
# !trello - linker til projektets Trello
# !drive - linker til projekt mappen på Google Drive
# !skema [valgfag] - linker til det skema som er relevant for det givne valgfag
# !testserver - linker til test serveren

# Todoliste:
# Mulighed for at tilføje nye kommandoer direkte fra Discord.
# Timer funktion?
# !updatetestserver funktion

require 'discordrb'
require 'dotenv/load'


bot = Discordrb::Commands::CommandBot.new token: ENV['TOKEN'], prefix: '!'

# Plat eller krone
bot.command :coinflip do
  num = rand(2).floor
  if num.zero?
    'Plat'
  else
    'Krone'
  end
end

# Lodtraekning af personer ud fra antallet der er behov for.
bot.command(:lodtrækning, min_args: 0, max_args: 2, usage: 'lodtrækning [antal] [person2]') do |_event, antal, _person2|
  navne = %w[Mads Niklas Sebastian Abdul Khalid]
  if antal
    case antal.to_s.downcase
    when 'ui'
      personer_ui = %w[Mads Abdul]
      return personer_ui[rand(2).floor].to_s
    when 'content'
      personer_content = %w[Niklas Sebastian Khalid]
      return personer_content[rand(3).floor].to_s
    when '1'
      return (navne[rand(5).floor]).to_s
    when '2'
      pers1 = (navne[rand(5).floor]).to_s
      pers2 = (navne[rand(5).floor]).to_s
      if pers1 == pers2
        loop do
          pers1 = (navne[rand(5).floor]).to_s
          pers2 = (navne[rand(5).floor]).to_s
          break if pers1 != pers2
        end
      end
      return "#{pers1} og #{pers2}"
    when '3'
      pers1 = (navne[rand(5).floor]).to_s
      pers2 = (navne[rand(5).floor]).to_s
      pers3 = (navne[rand(5).floor]).to_s
      if pers1 == pers2 || pers1 == pers3 || pers2 == pers3
        loop do
          pers1 = (navne[rand(5).floor]).to_s
          pers2 = (navne[rand(5).floor]).to_s
          pers3 = (navne[rand(5).floor]).to_s
          break if pers1 != pers2 && pers1 != pers3 && pers2 != pers3
        end
      end
      return "#{pers1}, #{pers2} og #{pers3}"
    when '4'
      pers1 = (navne[rand(5).floor]).to_s
      pers2 = (navne[rand(5).floor]).to_s
      pers3 = (navne[rand(5).floor]).to_s
      pers4 = (navne[rand(5).floor]).to_s
      if pers1 == pers2 || pers1 == pers3 || pers1 == pers4 || pers2 == pers3 || pers2 == pers4 || pers3 == pers4
        loop do
          pers1 = (navne[rand(5).floor]).to_s
          pers2 = (navne[rand(5).floor]).to_s
          pers3 = (navne[rand(5).floor]).to_s
          pers4 = (navne[rand(5).floor]).to_s
          if pers1 != pers2 && pers1 != pers3 && pers1 != pers4 && pers2 != pers3 && pers2 != pers4 && pers3 != pers4
            break
          end
        end
      end
      return "#{pers1}, #{pers2}, #{pers3} og #{pers4}"
    end
  else
    return (navne[rand(5).floor]).to_s
  end
end

bot.command :updatetestserver do 
system("cd && cd projekt7/src && git pull")
return "Test serveren er blevet opdatet"

end
# Github
bot.command :github do
  'https://github.com/Hougesen/projekt7'
end

bot.command :testserver do
  'http://projekt7.mhouge.dk'
end

# Trello
bot.command :trello do
  'https://trello.com/'
end

# Drive
bot.command :drive do
  'https://docs.google.com/document/d/1Lb_ESHR7rBJh-NftrpvVPpXDCwiLKbaQb-8EaWRkYyw/edit?usp=sharing'
end

# Skema
bot.command(:skema, min_args: 1, usage: 'skema [valgfag]') do |_event, valgfag|
  if valgfag.downcase == 'ui'
    'https://cloud.timeedit.net/ucl/web/pub/ri1Y7XY6QXwZ64Qv43074255y4Y42ZY2Q7X5524Q769Y7.html'
  elsif valgfag.downcase == 'content'
    'https://cloud.timeedit.net/ucl/web/pub/ri1Y7XY5QXwZ74Qv42074725y4Y43ZY7Q2X5624Q569Y7.html'
  else
    'Fejl!'
  end
end

# Stop command
bot.command :stop do
  bot.stop
end

bot.run
