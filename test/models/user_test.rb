require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "Example", last_name: "User", email: "user@example.com", password: "welcome", password_confirmation: "welcome")
  end

  test "user should be vaild" do
    assert @user.valid?
  end

  test "first name should be present" do
    @user.first_name= "      "
    assert_not @user.valid?
    assert_equal ["First name can't be blank"], @user.errors.full_messages
  end

  test "last name should be present" do
    @user.last_name= "      "
    assert_not @user.valid?
    assert_equal ["Last name can't be blank"], @user.errors.full_messages
  end

  test "email should be present" do
    @user.email= "      "
    assert_not @user.valid?
    assert_equal "Email can't be blank", @user.errors.full_messages[0]
  end

  test "first name should be of valid length" do
    @user.first_name= "a" * 21
    assert_not @user.valid?
    assert_equal "First name is too long (maximum is 20 characters)", @user.errors.full_messages[0]
  end

  test "last name should be of valid length" do
    @user.last_name= "a" * 21
    assert_not @user.valid?
    assert_equal "Last name is too long (maximum is 20 characters)", @user.errors.full_messages[0]
  end

  test "email should be of valid length" do
    @user.email= "a" * 244 + "@example.com"
    assert_not @user.valid?
    assert_equal "Email is too long (maximum is 255 characters)", @user.errors.full_messages[0]
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
    assert_equal "Email has already been taken", duplicate_user.errors.full_messages[0]
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "UsEr@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@example.COM A_US-ER@yahoo.gmail.org first.last@example.jp alice+bob@zyx.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_bb.org user.name@example.first@last_name.com first@last+name.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert @user.invalid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
    assert_equal "Password can't be blank", @user.errors.full_messages[0]
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
    assert_equal "Password is too short (minimum is 6 characters)", @user.errors.full_messages[0]
  end
end
