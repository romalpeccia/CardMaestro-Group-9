# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'mtg_sdk'

#relevant info: name code release_date

sets = MTG::Set.all
sets.each do |set|
    if (set.online_only != true)
        CardSet.create(name: set.name, code: set.code, release_date: set.release_date)
        '''
        puts set.name 
        puts set.code
        puts set.release_date
        '''
    end
end



#cards = MTG::Card.where(page: 5).where(pageSize: 10).all
cards = MTG::Card.all
cards.each do |card|
    Card.create(name: card.name, set: card.set, image_url: card.image_url)
    '''
    puts card.name
    puts card.set
    puts card.image_url
    '''
end
