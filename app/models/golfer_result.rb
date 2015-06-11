class GolferResult < ActiveRecord::Base

#belongs_to :tournament
#belongs_to :golfer
belongs_to :registration

validates_uniqueness_of :reg_id
end
