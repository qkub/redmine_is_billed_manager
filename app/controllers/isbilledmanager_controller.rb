class IsbilledmanagerController < ApplicationController
  before_action :only => [:index, :execute] do
    redirect_to new_user_session_path unless User.current && User.current.admin
  end

  def index
    @projectId = params[:project_id]
    @projects = VwProjectOutstandingHours.all
    @date_from = nil
    @date_to = nil

    projId=params[:project_id].to_i

    unless @projectId.nil?
      @projectName = @projects.find { |l| l.project_id==projId }&.project_name
      @date_from = @projects.find { |l| l.project_id==projId }&.date_from
      @date_to = @projects.find { |l| l.project_id==projId }&.date_to
      @hours = @projects.find {  |p| p.project_id==projId }&.hours
    end

    @ttUpdates = IsBilledMarkEntry.all
    @newisbilledentry = IsBilledMarkEntry.new
  end

  def execute


    params.permit!
    mentry = IsBilledMarkEntry.create(params[:is_billed_mark_entry] ) do |u|
      u.user_id=User.current.id
    end
    mentry.save!
    stmt = "call sp_set_timetrack_billed_status(#{mentry.project_id.to_i},'#{mentry.date_from}'::date,'#{mentry.date_to}'::date,#{mentry.isbilled})"
    ActiveRecord::Base.connection.execute(stmt)

    redirect_to  action: "index"
  end

  def is_user_admin_role
    #@project = Project.find(params[:project_id])
    User.current.memberships.detect {|m| m.role.position == 1}
  end

  def is_billed_mark_entry_params
    params.require(:is_billed_mark_entry).permit(:project_id,:date_from,:date_to,:isbilled)
  end


end
