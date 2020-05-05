require 'rails_helper'

RSpec.describe Product, type: :model do

  subject {
    Product.new(
      name: "New Thing",
      quantity: 10,
      category: Category.new(
        name: "test"
      )
    )
  }
  describe 'Validations' do
    it "is valid if all attributes are present and valid" do
      subject.price = 200
      expect(subject).to be_valid
    end
    it "is not valid if name is not present" do
      subject.name = 500
      expect(subject).to_not be_valid
    end
    it "is not valid without a price present" do
      expect(subject).to_not be_valid
    end
    it "is not valid without a quantity provied" do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end
    it "is not valid without a category provided" do
      subject.category = nil
      expect(subject).to_not be_valid
    end
  end
end
