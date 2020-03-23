class TicketsController < ApplicationController

  def create
    ticket_data = JSON.parse(request.body.read).symbolize_keys
    tag_data = ticket_data.delete(:tags) || []
    @ticket = Ticket.new(**ticket_data)
    @ticket.tags = tag_data.map do |tag| Tag.find_or_create_by(name: tag) end

    if @ticket.save
      deliver_webhook
      head :ok
    else
      errors = @ticket.errors.messages
      render json: errors.to_json, status: :unprocessable_entity
    end
  end

  private
  def deliver_webhook
    max_tag = Tag.order(:count).last&.name || ''
    headers = { 'Content-Type' => 'application/json' }
    body = { max_tag: max_tag }.to_json
    endpoint = ENV['WEBHOOK_ENDPOINT']

    HTTParty.post(endpoint, headers: headers, body: body)
  end

end
