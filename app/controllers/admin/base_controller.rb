module Admin 
  class BaseController < ApplicationController 
    before_action :require_login 
    before_action :require_admin 
    layout "admin"
  end 
end 