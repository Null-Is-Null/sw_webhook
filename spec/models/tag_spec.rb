require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "is valid with a name" do
    expect(build(:tag)).to be_valid
  end

  it "has a lowercase name after validation" do
    tag = build(:tag, name: "Test")
    tag.validate
    expect(tag.name).to eq("test")
  end

  it "is not valid with no name" do
    expect(build(:tag, name: nil)).to be_invalid
  end

  it "is not valid with an empty name" do
    expect(build(:tag, name: '')).to be_invalid
  end
end
