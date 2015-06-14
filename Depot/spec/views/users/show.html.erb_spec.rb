require 'rails_helper'

RSpec.describe "users/show", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :name => "Name",
      :hashed_password => "Hashed Password",
      :salt => "Salt"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Hashed Password/)
    expect(rendered).to match(/Salt/)
  end
end
