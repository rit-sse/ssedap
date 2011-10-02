require "spec_helper"

describe DirectoryUsersController do
  describe "routing" do

    it "routes to #index" do
      get("/directory_users").should route_to("directory_users#index")
    end

    it "routes to #new" do
      get("/directory_users/new").should route_to("directory_users#new")
    end

    it "routes to #show" do
      get("/directory_users/1").should route_to("directory_users#show", :id => "1")
    end

    it "routes to #edit" do
      get("/directory_users/1/edit").should route_to("directory_users#edit", :id => "1")
    end

    it "routes to #create" do
      post("/directory_users").should route_to("directory_users#create")
    end

    it "routes to #update" do
      put("/directory_users/1").should route_to("directory_users#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/directory_users/1").should route_to("directory_users#destroy", :id => "1")
    end

  end
end
