class DirectoryUser
  include Mongoid::Document

  field :username, type: String

  validates_presence_of :username

  belongs_to :role

  def auth_attributes
    { role: role.name }
  end
end

