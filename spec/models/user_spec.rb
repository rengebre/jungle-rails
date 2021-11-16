require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "should save successfully" do
      @user = User.new(name: "Russell", email: "test@test.com", password: "123", password_confirmation: "123")

      @user.save!

      expect(@user.id).to be_present
    end

    it "should not save without matching passwords" do
      @user = User.new(name: "Russell", email: "test@test.com", password: "123", password_confirmation: "125")

      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should not save without a password" do
      @user = User.new(name: "Russell", email: "test@test.com", password: nil, password_confirmation: "125")

      @user.save

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "should not save without a password confirmation" do
      @user = User.new(name: "Russell", email: "test@test.com", password: "123", password_confirmation: "")

      @user.save

      expect(@user.id).not_to be_present
    end

    it "should have a unique email" do
      @user1 = User.new(name: "Russell", email: "test@test.com", password: "123", password_confirmation: "123")

      @user2 = User.new(name: "Russell", email: "test@test.com", password: "123", password_confirmation: "123")

      @user1.save
      @user2.save

      expect(@user2.id).not_to be_present
    end

    it "should have a case insensitive unique email" do
      @user1 = User.new(name: "Russell", email: "test@test.com", password: "123", password_confirmation: "123")

      @user2 = User.new(name: "Russell", email: "tEst@Test.coM", password: "123", password_confirmation: "123")

      @user1.save
      @user2.save

      expect(@user2.id).not_to be_present
    end

    it "should not save with missing parameters" do
      @user1 = User.new(name: "Russell", email: nil, password: "123", password_confirmation: "123")
      @user2 = User.new(name: nil, email: "test@test.com", password: "123", password_confirmation: "123")

      
      @user1.save
      @user2.save

      expect(@user1.id).not_to be_present
      expect(@user2.id).not_to be_present
    end

    it "should not save with a password under 3 characters" do
      @user = User.new(name: "Russell", email: "test@test.com", password: "12", password_confirmation: "12")
      
      @user.save

      expect(@user.id).not_to be_present
    end

  end

  describe ".authenticate_with_credentials" do
    before do
      @email = "russell_Engebretson@email.com"
      @password = "123"
      User.create(name: "Russell", email:  @email, password: "123", password_confirmation: @password)
    end

    context "given a valid username and password" do
      it "should return a valid user" do
        user = User.authenticate_with_credentials(@email, @password)

        expect(user).to be_a(User)
      end
    end

    context "given an invalid username" do
      it "should return nil" do
        user = User.authenticate_with_credentials("r@email.com", @password)

        expect(user).to eq(nil)
      end
    end

    context "given an invalid password" do
      it "should return nil" do
        user = User.authenticate_with_credentials(@email, "124")

        expect(user).to eq(nil)
      end
    end

    context "given a valid, case incensitive username and password" do
      it "should return a valid user" do
        email = "Russell_Engebretson@eMail.com"

        @user = User.authenticate_with_credentials(email, @password)

        expect(@user).to be_a(User)
      end
    end

    context "given a username with wrapping spaces and a valid password" do
      it "should return a valid user" do
        email = " russell_engebretson@email.com "

        @user = User.authenticate_with_credentials(email, @password)

        expect(@user).to be_a(User)
      end
    end
  end
end
