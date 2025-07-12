class MembershipsController < ApplicationController
  before_action :set_organization
  before_action :require_organization_membership

  def index
    @memberships = @organization.memberships.includes(:user)
  end

  def new
    @membership = @organization.memberships.new
  end

  def create
    email = params[:membership_user_email].to_s.strip.downcase
    user = User.find_by(email: email)

    @membership = @organization.memberships.new(role: params[:membership][:role])

    if user.nil?
      @membership.errors.add(:base, "User with email '#{email}' not found")
      render :new, status: :unprocessable_entity
    else
      @membership.user = user
      if @membership.save
        redirect_to organization_memberships_path(@organization), notice: "Member added"
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def require_organization_membership
    unless current_user.organizations.exists?(id: params[:organization_id])
      redirect_to dashboard_path, alert: "Access denied: You're not a member of this organization."
    end
  end
end
