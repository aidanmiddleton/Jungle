require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject {
    described_class.new(
      name: "Johnny boy",
      email: "bigJohn@gotcha.net",
      password: "password",
      password_confirmation: "password"
    )
  }

  describe "validations" do
    it "is valid given correct parameters" do
      expect(subject).to be_valid
    end
    it "is invalid without password and password confirmation" do
      subject.password = nil
      expect(subject).to_not be_valid
    end
    it "needs to contain a unique case-insensitive email" do
      described_class.create!(
        name: "Johnny boy",
        email: "bigJohn@gotcha.net",
        password: "password",
        password_confirmation: "password"
        )
      expect(subject).to_not be_valid
    end
    it "must contain a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    it "must contain an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
    it "must contain password of certain length" do
      subject.password = "sss"
      expect(subject).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do

    before {
      described_class.create!(
        name: "richard",
        email: "john@test.com",
        password: "abcdefg") 
    }

    it "must log in the user given correct credentials" do
      user = described_class.authenticate_with_credentials("john@test.com","abcdefg")
      expect(user).to be_instance_of(described_class)
    end

    it "must not grant access given incorrect username" do
      user = described_class.authenticate_with_credentials("joaaadf@test.comm","abcdefg")
      expect(user).to be_nil
    end

    it "must not grant access given incorrect password" do
      user = described_class.authenticate_with_credentials("john@test.com","asssssss")
      expect(user).to be_nil
    end

    it "must trim spaces from user input and log them in" do
      user = described_class.authenticate_with_credentials("   john@test.com    ","abcdefg")
      expect(user).to be_instance_of(described_class)
    end

    it "must log in regardless of email case/CASE" do
      user = described_class.authenticate_with_credentials("John@Test.cOm","abcdefg")
      expect(user).to be_instance_of(described_class)
    end
  end

end
