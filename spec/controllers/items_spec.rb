require "rails_helper"

RSpec.describe BlogController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads top 10 news into @items" do
      post1 = Item.create!(heading: "Test heading 1", body: "test body 1")
      post2 = Item.create!(heading: "Test heading 2", body: "test body 2")
      get :index
      expect(assigns(:items)).to match_array([post1, post2])
    end
  end
end