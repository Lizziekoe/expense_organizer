class Category

  attr_reader(:name,:id)

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

end
