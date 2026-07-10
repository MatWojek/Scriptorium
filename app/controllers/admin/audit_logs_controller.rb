module Admin
  class AuditLogsController < BaseController
    def index
      @logs = AuditLog.includes(:user).order(created_at: :desc)
      @logs = @logs.where(action: params[:action_type]) if params[:action_type].present?
      @logs = @logs.limit(200)
    end
  end
end