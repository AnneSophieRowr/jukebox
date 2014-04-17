class User < ActiveRecord::Base
  devise :ldap_authenticatable, :rememberable, :trackable
  default_scope { order('last_name') }
  has_many :playlists
  has_many :songs

  before_save :get_ldap_infos

  def get_ldap_infos
    self.email = Devise::LDAP::Adapter.get_ldap_param(self.email, "userPrincipalName").first
    self.last_name = Devise::LDAP::Adapter.get_ldap_param(self.email, "sn").first
    self.first_name = Devise::LDAP::Adapter.get_ldap_param(self.email, "givenname").first
  end

end
