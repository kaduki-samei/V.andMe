class Public::MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def mail_confirm
    @message = Message.new(message_params)
    if @message.invalid?
      render :new
    end
  end

  def back
    @message = Message.new(message_params)
    render :new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      MessageMailer.send_mail(@message).deliver_now
      redirect_to thanx_messages_path
    else
      render :new
    end
  end

  def thanx
  end


  private

  def message_params
    params.require(:message).permit(:name, :email, :title, :body)
  end


end
