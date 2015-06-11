# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

#__________________________
csv_text = File.read(Rails.root.join('lib', 'seeds', 'payoff.csv'))
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
 t = Payoff.new
  t.place = row['Place']
  t.payout = row['Amount']
  t.tournament_id = row['tournament']

  t.save
 puts "#{t.place}, #{t.payout} saved"
end


