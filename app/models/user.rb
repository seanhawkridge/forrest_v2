class User < ActiveRecord::Base

  after_create :create_player
  has_one :player, dependent: :destroy

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.first_name = auth['info']['first_name'] || ""
         user.last_name = auth['info']['last_name'] || ""
         user.email = auth['info']['email'] || ""
         user.image = auth['info']['image'] || ""
      end
    end
  end

  def create_player
    new_player_position = (Player.count + 1)
    @player = Player.create(first_name: self.first_name, last_name: self.last_name, user: self, position: new_player_position)
  end

end
