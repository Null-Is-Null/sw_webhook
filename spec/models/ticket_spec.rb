require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "is valid with a numeric user ID, title, and no tags" do
    expect(Ticket.new(user_id: 1, title: "Test")).to be_valid
  end

  it "is valid with a numeric user ID, title, and five tags" do
    ticket = Ticket.new(user_id: 1, title: "Test")
    ticket.tags = (1..5).map do |n| Tag.new(name: "tag_#{n}") end
    expect(ticket).to be_valid
  end

  it "is invalid with a non-numeric user ID" do
    expect(Ticket.new(user_id: "XYZ", title: "Test")).to be_invalid
  end

  it "is invalid with no user ID" do
    expect(Ticket.new(title: "Test")).to be_invalid
  end

  it "is invalid with no title" do
    expect(Ticket.new(user_id: 1)).to be_invalid
  end

  it "is invalid with an empty title" do
    expect(Ticket.new(user_id: 1, title: '')).to be_invalid
  end

  it "is invalid with six tags" do
    ticket = Ticket.new(user_id: 1, title: "Test")
    ticket.tags = (1..6).map do |n| Tag.new(name: "tag_#{n}") end
    expect(ticket).to be_invalid
  end

  it "is invalid with an invalid tag" do
    ticket = Ticket.new(user_id: 1, title: "Test")
    ticket.tags = [Tag.new]
    expect(ticket).to be_invalid
  end
end
