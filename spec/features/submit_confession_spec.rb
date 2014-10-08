require "spec_helper"

feature "On the homepage" do 

	scenario "user can submit confession" do 
		visit '/'
		fill_in 'confession', :with => "Hadi is a naughty boy"
		click_button 'Confess!'
		expect(page).to have_content("Hadi is a naughty boy")
	end
	
end