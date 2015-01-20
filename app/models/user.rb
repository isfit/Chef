class User < ActiveRecord::Base
  self.primary_key = :id
  has_many :orders

  has_many :groups, :through => :positions
  has_and_belongs_to_many :positions
  has_one :access
  has_secure_password

  def regular_user?
    special_access_regular? || workshop_leader? || admin?
  end

  def workshop_leader?
    #Workshopleder eller sekreteriatet
    groups.include?(Group.find(130)) || groups.include?(Group.find(158)) || admin? || special_access_wok? #|| self == User.find(940)
  end

  def admin?
    # IT eller velferd
    groups.include?(Group.find(157)) || groups.include?(Group.find(127)) || special_access_admin?
  end

  def special_access_regular?
    #Access from mat-db
    if !self.access.nil?
      if self.access.access_level == 2
        return true
      end
    end
  end

  def special_access_wok?
    #WOK access from mat-db
    if !self.access.nil?
      if self.access.access_level == 1
        return true
      end
    end
  end

  def special_access_admin?
    #Admin access from mat-db
    if !self.access.nil?
      if self.access.access_level == 0
        return true
      end
    end
  end
end
