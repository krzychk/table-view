class Tag < ActiveRecord::Base
  belongs_to :post

  def to_s
    "#{name}:#{id}"
  end
end
