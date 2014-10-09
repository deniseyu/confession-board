require 'spec_helper'
require 'launchy'

feature "admin can" do 

	def app
    ConfessionBoard
  end

  scenario "test without authenication" do
  	visit '/supersecretadmin'
  	expect(page.status_code).to eq 401
  end

  scenario "test with login credientials" do
  	page.driver.browser.basic_authorize('admin', $SUPER_SECRET_PASSWORD)
  	visit '/supersecretadmin'
  	expect(page.status_code).to eq 200
  end

	before (:each) {
		Confession.create(:content => "Hadi is a naughty boy")
		Confession.create(:content => "Sean stole Hadi's umbrella")
		Confession.create(:content => "Yvette and Denise are *awesome*")
	}

	scenario "see a list of confessions with IDs" do
		page.driver.browser.basic_authorize('admin', $SUPER_SECRET_PASSWORD)
		visit '/supersecretadmin'
		expect(page).to have_content("Hadi is a naughty boy")
		expect(page).to have_content("Sean stole Hadi's umbrella")
		expect(page).to have_content("Yvette and Denise are *awesome*")
	end

	scenario "delete an objectionable confession" do 
		page.driver.browser.basic_authorize('admin', $SUPER_SECRET_PASSWORD)
		visit '/supersecretadmin'
		expect(page).to have_content("Hadi is a naughty boy")
		fill_in 'delete_id', :with => '10'
		click_button 'Delete!'
		expect(page).not_to have_content("Hadi is a naughty boy")
	end
	
end


