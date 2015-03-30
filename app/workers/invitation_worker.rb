class InvitationWorker
  include Sidekiq::Worker

  def perform(invitation_id)
    invitation = Invitation.find(invitation_id)
    AppMailer.send_invitation_email(invitation)
  end

end 