item_unit_price = { Milk: 3.97, Bread: 2.17, Banana: 0.99, Apple: 0.89}
sale_on_items = { Milk: { price: 5.00, quantity: 2 }, Bread: { price: 6.00, quantity: 3 } }

puts "Please enter all the items purchased separated by a comma:"
items_list = gets.chomp
puts "Item \t Quantity \t Price \n" + "-"*30

cart = { products: {}, saved: 0.00, total_price: 0.00 }

items_list.split(",").each do |item|
  item = item.strip.capitalize().to_sym

  if cart[:products][item].nil?
    cart[:products][item] = { quantity: 0, price: 0.00 }
  end

  cart[:products][item][:quantity] += 1
  
  if sale_on_items.key?(item) && cart[:products][item][:quantity] % sale_on_items[item][:quantity] == 0 && cart[:products][item][:quantity] != 0
    cart[:products][item][:price] -= (sale_on_items[item][:quantity] - 1) * item_unit_price[item]
    cart[:products][item][:price] += sale_on_items[item][:price]
    cart[:saved] += (item_unit_price[item] * sale_on_items[item][:quantity]) - sale_on_items[item][:price]
    cart[:total_price] -= (sale_on_items[item][:quantity] - 1) * item_unit_price[item]
    cart[:total_price] += sale_on_items[item][:price]
  else
    cart[:products][item][:price] += item_unit_price[item]
    cart[:total_price] +=  item_unit_price[item]
  end
end

cart[:products].each do |key, value|
  puts "#{key} \t #{value[:quantity]} \t\t #{value[:price]}"
end

puts "Total price : $ #{cart[:total_price]}"
puts "You saved $ #{cart[:saved]} today."
