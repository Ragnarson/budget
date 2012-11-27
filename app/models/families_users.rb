class FamiliesUsers < ActiveRecord::Base
  attr_accessible :family_id, :user_id

  belongs_to :user
  belongs_to :family
end
