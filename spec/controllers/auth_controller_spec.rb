require 'spec_helper'

describe AuthController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'authorize'" do
    it "returns http success" do
      get 'authorize'
      response.should be_success
    end
  end

  describe "GET 'logout'" do
    it "returns http success" do
      get 'logout'
      response.should be_success
    end
  end

end
