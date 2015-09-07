class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :enrolls, dependent: :destroy
  has_many :offers, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :transactions, dependent: :destroy

  def getEnrollmentInCourse(course)
  	self.enrolls.each do |e|
  		if e.course_id == course.id
  			return e
  		end
  	end
  	return nil
  end
end
