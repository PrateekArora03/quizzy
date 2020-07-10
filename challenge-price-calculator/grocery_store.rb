module Price
  def item_unit_price(item)
    { milk: 3.97, bread: 2.17, banana: 0.99, apple: 0.89 }[item.to_sym]
  end

  def sale_on_items(item)
    { milk: { price: 5.00, quantity: 2 }, bread: { price: 6.00, quantity: 3 } }[item.to_sym]
  end
end

class Product

  attr_reader :name, :price, :quantity
  def initialize(name, price, sale)
    @name = name
    @price = price
    @sale_price = sale ? sale[:price] : nil
    @quantity_on_sale = sale ? sale[:quantity] : nil
    @quantity = 1
  end
  
  protected
  def increment_quantity
    @quantity += 1
  end

  def calculate_product_price
    if @sale_price
      quantity_on_sale = @quantity / @quantity_on_sale
      quantity_not_on_sale = @quantity % @quantity_on_sale
      quantity_on_sale * @sale_price + quantity_not_on_sale * @price
    else
      @quantity * @price
    end
  end

  def saved_price
    @price * @quantity - calculate_product_price
  end
end

class PriceCalculater < Product

  include Price
  def initialize(items)
    @items = items
  end

  def calculate_quantity
    products = {}
    @items.split(",").each do |item|
      item.strip!
      if products[item]
        products[item].increment_quantity
      else
        products[item] = Product.new(item, item_unit_price(item), sale_on_items(item))
      end
    end
    products
  end

  def calculate_total_price
    products = calculate_quantity
    total = products.inject(0) do |total, (product_name, product)|
      total + product.calculate_product_price
    end
  end

  def calculate_saved_price
    products = calculate_quantity
    saved = products.inject(0) do |saved, (product_name, product)|
      saved + product.saved_price
    end
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
    quantity = price_calculater.calculate_quantity
    total_price = price_calculater.calculate_total_price
    saved_price = price_calculater.calculate_saved_price
    display_bill(quantity, total_price, saved_price)
  end

  def display_bill(products, total_price, saved_price)
    puts "Item \t Quantity \t Price \n" + "-"*30

    products.each do |key, value|
      puts "#{key.capitalize()} \t #{value.quantity} \t\t #{value.price}"
    end
    
    puts "\nTotal price : $#{total_price}"
    puts "You saved $#{saved_price.round(2)} today."
  end
end

order = GroceryStore.new

order.get_order
