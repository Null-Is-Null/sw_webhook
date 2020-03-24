require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it "is valid with a numeric user ID, title, and no tags" do
    expect(build(:ticket)).to be_valid
  end

  it "is valid with a numeric user ID, title, and five tags" do
    ticket = build(:ticket, tags: (1..5).map do |n| Tag.new(name: "tag_#{n}") end)
    expect(ticket).to be_valid
  end

  it "is invalid with a non-numeric user ID" do
    expect(build(:ticket, user_id: 'xyz')).to be_invalid
  end

  it "is invalid with no user ID" do
    expect(build(:ticket, user_id: nil)).to be_invalid
  end

  it "is invalid with no title" do
    expect(build(:ticket, title: nil)).to be_invalid
  end

  it "is invalid with an empty title" do
    expect(build(:ticket, title: '')).to be_invalid
  end

  it "is invalid with six tags" do
    ticket = build(:ticket, tags: (1..6).map do |n| Tag.new(name: "tag_#{n}") end)
    expect(ticket).to be_invalid
  end

  it "is invalid with an invalid tag" do
    ticket = build(:ticket, tags: [Tag.new])
    expect(ticket).to be_invalid
  end

  it "is invalid with duplicate tags" do
    ticket = build(:ticket, tags: [build(:tag), build(:tag)])
    expect(ticket).to be_invalid
  end

  it "is invalid with duplicate tags with different cases" do
    ticket = build(:ticket, tags: [build(:tag), build(:tag, name: "TEST")])
    expect(ticket).to be_invalid
  end
end
