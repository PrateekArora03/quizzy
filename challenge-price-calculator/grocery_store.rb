class GroceryStore

  def initialize(item_unit_price, sale_on_items)
    @item_unit_price = item_unit_price
    @sale_on_items = sale_on_items
  end

  private
  def get_order
    puts "Please enter all the items purchased separated by a comma:"
    items = gets.chomp
    items.split(",").map(&:strip)
  end

  def calculate_quantity
    items = get_order
    items.inject(Hash.new(0)) do |quantity,item|
      quantity[item] += 1
      quantity
    end
  end

  def calculate_item_price
    cart_products = calculate_quantity.inject(Hash.new(0)) do |cart, (item, unit)|
      item = item.to_sym
      if @sale_on_items[item]
        quantity_on_sale = unit / @sale_on_items[item][:quantity]
        quantity_not_on_sale = unit % @sale_on_items[item][:quantity]
        price = quantity_on_sale * @sale_on_items[item][:price] + quantity_not_on_sale * @item_unit_price[item]
      else
        price = unit * @item_unit_price[item]
      end
      cart[item] = { quantity: unit, price: price }
      cart
    end
  end

  def calculate_total_price
    cart = { products: calculate_item_price }
    cart[:total_price] = cart[:products].inject(0) do |amount, (product, description)|
      amount + description[:price]
    end
    cart
  end

  def calculate_saved_price
    cart = calculate_total_price
    cart[:saved] = cart[:products].inject(0) do |saved, (product, description)|
      saved + (@item_unit_price[product.to_sym] * description[:quantity] - description[:price])
    end
    cart[:saved] = cart[:saved].round(2)
    cart
  end

  public
  def display_bill
    cart = calculate_saved_price
    puts "Item \t Quantity \t Price \n" + "-"*30

    cart[:products].each do |key, value|
      puts "#{key.capitalize()} \t #{value[:quantity]} \t\t #{value[:price]}"
    end
    
    puts "\nTotal price : $#{cart[:total_price]}"
    puts "You saved $#{cart[:saved]} today."
  end
end

item_unit_price = { milk: 3.97, bread: 2.17, banana: 0.99, apple: 0.89}
sale_on_items = { milk: { price: 5.00, quantity: 2 }, bread: { price: 6.00, quantity: 3 } }

order = GroceryStore.new(item_unit_price, sale_on_items)

order.display_bill
