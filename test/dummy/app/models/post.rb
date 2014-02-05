class Post < ActiveRecord::Base
  has_many :tags

  scope :sort_by_id, lambda {|direction| order(:id => direction)}
end
