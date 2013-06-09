class PrintRequestStatusMailer < ActionMailer::Base
  default from: "noreply@gatech.edu"
  
  def status_email(user, print_request)
    @user = user
    @print_request = print_request
    mail to: user.email, subject: 'Your Print Job @ Invention Studio'
  end
end

