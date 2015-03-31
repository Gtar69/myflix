class InvitationsController < ApplicationController
  before_action :require_user
  #accept_nested_attributes_for :invitation


  def new 
    @invitation = Invitation.new
  end

  def create
    invitation = Invitation.new(invitation_params)
    invitation.inviter_id = current_user.id
    if invitation.save
      InvitationWorker.perform_async(invitation.id)
      #AppMailer.delay.send_invitation_email(invitation)#.deliver
      flash[:success] = "You are successfully invited #{invitation.recipient_name}."
      redirect_to new_invitation_path
    else
      flash[:warning] = "You should fill in recipient's name, email and message!"
      @invitation = Invitation.new
      render :new
    end
  end

  private 

  def invitation_params
    params.require(:invitation).permit(:recipient_name, :recipient_email, :message)
  end

end
