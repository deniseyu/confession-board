require "spec_helper"

feature "On the homepage" do 

	scenario "user can submit confession" do 
		visit '/'
    expect(Confession.count).to eq 0
    add_confession("Hadi is a naughty boy")
    expect(Confession.count).to eq 1
  end

 #  scenario "user should see submitted confessions" do 


	# 	expect(page).to have_content("Hadi is a naughty boy")
	# end
	
end

def add_confession(content)
    fill_in 'content', :with => content
    click_button 'Confess!'
end