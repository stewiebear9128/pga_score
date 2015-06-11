class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :pools, :foreign_key => :owner_id, :primary_key => :id
        has_many :entries, :foreign_key => :pool_owner, :primary_key => :id


end
