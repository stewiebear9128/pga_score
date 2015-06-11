class Golfer < ActiveRecord::Base

  has_many :registrations , :class_name => "Registration", :foreign_key => "golfer_id"
  #has_many :golfer_results
  #has_many :tournaments, :through => :golfer_results
  has_many :tournaments, :through => :registrations
  has_many :golfer_results, :through => :registrations

   validates :key, uniqueness: true
end
