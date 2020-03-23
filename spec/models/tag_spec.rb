require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "is valid with a name" do
    expect(Tag.new(name: "Test")).to be_valid
  end

  it "has a lowercase name after validation" do
    tag = Tag.new(name: "Test")
    tag.validate
    expect(tag.name).to eq("test")
  end

  it "is not valid without a name" do
    expect(Tag.new).to be_invalid
  end

  it "is not valid with an empty name" do
    expect(Tag.new(name: '')).to be_invalid
  end
end
