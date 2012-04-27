class Role
  include Mongoid::Document

  METHOD_MISSING_REGEX = /^(visitor|admin|officer|committee_head|member)$/i

  field :name, :type => String
  validates_presence_of :name

  def directory_users
    DirectoryUser.where(role_id: self.id).to_a
  end

  def is_admin? ; name == "Admin" ; end
  def is_officer? ; name == "Officer" ; end

  def self.method_missing(method_sym, *args, &block)
    if method_sym.to_s =~ METHOD_MISSING_REGEX
      role_name = method_sym.to_s.split('_').map(&:capitalize).join ' '
      where(name: role_name).first
    else
      super
    end
  end

  def self.respond_to(method_sym, include_private = false)
    if method_sym.to_s =~ METHOD_MISSING_REGEX
      true
    else
      super
    end
  end
end

