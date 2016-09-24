users = [
  ['ron@mail.com', 'Ron', 'Swanson', '/images/profiles/ron.jpg'],
  ['ben@mail.com', 'Ben', 'Wyatt', '/images/profiles/ben.jpg'],
  ['tom@mail.com', 'Tom', 'Haverford', '/images/profiles/tom.jpg'],
  ['leslie@mail.com', 'Leslie', 'Knope', '/images/profiles/leslie.jpg'],
  ['ann@mail.com', 'Ann', 'Perkins', '/images/profiles/ann.jpg'],
  ['april@mail.com', 'April', 'Ludgate', '/images/profiles/april.jpg'],
  ['andy@mail.com', 'Andy', 'Dwyer', '/images/profiles/andy.jpg'],
  ['jerry@mail.com', 'Jerry', 'Gergich', '/images/profiles/jerry.jpg'],
  ['kramer@mail.com', 'Cosmo', 'Kramer', '/images/profiles/kramer.jpg'],
  ['george@mail.com', 'George', 'Costanza', '/images/profiles/george.jpg'],
  ['elaine@mail.com', 'Elaine', 'Benes', '/images/profiles/elaine.jpg'],
  ['newman@mail.com', 'Newman', 'Newman', '/images/profiles/newman.jpg'],
  ['larry@mail.com', 'Larry', 'David', '/images/profiles/larry.jpg'],
  ['fred@mail.com', 'Fred', 'Armisen', '/images/profiles/fred.jpg'],
  ['carrie@mail.com', 'Carrie', 'Brownstein', '/images/profiles/carrie.jpg'],

]

users.each do |email, first_name, last_name, image|
  User.create(email: email, first_name: first_name, last_name: last_name, image: image)
end
