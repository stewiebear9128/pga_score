class Tournament < ActiveRecord::Base

  has_many :registrations , :class_name => "Registration", :foreign_key => "tournament_id"
  has_many :pools
  has_many :entries , :class_name => "Pool", :foreign_key => "tournament_id"
  has_many :payoffs
  has_many :golfers, :through => :registrations
  has_many :golfer_results, :through => :registrations

  validates :key, uniqueness: true
end
