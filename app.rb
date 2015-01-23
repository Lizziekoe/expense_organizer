require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/category')
require('./lib/expense')
require('pg')


DB = PG.connect({:dbname => "expense_organizer"})

get("/") do

  @expenses = Expense.all()
  @categories = Category.all()

  erb(:index)
end

post('/expense_list') do
  description = params.fetch("description")
  amount = params.fetch("amount")
  expense = Expense.new({:description => description, :amount => amount})
  expense.save()
  @expenses = Expense.all()
  @categories = Category.all()
  erb(:index)
end

post('/added_category') do
  name = params.fetch("name")
  category = Category.new({:name => name})
  category.save()
  @categories = Category.all()
  @expenses = Expense.all()
  erb(:index)
end


get('/expense_list/:id') do
  id = params.fetch("id").to_i()
  result = DB.exec("SELECT * FROM expenses WHERE id = #{id};")
  description = result.first().fetch("description")
  amount = result.first().fetch("amount")
  @expense = Expense.new({:description => description, :amount => amount})
  @categories = Category.all()
  erb(:expense)
end


post("/expense_list/:id/added_category") do
  category_id = params.fetch("category")
  @categories = Category.all()
  erb(:expense)
end
