class Dream < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { maximum: 8000 }
  	validates :user_id, presence: true
end
