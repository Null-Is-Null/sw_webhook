require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe "#POST create" do
    it "Accepts a valid ticket JSON payload" do
      post :create, body: build(:payload).to_json
      expect(response.status).to eq(200)
    end

    it "Accepts payload wih five tags" do
      post :create, body: build(:payload, tags: ['t1', 't2', 't3', 't4', 't5']).to_json
      expect(response.status).to eq(200)
    end

    context "with invalid attributes" do
      it "Rejects payload wih no user_id" do
        post :create, body: build(:payload, user_id: nil).to_json
        expect(response.status).to eq(422)
        expect(response.body).to eq('{"user_id":["is not a number"]}')
      end

      it "Rejects payload wih non-numeric user_id" do
        post :create, body: build(:payload, user_id: 'xyz').to_json
        expect(response.status).to eq(422)
        expect(response.body).to eq('{"user_id":["is not a number"]}')
      end

      it "Rejects payload wih no title" do
        post :create, body: build(:payload, title: '').to_json
        expect(response.status).to eq(422)
        expect(response.body).to eq('{"title":["can\'t be blank"]}')
      end

      it "Rejects payload wih six tags" do
        post :create, body: build(:payload, tags: ['t1', 't2', 't3', 't4', 't5', 't6']).to_json
        expect(response.status).to eq(422)
        expect(response.body).to eq('{"tags":["A maximum of five tags may be specified"]}')
      end

      it "Rejects payload wih an invalid tag" do
        post :create, body: build(:payload, tags: ['']).to_json
        expect(response.status).to eq(422)
        expect(response.body).to eq('{"tags":["is invalid","One or more tags are empty"]}')
      end

      it "Rejects payload wih duplicate tags" do
        post :create, body: build(:payload, tags: ['tag1', 'tag1']).to_json
        expect(response.status).to eq(422)
        expect(response.body).to eq('{"tags":["A ticket cannot have duplicate tags"]}')
      end

      it "Rejects payload wih duplicate tags with different cases" do
        post :create, body: build(:payload, tags: ['tag1', 'TAG1']).to_json
        expect(response.status).to eq(422)
        expect(response.body).to eq('{"tags":["A ticket cannot have duplicate tags"]}')
      end

      it "Rejects an empty payload" do
        post :create, body: {}.to_json
        expect(response.status).to eq(422)
        expect(response.body).to eq('{"user_id":["is not a number"],"title":["can\'t be blank"]}')
      end

      it "Rejects a non-JSON payload" do
        post :create, body: "not valid JSON"
        expect(response.status).to eq(422)
        expect(response.body).to eq('{"body":"Invalid JSON"}')
      end
    end

    it "Updates tag counts correctly" do
      post :create, body: build(:payload, tags: ['t1', 't2', 't3', 't4', 't5']).to_json
      post :create, body: build(:payload, tags: ['t3']).to_json
      expect(Tag.max_tag).to eq('t3')
    end

    it "Has an empty max tag if first tickets have no tags" do
      post :create, body: build(:payload).to_json
      expect(Tag.max_tag).to eq('')
    end

  end
end
