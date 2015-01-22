class Expense

attr_reader(:description, :amount, :date, :id, :category)

  define_method(:initialize) do |attributes|
    @description = attributes[:description]
    @amount = attributes[:amount]
    @date = attributes[:date]
    @id = attributes[:id]
    @category = attributes[:category]
  end

  define_method(:==) do |ex_2_compare|
    @description == ex_2_compare.description && @amount == ex_2_compare.amount && @date == ex_2_compare.date && @id == ex_2_compare.id && @category == ex_2_compare.category
  end

  define_singleton_method(:all) do
    expense_results = DB.exec("SELECT * FROM expenses;")
    expenses = []
    expense_results.each() do |expense|
      description = expense.fetch("description")
      amount = expense.fetch("amount").to_f()
      date = expense.fetch("date")
      id = expense.fetch("id").to_i()
      expenses.push(Expense.new({:description => description, :amount => amount, :date => date, :id => id}))
    end
    expenses
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO expenses (description, amount, date) VALUES ('#{@description}' , #{@amount} , '#{@date}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

end
