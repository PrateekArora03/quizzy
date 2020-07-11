module Price
  def item_unit_price(item)
    { milk: 3.97, bread: 2.17, banana: 0.99, apple: 0.89 }[item.to_sym]
  end

  def sale_on_items(item)
    { milk: { price: 5.00, quantity: 2 }, bread: { price: 6.00, quantity: 3 } }[item.to_sym]
  end
end

class Product

  attr_reader :name, :price
  def initialize(name, price, sale)
    @name = name
    @price = price
    @sale_price = sale ? sale[:price] : nil
    @quantity_on_sale = sale ? sale[:quantity] : nil
  end
  
  protected
  def calculate_price(quantity)
    if @sale_price
      quantity_on_sale = quantity / @quantity_on_sale
      quantity_not_on_sale = quantity % @quantity_on_sale
      quantity_on_sale * @sale_price + quantity_not_on_sale * @price
    else
      quantity * @price
    end
  end

  def saved_price(quantity)
    @price * quantity - calculate_price(quantity)
  end
end

class PriceCalculater < Product

  include Price
  attr_reader :products
  def initialize(items)
    @items = items
    @quantity = {}
    @products = {}
  end
  
  def calculate_quantity
    @items.split(",").each do |item|
      item.strip!
      if @products[item]
        increment_quantity(item)
      else
        @products[item] = Product.new(item, item_unit_price(item), sale_on_items(item))
        @quantity[item] = 1
      end
    end
    @quantity
  end

  def calculate_total_price
    total = @products.inject(0) do |total, (product_name, product)|
      total + product.calculate_price(@quantity[product_name])
    end
  end

  def calculate_saved_price
    saved = @products.inject(0) do |saved, (product_name, product)|
      saved + product.saved_price(@quantity[product_name])
    end
  end

  private
  def increment_quantity(item)
    @quantity[item] += 1
  end
end

class GroceryStore

  def get_order
    puts "Please enter all the items purchased separated by a comma:"
    items = gets.chomp
    generate_bill(items)
  end

  private
  def generate_bill(items)
    price_calculater = PriceCalculater.new(items)
    products = price_calculater.products
    quantity = price_calculater.calculate_quantity
    total_price = price_calculater.calculate_total_price
    saved_price = price_calculater.calculate_saved_price
    display_bill(products, quantity, total_price, saved_price)
  end

  def display_bill(products, quantity, total_price, saved_price)
    puts "Item \t Quantity \t Price \n" + "-"*30

    products.each do |key, value|
      puts "#{key.capitalize()} \t #{quantity[key]} \t\t #{value.price}"
    end
    
    puts "\nTotal price : $#{total_price}"
    puts "You saved $#{saved_price.round(2)} today."
  end
end

order = GroceryStore.new

order.get_order
