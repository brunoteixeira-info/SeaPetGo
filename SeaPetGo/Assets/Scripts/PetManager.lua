--!SerializeField
local petColobus : GameObject = nil
--!SerializeField
local spriteColobus : Texture = nil
--!SerializeField
local petGecko : GameObject = nil
--!SerializeField
local spriteGecko : Texture = nil
--!SerializeField
local petHerring : GameObject = nil
--!SerializeField
local spriteHerring : Texture = nil
--!SerializeField
local petMuskrat : GameObject = nil
--!SerializeField
local spriteMuskrat : Texture = nil
--!SerializeField
local petPudu : GameObject = nil
--!SerializeField
local spritePudu : Texture = nil
--!SerializeField
local petSparrow : GameObject = nil
--!SerializeField
local spriteSparrow : Texture = nil
--!SerializeField
local petSquid : GameObject = nil
--!SerializeField
local spriteSquid : Texture = nil
--!SerializeField
local petTaipan : GameObject = nil
--!SerializeField
local spriteTaipan : Texture = nil

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

Colobus = { name = "Colobus", cPower = 100, rarity = "Common", go = petColobus, sprite = spriteColobus}
Gecko = { name = "Gecko", cPower = 100, rarity = "Common", go = petGecko, sprite = spriteGecko}
Herring = { name = "Herring", cPower = 125, rarity = "Uncommon", go = petHerring, sprite = spriteHerring}
Muskrat = { name = "Muskrat", cPower = 125, rarity = "Uncommon", go = petMuskrat, sprite = spriteMuskrat}
Pudu = { name = "Pudu", cPower = 150, rarity = "Rare", go = petPudu, sprite = spritePudu}
Sparrow = { name = "Sparrow", cPower = 150, rarity = "Rare", go = petSparrow, sprite = spriteSparrow}
Squid = { name = "Squid", cPower = 200, rarity = "Legendary", go = petSquid, sprite = spriteSquid}
Taipan = { name = "Taipan", cPower = 200, rarity = "Legendary", go = petTaipan, sprite = spriteTaipan}

arrayPets = { Colobus, Gecko, Herring, Muskrat, Pudu, Sparrow, Squid, Taipan }
