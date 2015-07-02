class User < ActiveRecord::Base
  has_one :profile
  has_many :posts
  has_many :friends
end

class Profile < ActiveRecord::Base
  belongs_to :user

end

class Post < ActiveRecord::Base
  belongs_to :user
end

class Friend < ActiveRecord::Base

end