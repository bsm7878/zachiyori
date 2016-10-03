class Purchase < ActiveRecord::Base
    belongs_to :user
    belongs_to :mart
end
