--!Type(UI)
--!Bind
local containerPetSlot : UIImage = nil
--!Bind
local imagePetSlot : UIImage = nil
--!Bind
local textPetSlotProbability : UILabel = nil

--!Bind
local containerPetSlot2 : UIImage = nil
--!Bind
local imagePetSlot2 : UIImage = nil
--!Bind
local textPetSlotProbability2 : UILabel = nil

--!Bind
local containerPetSlot3 : UIImage = nil
--!Bind
local imagePetSlot3 : UIImage = nil
--!Bind
local textPetSlotProbability3 : UILabel = nil

--!Bind
local containerPetSlot4 : UIImage = nil
--!Bind
local imagePetSlot4 : UIImage = nil
--!Bind
local textPetSlotProbability4 : UILabel = nil

--!Bind
local containerPetSlot5 : UIImage = nil
--!Bind
local imagePetSlot5 : UIImage = nil
--!Bind
local textPetSlotProbability5 : UILabel = nil

--!SerializeField
local pet1 : string = "Pet"
--!SerializeField
local pet1probability : number = 0

--!SerializeField
local pet2 : string = "Pet"
--!SerializeField
local pet2probability : number = 0

--!SerializeField
local pet3 : string = "Pet"
--!SerializeField
local pet3probability : number = 0

--!SerializeField
local pet4 : string = "Pet"
--!SerializeField
local pet4probability : number = 0

--!SerializeField
local pet5 : string = "Pet"
--!SerializeField
local pet5probability : number = 0

local petManagerScript : module = require("PetManager")

function self:ClientStart()
    textPetSlotProbability:SetPrelocalizedText(pet1probability .. "%")
    textPetSlotProbability2:SetPrelocalizedText(pet2probability .. "%")
    textPetSlotProbability3:SetPrelocalizedText(pet3probability .. "%")
    textPetSlotProbability4:SetPrelocalizedText(pet4probability .. "%")
    textPetSlotProbability5:SetPrelocalizedText(pet5probability .. "%")
    containerPetSlot:AddToClassList("hide")
    containerPetSlot2:AddToClassList("hide")
    containerPetSlot3:AddToClassList("hide")
    containerPetSlot4:AddToClassList("hide")
    containerPetSlot5:AddToClassList("hide")

    if pet1 ~= "Pet" then
        containerPetSlot:RemoveFromClassList("hide")
        imagePetSlot.image = petManagerScript.GetPet(pet1).sprite
    end

    if pet2 ~= "Pet"  then
        containerPetSlot2:RemoveFromClassList("hide")
        imagePetSlot2.image = petManagerScript.GetPet(pet2).sprite
    end

    if pet3 ~= "Pet" then
        containerPetSlot3:RemoveFromClassList("hide")
        imagePetSlot3.image = petManagerScript.GetPet(pet3).sprite
    end

    if pet4 ~= "Pet" then
        containerPetSlot4:RemoveFromClassList("hide")
        imagePetSlot4.image = petManagerScript.GetPet(pet4).sprite
    end

    if pet5 ~= "Pet" then
        containerPetSlot5:RemoveFromClassList("hide")
        imagePetSlot5.image = petManagerScript.GetPet(pet5).sprite
    end
end