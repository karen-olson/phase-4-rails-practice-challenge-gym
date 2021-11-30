class Membership < ApplicationRecord
    belongs_to :client 
    belongs_to :gym 

    validates :client, uniqueness: {scope: :gym, message: "can only have one membership to this gym"} 
end
