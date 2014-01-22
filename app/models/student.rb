require_relative '../../db/config'

class Student < ActiveRecord::Base
  # validate :validate_email, :validate_age

  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                    :presence => true,
                    :uniqueness => true

  validates :age, :numericality => { :greater_than => 4 }

  validates :phone, :format => { :with => /^[\\(]{0,1}([0-9]){3}[\\)]{0,1}[ ]?([^0-1]){1}([0-9]){2}[ ]?[-]?[ ]?([0-9]){4}[ ]*((x){0,1}([0-9]){1,5}){0,1}$/,:multiline => true}

  def age
    birthday_to_age(self[:birthday])
  end

  def name
    self[:first_name] + " " + self[:last_name]
  end

  private

  def birthday_to_age(dob) # via philnash @ stackoverflow
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  # def validate_email
  #   unless self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  #     errors.add(:email, "is not valid")
  #     # record.errors[attribute] << (options[:message] || "is not an email")
  #   end
  # end

  # def validate_age
  #   unless self.age > 5
  #     errors.add(:age, "must be greater than 5")
  #   end
  # end
end








