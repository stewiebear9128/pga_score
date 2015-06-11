class Entry < ActiveRecord::Base

  belongs_to :pool
  #belongs_to :tournament
  belongs_to :user, :foreign_key => :pool_owner, :primary_key => :id

  validate :golfers_must_be_unique

def golfers_must_be_unique
  if golfer_flex == golfer_a
    errors.add(:gofler_flex, " Flex selectin cannot be the same as Golfer A selection")
  elsif golfer_flex == golfer_b
    errors.add(:gofler_flex, " Flex selectin cannot be the same as Golfer B selection")
  elsif golfer_flex == golfer_c
    errors.add(:gofler_flex, " Flex selectin cannot be the same as Golfer C selection")
  elsif golfer_flex == golfer_d
    errors.add(:gofler_flex, " Flex selectin cannot be the same as Golfer D selection")
  end
end


end
