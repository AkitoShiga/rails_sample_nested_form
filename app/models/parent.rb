class Parent < ApplicationRecord
  has_many :children, dependent: :destroy, autosave: true
  CHILDREN_MAX_SIZE = 5
end
