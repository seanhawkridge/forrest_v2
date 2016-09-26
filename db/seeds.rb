users = [
  ['ron@mail.com', 'Ron', 'Swanson', 'assets/images/profiles/ron.jpg'],
  ['ben@mail.com', 'Ben', 'Wyatt', 'assets/images/profiles/ben.jpg'],
  ['tom@mail.com', 'Tom', 'Haverford', 'assets/images/profiles/tom.jpg'],
  ['leslie@mail.com', 'Leslie', 'Knope', '/images/profiles/leslie.jpg'],
  ['ann@mail.com', 'Ann', 'Perkins', 'assets/images/profiles/ann.jpg'],
  ['april@mail.com', 'April', 'Ludgate', 'assets/images/profiles/april.jpg'],
  ['andy@mail.com', 'Andy', 'Dwyer', 'assets/images/profiles/andy.jpg'],
  ['jerry@mail.com', 'Jerry', 'Gergich', 'assets/images/profiles/jerry.jpg'],
  ['kramer@mail.com', 'Cosmo', 'Kramer', 'assets/images/profiles/kramer.jpg'],
  ['george@mail.com', 'George', 'Costanza', 'assets/images/profiles/george.jpg'],
  ['elaine@mail.com', 'Elaine', 'Benes', 'assets/images/profiles/elaine.jpg'],
  ['newman@mail.com', 'Newman', 'Newman', 'assets/images/profiles/newman.jpg'],
  ['larry@mail.com', 'Larry', 'David', 'assets/images/profiles/larry.jpg'],
  ['fred@mail.com', 'Fred', 'Armisen', 'assets/images/profiles/fred.jpg'],
  ['carrie@mail.com', 'Carrie', 'Brownstein', 'assets/images/profiles/carrie.jpg'],

]

users.each do |email, first_name, last_name, image|
  User.create(email: email, first_name: first_name, last_name: last_name, image: image)
end
