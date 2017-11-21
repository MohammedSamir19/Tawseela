class Trip < ApplicationRecord
  belongs_to :startpoint, class_name: 'Location'
  belongs_to :endpoint, class_name: 'Location'
  has_many :locations
  validates :status, inclusion: { in: %w(ongoing ended planning)}
end
