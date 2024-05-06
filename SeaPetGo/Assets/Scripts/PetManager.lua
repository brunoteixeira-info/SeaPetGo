require 'class'

Pet = class(function(pet, name, cPower, rarity)
  pet.name = name
  pet.cPower = cPower
  pet.rarity = rarity
end)

function Animal:__tostring()
  return self.name..': '..self:speak()
end

Colobus = Pet('Colobus', 100, 'Common')
