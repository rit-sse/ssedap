require 'spec_helper'

describe "directory_users/edit.html.erb" do
  before(:each) do
    @directory_user = assign(:directory_user, stub_model(DirectoryUser,
      :username => "MyString"
    ))
  end

  it "renders the edit directory_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => directory_users_path(@directory_user), :method => "post" do
      assert_select "input#directory_user_username", :name => "directory_user[username]"
    end
  end
end
