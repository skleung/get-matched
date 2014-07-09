class MessagesController < ApplicationController
  def index
    @user = User.where(id: session['current_userid']).first
    @messages = Message.order("created_at desc")
    byebug
    respond_to do |format|
      format.html
      format.json { render json: @messages }
    end
  end

  def show 
    @message = Message.find(params[:id])
    @user = User.where(id: session['current_userid']).first
    if (@user.id == @message.sender_id) || (@user.id == @message.receiver_id)
    else
      respond_to do |format|
        format.html { redirect_to :action => :index, notice: 'No message found' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.create(params.require(:message).permit(:receiver_id, :content))
    @message.sender_id = session['current_userid']
    @message.save
    
    respond_to do |format|
      if @message.save
        format.html { redirect_to :action => :index, notice: 'Message has been sent.' }
        format.json { render json: @messages }
      else
        format.html { redirect_to new_message_path(@message) }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end