hp = Category.create_with( name: 'HP').find_or_create_by(name: 'HP' )
dell = Category.create_with( name: 'DELL', description: 'strong').find_or_create_by(name: 'DELL' )
macbook = Category.create_with( name: 'MACBOOK', description: 'expensive').find_or_create_by(name: 'MACBOOK' )

image_src = File.join(Rails.root, "/public/uploads/product/picture/6/macbook_pro.jpg")
src_file = File.new(image_src)

hp_1 = Product.create_with(
  category_id: hp.id,
  name: 'HP 2020',
  price: 25_000_000,
  quantity: 10,
  ram: 16,
  memory: 256,
).find_or_create_by(name: 'HP 2020')

hp_1.picture = src_file
hp_1.save!

hp_2 = Product.create_with(
  category_id: hp.id,
  name: 'HP pro 2020',
  price: 30_000_000,
  quantity: 15,
  ram: 16,
  memory: 512,
).find_or_create_by(name: 'HP pro 2020')

hp_2.picture = src_file
hp_2.save!

dell_1 = Product.create_with(
  category_id: dell.id,
  name: 'Dell 2020',
  price: 25_000_000,
  quantity: 20,
  ram: 16,
  memory: 256,
).find_or_create_by(name: 'Dell 2020')

dell_1.picture = src_file
dell_1.save!

dell_2 = Product.create_with(
  category_id: dell.id,
  name: 'Dell pro 2020',
  price: 25_000_000,
  quantity: 25,
  ram: 16,
  memory: 256,
).find_or_create_by(name: 'Dell pro 2020')

dell_2.picture = src_file
dell_2.save!

macbook_1 = Product.create_with(
  category_id: macbook.id,
  name: 'Macbook pro 2020',
  price: 55_000_000,
  quantity: 5,
  ram: 32,
  memory: 512,
).find_or_create_by(name: 'Macbook pro 2020')

macbook_1.picture = src_file
macbook_1.save!

huy = User.create_with(
  email: "huytran.301099@gmail.com",
  address: FFaker::Address.street_address,
  name: FFaker::Name.last_name,
  password: '123456',
  phone: '0123456789',
).find_or_create_by(email: "huytran.301099@gmail.com")
Cart.create_with( user_id: huy.id ).find_or_create_by(user_id: huy.id)
order0 =  Order.create_with(
  user_id: huy.id,
  status: 'shipping',
  subtotal: 100,
  user_name: 'huy',
  address: '197 nguyen luong bang',
  phone: '0123456789'
).find_or_create_by(user_id: huy.id, status: 'shipping', subtotal: 100)
OrderItem.create_with(
  unit_price: 200000,
  quantity: 10,
  order_id: order0.id,
  product_id: macbook_1.id,
).find_or_create_by(unit_price: 200000, quantity: 10, order_id: order0.id, product_id: macbook_1.id)

hanh = User.create_with(
  email: "ldhanh1999@gmail.com",
  address: FFaker::Address.street_address,
  name: 'dang hanh',
  password: '123456',
  phone: '0123456789',
).find_or_create_by(email: "ldhanh1999@gmail.com")
Cart.create_with( user_id: hanh.id ).find_or_create_by(user_id: hanh.id)
order1 =  Order.create_with(
  user_id: hanh.id,
  status: 'shipped',
  subtotal: 100,
  user_name: 'hanh',
  address: '197 nguyen luong bang',
  phone: '0123456789'
).find_or_create_by(user_id: hanh.id, status: 'shipped', subtotal: 100)
OrderItem.create_with(
  unit_price: 200000,
  quantity: 10,
  order_id: order1.id,
  product_id: hp_1.id,
).find_or_create_by(unit_price: 200000, quantity: 10, order_id: order1.id, product_id: hp_1.id)

order2 = Order.create_with(
  user_id: hanh.id,
  status: 'cancelled',
  subtotal: 100,
  user_name: 'hanh',
  address: '197 nguyen luong bang',
  phone: '0123456789'
).find_or_create_by(user_id: hanh.id, status: 'cancelled', subtotal: 100)
OrderItem.create_with(
  unit_price: 200000,
  quantity: 10,
  order_id: order2.id,
  product_id: hp_2.id,
).find_or_create_by(unit_price: 200000, quantity: 10, order_id: order2.id, product_id: hp_2.id)

10.times do |i|
  user = User.create_with(
    email: "user_#{i}@gmail.com",
    address: FFaker::Address.street_address,
    name: FFaker::Name.last_name,
    password: '123456',
    phone: '0123456789',
  ).find_or_create_by(email: "user_#{i}@gmail.com")
  Cart.create_with( user_id: user.id ).find_or_create_by(user_id: user.id)
  Order.create_with(
    user_id: user.id,
    status: 'pending',
    subtotal: 100,
    user_name: user.name,
    address: user.address,
    phone: user.phone
  ).find_or_create_by(user_id: user.id, status: 'pending', subtotal: 100)

  OrderItem.create_with(
    unit_price: 200000,
    quantity: 10,
    cart_id: user.cart.id,
    product_id: dell_2.id,
  ).find_or_create_by(unit_price: 200000, quantity: 10, cart_id: user.cart.id, product_id: dell_2.id)
end
