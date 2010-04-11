class Todo < ActiveRecord::Base
  validates_presence_of :summary, :due
end
