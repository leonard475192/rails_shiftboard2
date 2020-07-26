class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  layout 'shifts'

  # GET /shifts
  # GET /shifts.json
  def index
    @shift = Shift.page(params[:page]).order('created_at desc')
    users = User.where('account_id == ?', current_account.id)[0]
    if users == nil then
      user = User.new
      user.account_id = current_account.id
      user.name = '<<no name>>'
      user.save
      users = User.where 'account_id == ?', current_account.id
    end
    @user = users
    @shift = Shift.new
    @shift.user_id = @user.account_id
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
    redirect_to '/shifts'
  end

  # GET /shifts/new
  def new
    # @shift = Shift.new
    redirect_to '/shifts'
  end

  # GET /shifts/1/edit
  def edit
    redirect_to '/shifts'
  end

  # POST /shifts
  # POST /shifts.json
  def create
    @shift = Shift.page(params[:page]).order('created_at desc')
    @shift = Shift.new(shift_params)
    @user = User.where('account_id == ?', current_account.id)[0]

    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
        format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :new }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update
    redirect_to '/shifts'
    # respond_to do |format|
    #   if @shift.update(shift_params)
    #     format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @shift }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @shift.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    redirect_to '/shifts'
    # @shift.destroy
    # respond_to do |format|
    #   format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shift_params
      params.require(:shift).permit(:date, :user_id)
    end
end
