class CommitteesController < ApplicationController
  before_action :set_selects, only: [:new, :edit, :create, :update]
  before_action :set_committee, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /committees
  # GET /committees.json
  # GET /committees.csv
  # GET /members/:member_id/committees
  # GET members/:member_id/committees.json
  # GET members/:member_id/committees.csv
  def index
    if params[:member_id]
      @member = Member.find(params[:member_id])
      @committees = @member.committees
    else
      @committees = Committee.all
    end
    @committees = @committees.include_parents.where(params[:search])
    respond_with(@committees)
  end

  # GET /committees/1
  # GET /committees/1.json
  # GET /committees/1.csv
  def show
    respond_with(@committee)
  end

  # GET /committees/new
  def new
    @committee = Committee.new
  end

  # GET /committees/1/edit
  def edit
  end

  # POST /committees
  # POST /committees.json
  def create
    @committee = Committee.new(committee_params)
    member = @committee.member
    member.admin = true

    respond_to do |format|
      if @committee.valid? && @committee.save && member.save
        format.html { redirect_to @committee, notice: 'Committee was successfully created.' }
        format.json { render :show, status: :created, location: @committee }
      else
        format.html { render :new }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /committees/1
  # PATCH/PUT /committees/1.json
  def update
    member = @committee.member
    member.admin = true
    respond_to do |format|
      if @committee.update(committee_params) && member.save
        format.html { redirect_to @committee, notice: 'Committee was successfully updated.' }
        format.json { render :show, status: :ok, location: @committee }
      else
        format.html { render :edit }
        format.json { render json: @committee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /committees/1
  # DELETE /committees/1.json
  def destroy
    @committee.destroy
    respond_to do |format|
      format.html { redirect_to committees_url, notice: 'Committee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_committee
      @committee = Committee.include_parents.find(params[:id])
    end

    def set_selects
      @members = Member.form_select.collect{|m| [m.full_name, m.id]}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def committee_params
      params.require(:committee).permit(
        :name,
        :member_id,
      )
    end
end
