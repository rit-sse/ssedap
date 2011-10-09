class DirectoryUser
  include Mongoid::Document

  field :username, type: String

  validates_presence_of :username

  belongs_to :role
end

