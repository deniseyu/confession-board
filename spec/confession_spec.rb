require 'spec_helper'
require 'confession'

describe Confession do 

	let(:confession) { Confession.new }

  it "should be able to get upvoted" do 
    expect(confession.votes).to eq 0
    confession.upvote
    expect(confession.votes).to eq 1
  end
	
end

