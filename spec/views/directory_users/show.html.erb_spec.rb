require 'spec_helper'

describe "directory_users/show.html.erb" do
  before(:each) do
    @directory_user = assign(:directory_user, stub_model(DirectoryUser,
      :username => "Username"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Username/)
  end
end
