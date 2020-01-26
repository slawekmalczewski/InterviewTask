class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

    def index
      @search_item = Message.order(sort_column + " " + sort_direction)
    end


    def show

    end


    def new
      @message = Message.new
    end


    def edit
    end

    def search
      @results = Message.where("message_email LIKE ?", "%" + params[:q] + "%")
    end

    def search_range
      @search = MessageSearch.new(params[:search])
      @messages = @search.scope
    end


    def create
      @message = Message.new(message_params)

      respond_to do |format|
        if @message.save
          format.html { redirect_to @message, notice: 'Message was successfully created.' }
          format.json { render :show, status: :created, location: @message }
        else
          format.html { render :new }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
        if @message.update(message_params)
          redirect_to({:controller => 'messages',:action => 'index'}, :notice => 'Message updated successfully')
        else
          format.html { render :edit }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end
    end


    def destroy
      @message.destroy
      respond_to do |format|
        format.html { redirect_to clients_url, notice: 'Message was successfully destroyed.' }
        format.json { head :no_content }
      end
    end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:message_first_name, :message_last_name, :message_email, :message_amount, :message_upload)
    end

    def sort_column
      Message.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
