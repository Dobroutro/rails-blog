require "rails_helper"

RSpec.describe Item, :type => :model do
  it "items by id" do
    post1 = Item.create!(heading: "Test heading 1", body: "test body 1")
    post2 = Item.create!(heading: "Test heading 2", body: "test body 2")
    post3 = Item.create!(heading: "Test heading 3", body: "test body 3")
    post4 = Item.create!(heading: "Test heading 4", body: "test body 4")
    post5 = Item.create!(heading: "Test heading 5", body: "test body 5")
    post6 = Item.create!(heading: "Test heading 6", body: "test body 6")
    post7 = Item.create!(heading: "Test heading 7", body: "test body 7")
    post8 = Item.create!(heading: "Test heading 8", body: "test body 8")
    post9 = Item.create!(heading: "Test heading 9", body: "test body 9")
    post10 = Item.create!(heading: "Test heading 10", body: "test body 10")

    expect(Item.order('id DESC').limit(10)).to eq([post10, post9, post8, post7, post6, post5, post4, post3, post2, post1])
  end
end