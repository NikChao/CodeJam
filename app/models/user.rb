class User < ApplicationRecord
    validates :name, length: {maximum: 32}
    validates :tag, length: {maximum: 8}
end
