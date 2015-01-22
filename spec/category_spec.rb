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
      test_expense1 = Expense.new({:description => "pizza", :amount => 3.25,:date => "2015-01-01 00:00:00"})
      test_expense1.save()
      test_expense2 = Expense.new({:description => "carrot", :amount => 1.25,:date => "2015-01-01 00:00:00"})
      test_expense2.save()
      test_expense3 = Expense.new({:description => "soap", :amount => 4.50,:date => "2015-01-01 00:00:00"})
      test_expense3.save()
      test_category1.add_expense(test_expense1.id())
      test_category1.add_expense(test_expense2.id())
      test_category2.add_expense(test_expense2.id())
      test_category2.add_expense(test_expense3.id())
      expect(test_category1.percentage()).to(eq(0.5))
    end
  end

  describe("#add_expense") do
    it("will insert into the categories_expenses table in the database") do
      test_category1 = Category.new({:name => "food"})
      test_category1.save()
      test_expense1 = Expense.new({:description => "pizza", :amount => 3.25,:date => "2015-01-01 00:00:00"})
      test_expense1.save()
      test_expense2 = Expense.new({:description => "carrot", :amount => 1.25,:date => "2015-01-01 00:00:00"})
      test_expense2.save()
      test_category1.add_expense(test_expense1.id())
      test_category1.add_expense(test_expense2.id())
      expect(test_category1.all_expenses()).to(eq([test_expense1,test_expense2]))
    end
  end

  describe("#all_expenses") do
    it("returns an array with all expense objects with itself as a category") do
      test_category1 = Category.new({:name => "food"})
      test_category1.save()
      test_expense1 = Expense.new({:description => "pizza", :amount => 3.25,:date => "2015-01-01 00:00:00"})
      test_expense1.save()
      test_expense2 = Expense.new({:description => "carrot", :amount => 1.25,:date => "2015-01-01 00:00:00"})
      test_expense2.save()
      test_category1.add_expense(test_expense1.id())
      test_category1.add_expense(test_expense2.id())
      expect(test_category1.all_expenses()).to(eq([test_expense1,test_expense2]))
    end
  end

end
