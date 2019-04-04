class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  enum cast: {
    billing: 0,
    shipping: 1
  } 
end
