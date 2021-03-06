class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  #before_action :admin_only

  def idea_name_asc
    @jobs = Job.idea_name_asc
  end

  def idea_name_desc
    @jobs = Job.idea_name_des
  end

  def new_order
    @jobs = Job.new_order
  end

  def old_order
    @jobs = Job.old_order
  end

  def empty_jobs
    @jobs = Job.empty_jobs
  end

  def apply
    puts "yoooo yooo yooo"
    @applyingfor = params[:id]

    @thisjob = Job.find(@applyingfor)
    @thisjob.filled = true
    @thisjob.user_id = current_user.id
    @thisjob.save

    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'You applied for the job' }
      format.json { head :no_content }
    end
  end


  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:role_id, :idea_id, :user_id)
    end

    def admin_only
      if !current_user.admin?
        redirect_to root_path
      end
    end
end
