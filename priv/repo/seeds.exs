# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Myapp.Repo.insert!(%Myapp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

grade1 = Myapp.Repo.insert!(%Myapp.Grades.Grade{name: "Bronze" , bonus_percentage: 1})
grade2 = Myapp.Repo.insert!(%Myapp.Grades.Grade{name: "Silver" , bonus_percentage: 3})
grade3 = Myapp.Repo.insert!(%Myapp.Grades.Grade{name: "Gold" , bonus_percentage: 5})

user1 = Myapp.Repo.insert!(%Myapp.Customers.Customer{
  email: "someemail1@test.com" , phone: "89086471965" , name: "John" , grade: grade1
  })
user2 = Myapp.Repo.insert!(%Myapp.Customers.Customer{
  email: "someemail2@test.com" , phone: "334591568" , name: "Mark" , grade: grade2
  })
user3 = Myapp.Repo.insert!(%Myapp.Customers.Customer{
  email: "someemail3@test.com" , phone: "76734545234" , name: "Tom" , grade: grade3
  })

Myapp.Repo.insert!(%Myapp.PointsWallets.PointsWallet{value: 0 , customer: user1})
Myapp.Repo.insert!(%Myapp.PointsWallets.PointsWallet{value: 0 , customer: user2})
Myapp.Repo.insert!(%Myapp.PointsWallets.PointsWallet{value: 0 , customer: user3})
