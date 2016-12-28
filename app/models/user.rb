class User < ApplicationRecord
    validates :name, length: {minimum: 4, maximum: 32}, uniqueness: true
    validates :tag, length: {minimum: 4, maximum: 8}
end
