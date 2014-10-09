require 'spec_helper'
require 'launchy'

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

	scenario "delete an objectionable confession" do 
		visit '/supersecretadmin'
		fill_in 'delete_id', :with => '1'
		click_button 'Delete!'
		expect(page).not_to have_content("1. Hadi is a naughty boy")
	end

	
end