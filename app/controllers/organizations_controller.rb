class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :analytics]
  before_action :require_adult_user, only: [:new, :create]

  def index
    @organizations = Organization.all
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      @organization.memberships.create(user: current_user, role: :admin)
      redirect_to @organization
    else
      render :new
    end
  end

  def show
    session[:organization_id] = @organization.id
  end

  def analytics
    @members = @organization.users.count
    @admins = @organization.admin_users.count
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name, :allow_posting)
  end

  def require_adult_user
    if current_user.age < 18
      redirect_to dashboard_path, alert: "You must be 18 or older to create an organization."
    end
  end
end
