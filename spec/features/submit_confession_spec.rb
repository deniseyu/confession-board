require "spec_helper"

feature "On the homepage" do 

  scenario "user can submit confession" do 
		visit '/'
    expect(Confession.count).to eq 0
    add_confession("Hadi is a naughty boy")
    expect(Confession.count).to eq 1
  end

  scenario "user should see submitted confessions" do 
    visit '/'
    add_confession("Hadi is a naughty boy")
		expect(page).to have_content("Hadi is a naughty boy")
	end

  scenario "user can upvote a submitted confession" do 
    visit '/'
    add_confession("Hadi is a naughty boy")
    expect(page).to have_content "0 point(s)"
    click_link('smiley_face')   
    expect(page).to have_content "1 point(s)"
  end

  scenario "user can downvote a submitted confession" do 
    visit '/'
    add_confession ("Hadi is a naughty boy")
    expect(page).to have_content "0 point(s)"
    click_link 'smiley_face'
    expect(page).to have_content "1 point(s)"
    click_link 'frowny_face'
    expect(page).to have_content "0 point(s)"
  end


  def add_confession(content)
      fill_in 'content', :with => content
      click_button 'Confess!'
  end

end

