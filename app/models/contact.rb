class Contact < ApplicationRecord
  belongs_to :group

  paginates_per 5

  validates :name, :email, :group_id, presence: true
  validates :name, length: {minimum:3}

  has_attached_file :avatar, styles: { medium: "150x150>", thumb: "100x100>" }, default_url: "/images/:style/default.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

end
