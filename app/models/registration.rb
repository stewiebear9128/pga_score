class Registration < ActiveRecord::Base

  belongs_to :tournament , :class_name => "Tournament", :foreign_key => "tournament_id"
  belongs_to :golfer , :class_name => "Golfer", :foreign_key => "golfer_id"
  has_many :golfer_results, :class_name => "Golfer_Result"

   validates_uniqueness_of :tournament_id, :scope => :golfer_id
end
