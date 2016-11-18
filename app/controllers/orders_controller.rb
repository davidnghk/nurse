class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :cancel, :acknowledge, :followup, :escalate, :complete, :reopen ]
  
  def cancel
    @order.cancel!
    redirect_to orders_path(:status => "All")   
  end
  
  def acknowledge
    @order.acknowledgement_datetime = Time.now
    @order.technician = current_user
    @order.acknowledge!
    redirect_to orders_path(:status => "All")  
  end
  
  def followup
    @order.followup!
    redirect_to orders_path(:status => "All") 
  end
  
  def escalate
    OrderMailer.delay.escalate_order_to_manager(@order)
    #OrderMailer.escalate_order_to_manager(@order).deliver
    @order.escalate!
    redirect_to orders_path(:status => "All") 
  end
  
  def photograph
    @order.photograph!
    redirect_to orders_path(:status => "All") 
  end
  
  def complete
    @order.complete!
    redirect_to orders_path(:status => "All") 
  end
  
  def reopen
    @order.acknowledgement_datetime = nil
    @order.repair_date = Date.today
    @order.reopen!
    #OrderMailer.delay.new_order_to_repairman(@order)
    OrderMailer.new_order_to_repairman(@order).deliver
    redirect_to orders_path(:status => "All")  
  end
  
  def download
    @orders = Order.all
    respond_to do |format|
      format.html  
      format.xls 
      format.xlsx 
    end  

  end
  
  # GET /orders
  # GET /orders.json
  def index
    if params[:status] or params[:order_type] == "MyOrder"
          if params[:status] == "Open"
            @orders = Order.Open.where("repair_date >= ?", Time.zone.now.beginning_of_day)
          end
          if params[:status] == "Acknowledged"
            @orders = Order.Acknowledged.where("repair_date >= ?",   Time.zone.now.beginning_of_day)
          end
          if params[:status] == "All"
            @orders = Order.where("repair_date >= ?", Time.zone.now.beginning_of_day)
          end
          if params[:status] == "Escalated"
            @orders = Order.Escalated.where("repair_date >= ?", Time.zone.now.beginning_of_day)
          end
          if params[:order_type] == "MyOrder"
            @orders = Order.where("technician_id = ? and repair_date >= ?", current_user.id, Time.zone.now.beginning_of_day )
          end
    else
      if params[:order_type] == "OrderList"
        @orders = Order.where("technician_id = ? and repair_date < ?", current_user.id, 
          Date.today )
      end
      @all = Order.all
      # @q = Order.history.ransack(params[:q])
      @q = Order.ransack(params[:q])
      @orders = @q.result
      @orders = @q.result.paginate(:page => params[:page], :per_page => 30)
    end
    respond_to do |format|
      format.html  
      format.csv { render text: @all.to_csv}
      format.xls 
      format.xlsx 
      format.json
      format.mobile 
    end 
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    if params[:store_id]
      @order.store_id = params[:store_id]
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params) 
    @order.call_date = Time.now

    respond_to do |format|
      if @order.save
        # OrderMailer.delay.new_order_to_repairman(@order)      
        OrderMailer.new_order_to_repairman(@order).deliver
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      #if @order.Acknowledged? 
      #  @order.photograph!
      # end
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_photo
    @order.photo.destroy #Will remove the attachment and save the model
    @order.photo.clear #Will queue the attachment to be deleted
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:store_id, :call_date, :repair_date, :status, :technician_id, :device_id, :issue_id, :user_ref, :work_id, :acknowledgement_datetime, :notes, :image_01, :image_02, :image_03, :image_04,
      :document_01, :document_02, :document_03, :document_04, :document_05)
    end
end
