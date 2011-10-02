require 'spec_helper'

describe "directory_users/index.html.erb" do
  before(:each) do
    assign(:directory_users, [
      stub_model(DirectoryUser,
        :username => "Username"
      ),
      stub_model(DirectoryUser,
        :username => "Username"
      )
    ])
  end

  it "renders a list of directory_users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Username".to_s, :count => 2
  end
end
