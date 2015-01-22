require('spec_helper')

describe(Category) do
  describe('#id') do
    it("returns the id") do
      test_category = Category.new({:name => "food", :id => 4})
      expect(test_category.id()).to(eq(4))
    end
  end

  describe('#name') do
    it("returns the name") do
      test_category = Category.new({:name => "food"})
      expect(test_category.name()).to(eq("food"))
    end
  end

  describe("#==") do
    it("returns true if name and id are the same for both category objects") do
      test_category1 = Category.new({:name => "food", :id => 3})
      test_category2 = Category.new({:name => "food", :id => 3})
      expect(test_category1.==(test_category2)).to(eq(true))
    end
  end

  describe(".all") do
    it("starts out empty") do
      test_category1 = Category.new({:name => "food"})
      expect(Category.all).to(eq([]))
    end
  end

  describe("#save") do
    it("saves itself to the database") do
      test_category1 = Category.new({:name => "food"})
      test_category1.save()
      expect(Category.all).to(eq([test_category1]))
    end
  end
end
