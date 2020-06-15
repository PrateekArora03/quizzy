class QuestionValidator < ActiveModel::Validator
  
  def validate(record)

    record.options.each do |option|
      return record.errors.add(:options, "can't be blank") unless option.present?
    end

    record.errors.add(:options, "should have atleast 2 values") if record.options.length < 2

    record.errors.add(:options, "should not have more than 4 values") if record.options.length > 4
  end
end
