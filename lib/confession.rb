require 'dm-timestamps'

class Confession

	include DataMapper::Resource

	property :id, 			Serial
	property :content,	String, :length => 140
  property :created_at, DateTime
  property :votes,    Integer, :default => 0

  def upvote
    self.votes += 1
    self.save
  end

  def downvote
    self.votes -= 1
    self.save
  end

end
