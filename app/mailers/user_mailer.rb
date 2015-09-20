class UserMailer < ActionMailer::Base
  default from: "csmberkeley@gmail.com"
  def section_email(section) 
    recipients = []
    @section = section
    Enroll.where(section_id: section.id).each do |enroll| 
      @user = User.find(enroll.user_id)
      recipients << @user.email
    end
    if recipients.size > 0
      mail(to: recipients, subject: "[CSM] Section Information")
    end
  end
  def mentor_email(section)
    @section = section
    @students = []
    Enroll.where(section_id: section.id).each do |enroll| 
      @students << User.find(enroll.user_id)       
    end
    if @students.size > 0
      mail(to: @section.mentor_email, subject: "[CSM] About Your Section")
    end
  end
end
