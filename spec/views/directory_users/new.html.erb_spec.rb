require 'spec_helper'

describe "directory_users/new.html.erb" do
  before(:each) do
    assign(:directory_user, stub_model(DirectoryUser,
      :username => "MyString"
    ).as_new_record)
  end

  it "renders new directory_user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => directory_users_path, :method => "post" do
      assert_select "input#directory_user_username", :name => "directory_user[username]"
    end
  end
end
