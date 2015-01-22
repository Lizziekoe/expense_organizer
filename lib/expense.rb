class Expense

attr_reader(:description, :amount, :date, :id, :category_id)

  define_method(:initialize) do |attributes|
    @description = attributes[:description]
    @amount = attributes[:amount]
    @date = attributes[:date]
    @id = attributes[:id]
    @category_id = attributes[:category_id]
  end

  define_method(:==) do |ex_2_compare|
    @description == ex_2_compare.description && @amount == ex_2_compare.amount && @date == ex_2_compare.date && @id == ex_2_compare.id && @category_id == ex_2_compare.category_id
  end

  define_singleton_method(:all) do
    expense_results = DB.exec("SELECT * FROM expenses;")
    expenses = []
    expense_results.each() do |expense|
      description = expense.fetch("description")
      amount = expense.fetch("amount").to_f()
      date = expense.fetch("date")
      id = expense.fetch("id").to_i()
      category_id = expense.fetch("category_id").to_i()
      expenses.push(Expense.new({:description => description, :amount => amount, :date => date, :id => id, :category_id => category_id}))
    end
    expenses
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO expenses (description, amount, date, category_id) VALUES ('#{@description}' , #{@amount} , '#{@date}' , #{@category_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:total) do
    expense_results = DB.exec("SELECT * FROM expenses;")
    total_amount = 0.0
    expense_results.each() do |expense|
      amount = expense.fetch("amount").to_f()
      total_amount = total_amount + amount
    end
    total_amount
  end

end
