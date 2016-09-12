class User < ActiveRecord::Base

  after_create :create_player

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
         user.image = auth['info']['image'] || ""
      end
    end
  end

  def create_player
    @player = Player.create(name: self.name, user: self)
  end

end
