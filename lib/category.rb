class Category

  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_method(:==) do |category_to_compare|
    @name == category_to_compare.name() && @id == category_to_compare.id()
  end

  define_singleton_method(:all) do
    category_results = DB.exec("SELECT * FROM categories;")
    categories = []
    category_results.each() do |category|
      name = category.fetch("name")
      id = category.fetch("id").to_i()
      categories.push(Category.new({:name => name, :id => id}))
    end
    categories
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO categories (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:percentage) do
    total = Expense.total()
    expenses = self.all_expenses()
    category_total = 0.0
    expenses.each() do |expense|
      category_total = category_total + expense.amount()
    end
    category_total/total
  end

  define_method(:add_expense) do |expense_id|
    DB.exec("INSERT INTO categories_expenses (category_id, expense_id) VALUES (#{@id} , #{expense_id});")
  end

  define_method(:all_expenses) do
    expense_results = DB.exec("SELECT expenses.* FROM categories JOIN categories_expenses ON (categories.id = categories_expenses.category_id) JOIN expenses ON (categories_expenses.expense_id = expenses.id) WHERE categories.id = #{@id};")
    expenses = []
    expense_results.each() do |expense|
      description = expense.fetch("description")
      amount = expense.fetch("amount").to_f()
      date = expense.fetch("date")
      id = expense.fetch("id").to_i()
      expenses.push(Expense.new({:description => description, :amount => amount, :date =>date, :id => id}))
    end
    expenses
  end
end
