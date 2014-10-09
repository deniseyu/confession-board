require 'spec_helper'

feature "admin can" do 

	before (:each) {
		Confession.create(:content => "Hadi is a naughty boy")
		Confession.create(:content => "Sean stole Hadi's umbrella")
		Confession.create(:content => "Yvette and Denise are *awesome*")
	}

	scenario "see a list of confessions with IDs" do
		visit '/supersecretadmin'
		expect(page).to have_content("1. Hadi is a naughty boy")
		expect(page).to have_content("2. Sean stole Hadi's umbrella")
		expect(page).to have_content("3. Yvette and Denise are *awesome*")
	end

	
end