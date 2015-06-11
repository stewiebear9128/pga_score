class Pool < ActiveRecord::Base

  has_many :entries
  belongs_to :user, :foreign_key => :owner_id, :primary_key => :id
  belongs_to :tournament

end
