require 'dm-timestamps'

class Confession

	include DataMapper::Resource

	property :id, 			Serial
	property :content,	String, :length => 140
  property :created_at, DateTime

  # def timestamp
  #   Time.now.strftime("Posted at %H:%M, %e %b %y")
  # end

end
