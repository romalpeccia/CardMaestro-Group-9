# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'mtg_sdk'

#relevant info: name code release_date

'''
sets = MTG::Set.all
sets.each do |set|
    if (set.online_only != true)
        CardSet.create(name: set.name, code: set.code, release_date: set.release_date)

    end
end
'''


#cards = MTG::Card.where(page: 5).where(pageSize: 10).all
cards = MTG::Card.all
cards.each do |card|
    if card
        if (card.image_url)
            card_set = CardSet.find_by(code: card.set)
            card_set.card.create(name: card.name, set: card.set, image_url: card.image_url)
            Card.create(name: card.name, set: card.set, image_url: card.image_url)
        end
    end
    '''
    puts card.name
    puts card.set
    puts card.image_url
    '''
end
