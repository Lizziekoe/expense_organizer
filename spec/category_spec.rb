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

  describe("#percentage") do
    it("returns the percentage of total expenses spent in itself") do
      test_category1 = Category.new({:name => "food"})
      test_category1.save()
      test_category2 = Category.new({:name => "housing"})
      test_category2.save()
      test_expense1 = Expense.new({:description => "pizza", :amount => 3.25, :category_id => test_category1.id() ,:date => "2015-01-01 00:00:00"})
      test_expense1.save()
      test_expense2 = Expense.new({:description => "carrot", :amount => 1.25, :category_id => test_category1.id(),:date => "2015-01-01 00:00:00"})
      test_expense2.save()
      test_expense3 = Expense.new({:description => "soap", :amount => 4.50, :category_id => test_category2.id(),:date => "2015-01-01 00:00:00"})
      test_expense3.save()
      expect(test_category1.percentage()).to(eq(0.5))
    end
  end
end
