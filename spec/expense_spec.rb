require('spec_helper')

describe(Expense) do
  describe('#id') do
    it("returns the id") do
      test_expense = Expense.new({:description => "pizza", :amount => 3.25, :date => "2015-01-01 00:00:00", :id => 4})
      expect(test_expense.id()).to(eq(4))
    end
  end

  describe('#category_id') do
    it("returns the Category object") do
      test_category = Category.new({:name => "food"})
      test_expense = Expense.new({:category => test_category})
      expect(test_expense.category_id()).to(eq(test_category.id()))
    end
  end

  describe('#description') do
    it("returns the description") do
      test_expense = Expense.new({:description => "pizza", :amount => 3.25, :date =>  "2015-01-01 00:00:00"})
      expect(test_expense.description()).to(eq("pizza"))
    end
  end

  describe('#amount') do
    it("returns the amount of the expense") do
    test_expense = Expense.new({:description => "pizza", :amount => 3.25, :date =>  "2015-01-01 00:00:00"})
    expect(test_expense.amount()).to(eq(3.25))
    end
  end

  describe('#date') do
    it("returns the date of the expense") do
      test_expense = Expense.new({:description => "pizza", :amount => 3.25, :date => "2015-01-01 00:00:00"})
      expect(test_expense.date()).to(eq("2015-01-01 00:00:00"))
    end
  end

  describe("#==") do
    it("returns true if description, amount, date, and id are the same for both expsense objects") do
      test_expense1 = Expense.new({:description => "pizza", :amount => 3.25, :date => "2015-01-01 00:00:00"})
      test_expense2 = Expense.new({:description => "pizza", :amount => 3.25, :date => "2015-01-01 00:00:00"})
      expect(test_expense1.==(test_expense2)).to(eq(true))
    end
  end

  describe(".all") do
    it("starts out empty") do
      test_expense1 = Expense.new({:description => "pizza", :amount => 3.25, :date => "2015-01-01 00:00:00"})
      expect(Expense.all).to(eq([]))
    end
  end

  describe("#save") do
    it("saves itself to the database") do
      test_category = Category.new({:name => "food"})
      test_category.save()
      test_expense1 = Expense.new({:description => "pizza", :amount => 3.25, :date => "2015-01-01 00:00:00", :category_id => test_category.id()})
      test_expense1.save()
      expect(Expense.all).to(eq([test_expense1]))
    end
  end


end
