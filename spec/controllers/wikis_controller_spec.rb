require 'rails_helper'

RSpec.describe WikisController, type: :controller do

  before (:each) do
    @user = User.create!({
      :email => 'user@test.com',
      :password => 'please',
      :role => 'standard'
      })
    sign_in @user

    @wiki = Wiki.create!({
      :title => 'Test wiki',
      :body => 'Test body',
      :private => false,
      :user => @user
      })
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, :params => {id: @wiki.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, :params => {id: @wiki.id}
      expect(response).to have_http_status(:success)
    end
  end

end
