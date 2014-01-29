class MessagesController < ApplicationController
  def new
    @message = Message.new
    render layout: "home"
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      # TODO send message here
      UserMailer.contact_message(@message).deliver
      redirect_to root_url, notice: "Message sent! Thank you for contacting us."
    else
      redirect_to new_message_path
    end
  end

  def index
    @message = Message.new
    render layout: "home"
  end

end
