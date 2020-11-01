hp = Category.create_with( name: 'HP').find_or_create_by(name: 'HP' )
dell = Category.create_with( name: 'DELL', description: 'strong').find_or_create_by(name: 'DELL' )
macbook = Category.create_with( name: 'MACBOOK', description: 'expensive').find_or_create_by(name: 'MACBOOK' )

hp_1 = Product.create_with(
  category_id: hp.id,
  name: 'HP 2020',
  price: 25_000_000,
  quantity: 10,
  ram: 16,
  memory: 256,
).find_or_create_by(name: 'HP 2020')

hp_2 = Product.create_with(
  category_id: hp.id,
  name: 'HP pro 2020',
  price: 30_000_000,
  quantity: 15,
  ram: 16,
  memory: 512,
).find_or_create_by(name: 'HP pro 2020')

dell_1 = Product.create_with(
  category_id: dell.id,
  name: 'Dell 2020',
  price: 25_000_000,
  quantity: 20,
  ram: 16,
  memory: 256,
).find_or_create_by(name: 'Dell 2020')

dell_2 = Product.create_with(
  category_id: dell.id,
  name: 'Dell pro 2020',
  price: 25_000_000,
  quantity: 25,
  ram: 16,
  memory: 256,
).find_or_create_by(name: 'Dell pro 2020')

macbook_1 = Product.create_with(
  category_id: macbook.id,
  name: 'Macbook pro 2020',
  price: 55_000_000,
  quantity: 5,
  ram: 32,
  memory: 512,
).find_or_create_by(name: 'Macbook pro 2020')