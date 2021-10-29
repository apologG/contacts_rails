class Contact < ApplicationRecord
  belongs_to :group

  paginates_per 5
end
