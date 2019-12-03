# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'mtg_sdk'

#relevant info: name code release_date

set_limit = 25 #heroku wont let us have more than 10'000 cards in DB so we wont be using all of the data (for now, set this to 9999999 in future)
set_count = 0
sets = MTG::Set.all 
sets.each do |set|
    if set_count > set_limit 
        break
    end
    if (set.online_only != true) #we only care about physical cards
        sent_count = set_count +=1
        card_set = CardSet.find_by(name: set.name)
        if (card_set == nil) #duplicate protection
            CardSet.create(name: set.name, code: set.code, release_date: set.release_date)
        end
    end
end
puts "finished collecting sets"

puts "note we are using a subset of all sets because full data didn't fit on free heroku plan"
puts "this part takes like 2 hours if using the full data (we are only using 26/~440 sets for beta"

set_count = 0
sets.each do |set|
    if set_count > set_limit 
        break
    end
    if (set.online_only != true)  #we only care about physical cards
        sent_count = set_count +=1
        puts set.name
        cards = MTG::Card.where(set: set.code).all
        if cards != nil #shouldnt ever happen but just in case
            cards.each do |card| 
                if card != nil #thought the card_set bug was here but it wasn't
                    #puts card.name
                    if (card.image_url != nil) #prevents certain cards that the API has that are incorrect 
                        card_set = CardSet.find_by(code: card.set)
                        if (card_set != nil) #also shouldn't happen but also just in case
                            if(card_set.card.find_by(name: card.name) == nil) #duplicate protection
                                if card.name != nil and card.set_name != nil 
                                    card_set.card.create(name: card.name, set: card.set_name, image_url: card.image_url)
                                    Card.create(name: card.name, set: card.set_name, image_url: card.image_url)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

