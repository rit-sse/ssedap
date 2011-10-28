class Role
  include Mongoid::Document
  field :name, :type => String
  validates_presence_of :name

  def directory_users
    DirectoryUser.where(role_id: self.id).to_a
  end

  def is_admin? ; name == "Admin" ; end
  def is_officer? ; name == "Officer" ; end
end

