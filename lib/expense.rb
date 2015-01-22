class Expense

attr_reader(:description, :amount, :date, :id)

  define_method(:initialize) do |attributes|
    @description = attributes.fetch(:description)
    @amount = attributes.fetch(:amount)
    @date = attributes.fetch(:date)
    @id = attributes[:id]
  end

  define_method(:==) do |expense_to_compare|
    @description.==(expense_to_compare.description).&(@amount.==(expense_to_compare.amount()).&(@date.==(expense_to_compare.date()).&(@id.==(expense_to_compare.id()))))
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
