require_relative "models.rb"

def populate
  Client.create(:Twitch, 100)
  Client.create(:Quantcast, 200)
  Client.create(:MuleSoft, 50)

  Restaurant.create(:BunMee, 120)
  Restaurant.create(:TropBon, 60)
  Restaurant.create(:Dosa, 300)
  Restaurant.create(:Tricolore, 250)

  Order.create(:TWI001, :Twitch, :monday)
  Order.create(:TWI002, :Twitch, :tuesday)
  Order.create(:TWI003, :Twitch, :wednesday)

  Order.create(:QUA001, :Quantcast, :monday)
  Order.create(:QUA002, :Quantcast, :tuesday)

  Order.create(:MUL001, :MuleSoft, :monday)
  Order.create(:MUL002, :MuleSoft, :wednesday)
end
