class Contact < ApplicationRecord
  belongs_to :group

  paginates_per 5

  validates :name, :email, :group_id, presence: true
  validates :name, length: { minimum: 3 }

  has_attached_file :avatar, styles: { medium: "150x150>", thumb: "100x100>" }, default_url: "/images/:style/default.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  scope :search, -> (term) {
    where('LOWER(name) LIKE :term or LOWER(company) LIKE :term or LOWER(email) LIKE :term', term: "%#{term.split(' ').map { |word| word.capitalize }.join(' ')}%") if term.present?
  }
  scope :by_group, -> (group_id) { where(group_id: group_id) if group_id.present? }

  # def self.search(term)
  #   if term && !term.empty?
  #     where('name LIKE?', "%#{term}%")
  #   else
  #     all
  #   end
  # end

  # def self.by_group(group_id)
  #   if group_id && !group_id.empty?
  #     where(group_id: group_id)
  #   else
  #     all
  #   end
  # end

end
