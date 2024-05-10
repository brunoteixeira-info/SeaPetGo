--!SerializeField
local petColobus : GameObject = nil
--!SerializeField
local petGecko : GameObject = nil
--!SerializeField
local petHerring : GameObject = nil
--!SerializeField
local petMuskrat : GameObject = nil
--!SerializeField
local petPudu : GameObject = nil
--!SerializeField
local petPudu : GameObject = nil
--!SerializeField
local petSparrow : GameObject = nil
--!SerializeField
local petSquid : GameObject = nil
--!SerializeField
local petTaipan : GameObject = nil

arrayPets = {}

function GetPet(petName)
  print("Getting Pet: " .. petName)
  for i = 1, #arrayPets do
    print(arrayPets[i])
      if(arrayPets[i].name == petName) then
        return arrayPets[i]
      end
  end             
end

Colobus = { name = "Colobus", cPower = 100, rarity = "Common", go = petColobus}
Gecko = { name = "Gecko", cPower = 100, rarity = "Common", go = petGecko}
Herring = { name = "Herring", cPower = 125, rarity = "Uncommon", go = petHerring}
Muskrat = { name = "Muskrat", cPower = 125, rarity = "Uncommon", go = petMuskrat}
Pudu = { name = "Pudu", cPower = 150, rarity = "Rare", go = petPudu}
Sparrow = { name = "Sparrow", cPower = 150, rarity = "Rare", go = petSparrow}
Squid = { name = "Squid", cPower = 200, rarity = "Legendary", go = petSquid}
Taipan = { name = "Taipan", cPower = 200, rarity = "Legendary", go = petTaipan}

arrayPets = { Colobus, Gecko, Herring, Muskrat, Pudu, Sparrow, Squid, Taipan }
