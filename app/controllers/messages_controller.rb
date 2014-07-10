class MessagesController < ApplicationController
  def index
    @user = User.where(locu_str_id: session['current_locu_id']).first
    @messages = Message.where('receiver_id = :locu_id OR sender_id = :locu_id', locu_id: params["locu_id"]).order("created_at desc")
    messages_to_update = @messages.where("receiver_id = session['current_locu_id']")
    messages_to_update.update_all(:read => true)
    respond_to do |format|
      format.html
      format.json { render json: @messages }
    end
  end

  def matches
    @matches = Match.where('receiver_id = :locu_id OR sender_id = :locu_id', locu_id: session['current_locu_id']).where(accepted: true)
  end

  def show 
    @message = Message.find(params[:id])
    @user = User.where(locu_str_id: session['current_locu_id']).first
    if (@user.locu_str_id == @message.sender_id) || (@user.locu_str_id == @message.receiver_id)
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
    @message.sender_id = session['current_locu_id']
    @message.save

    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message has been sent.'

        format.html { redirect_to messages_path(locu_id: @message.receiver_id) }
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
