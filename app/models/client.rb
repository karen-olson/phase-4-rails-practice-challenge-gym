class Client < ApplicationRecord
    has_many :memberships, dependent: :destroy
    has_many :gyms, through: :memberships 

    validates :name, presence: true

    def total_charges
        charges = self.memberships.map{|membership| membership.charge}
        charges.reduce(:+)
    end
end
