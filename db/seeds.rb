users = [
  ['ron@mail.com', 'Ron', '/images/profiles/ron.jpg'],
  ['ben@mail.com', 'Ben', '/images/profiles/ben.jpg'],
  ['tom@mail.com', 'Tom', '/images/profiles/tom.jpg'],
  ['leslie@mail.com', 'Leslie', '/images/profiles/leslie.jpg'],
  ['ann@mail.com', 'Ann', '/images/profiles/ann.jpg'],
  ['april@mail.com', 'April', '/images/profiles/april.jpg'],
  ['andy@mail.com', 'Andy', '/images/profiles/andy.jpg'],
  ['jerry@mail.com', 'Jerry', '/images/profiles/jerry.jpg'],
  ['kramer@mail.com', 'Kramer', '/images/profiles/kramer.jpg'],
  ['george@mail.com', 'George', '/images/profiles/george.jpg'],
  ['elaine@mail.com', 'Elaine', '/images/profiles/elaine.jpg'],
  ['newman@mail.com', 'Newman', '/images/profiles/newman.jpg'],
  ['larry@mail.com', 'Larry', '/images/profiles/larry.jpg'],
  ['fred@mail.com', 'Fred', '/images/profiles/fred.jpg'],
  ['carrie@mail.com', 'Carrie', '/images/profiles/carrie.jpg'],

]

users.each do |email, name, image|
  User.create(email: email, name: name, image: image)
end
