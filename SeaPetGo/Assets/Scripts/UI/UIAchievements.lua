--!Type(UI)
--!Bind
local containerAchievements : UIImage = nil

--STAGE
--!Bind
local containerAchievStage : UIImage = nil
--!Bind
local progressBarStage : UIProgressBar = nil
--!Bind
local textProgressBarStage : UILabel = nil
--!Bind
local textAchievNameStage : UILabel = nil
--!Bind
local imageRewardStage : UIImage = nil
--!Bind
local textRewardStage : UILabel = nil

--DIG
--!Bind
local containerAchievDig : UIImage = nil
--!Bind
local progressBarDig : UIProgressBar = nil
--!Bind
local textProgressBarDig : UILabel = nil
--!Bind
local textAchievNameDig : UILabel = nil
--!Bind
local imageRewardDig : UIImage = nil
--!Bind
local textRewardDig : UILabel = nil

--SHELLS
--!Bind
local containerAchievShells : UIImage = nil
--!Bind
local progressBarShells : UIProgressBar = nil
--!Bind
local textProgressBarShells : UILabel = nil
--!Bind
local textAchievNameShells : UILabel = nil
--!Bind
local imageRewardShells : UIImage = nil
--!Bind
local textRewardShells : UILabel = nil

--PEARLS
--!Bind
local containerAchievPearls : UIImage = nil
--!Bind
local progressBarPearls : UIProgressBar = nil
--!Bind
local textProgressBarPearls : UILabel = nil
--!Bind
local textAchievNamePearls : UILabel = nil
--!Bind
local imageRewardPearls : UIImage = nil
--!Bind
local textRewardPearls : UILabel = nil

--PETS
--!Bind
local containerAchievPets : UIImage = nil
--!Bind
local progressBarPets : UIProgressBar = nil
--!Bind
local textProgressBarPets : UILabel = nil
--!Bind
local textAchievNamePets : UILabel = nil
--!Bind
local imageRewardPets : UIImage = nil
--!Bind
local textRewardPets : UILabel = nil

--!Bind
local buttonCloseAchievements : UIButton = nil
--!Bind
local buttonAchievements : UIButton = nil

--!SerializeField
local spriteShells : Texture = nil
--!SerializeField
local spritePearls : Texture = nil

--!SerializeField
local sfx_uiOpen : AudioShader = nil
--!SerializeField
local sfx_uiClose : AudioShader = nil

function self:ClientStart() 
    containerAchievements:AddToClassList("hide")
    buttonAchievements:RegisterPressCallback(function () OpenAchievements() end)
    buttonCloseAchievements:RegisterPressCallback(function () CloseAchievements() end)
end

function OpenAchievements()
    containerAchievements:RemoveFromClassList("hide")
    Audio:PlayShader(sfx_uiOpen)
end

function CloseAchievements()
    containerAchievements:AddToClassList("hide")
    Audio:PlayShader(sfx_uiClose)
end

function SetAchievementsStage(achievement)
    textAchievNameStage:SetPrelocalizedText(achievement.name)
    progressBarStage.value = 0
    textProgressBarStage:SetPrelocalizedText("0/" .. achievement.amountRequired)
    textRewardStage:SetPrelocalizedText(achievement.reward)
    GetRewardImage(imageRewardStage, achievement.rewardType)
end

function UpdateAchievementsStageProgress(currentAmount, requiredAmount)
    progressBarStage.value = currentAmount/requiredAmount
    textProgressBarStage:SetPrelocalizedText(currentAmount .. "/" .. requiredAmount)
end

function EndAchievementsStage()
    textAchievNameStage:SetPrelocalizedText("Every achievement obtained!")
    progressBarStage.value = 1
    textProgressBarStage:SetPrelocalizedText("")
    textRewardStage:SetPrelocalizedText("")
    imageRewardStage.image = nil
end

function SetAchievementsDig(achievement)
    textAchievNameDig:SetPrelocalizedText(achievement.name)
    progressBarDig.value = 0
    textProgressBarDig:SetPrelocalizedText("0/" .. achievement.amountRequired)
    textRewardDig:SetPrelocalizedText(achievement.reward)
    GetRewardImage(imageRewardDig, achievement.rewardType)
end

function UpdateAchievementsDigProgress(currentAmount, requiredAmount)
    progressBarDig.value = currentAmount/requiredAmount
    textProgressBarDig:SetPrelocalizedText(currentAmount .. "/" .. requiredAmount)
end

function EndAchievementsDig()
    textAchievNameDig:SetPrelocalizedText("Every achievement obtained!")
    progressBarDig.value = 1
    textProgressBarDig:SetPrelocalizedText("")
    textRewardDig:SetPrelocalizedText("")
    imageRewardDig.image = nil
end

function SetAchievementsShells(achievement)
    textAchievNameShells:SetPrelocalizedText(achievement.name)
    progressBarShells.value = 0
    textProgressBarShells:SetPrelocalizedText("0/" .. achievement.amountRequired)
    textRewardShells:SetPrelocalizedText(achievement.reward)
    GetRewardImage(imageRewardShells, achievement.rewardType)
end

function UpdateAchievementsShellsProgress(currentAmount, requiredAmount)
    progressBarShells.value = currentAmount/requiredAmount
    textProgressBarShells:SetPrelocalizedText(currentAmount .. "/" .. requiredAmount)
end

function EndAchievementsShells()
    textAchievNameShells:SetPrelocalizedText("Every achievement obtained!")
    progressBarShells.value = 1
    textProgressBarShells:SetPrelocalizedText("")
    textRewardShells:SetPrelocalizedText("")
    imageRewardShells.image = nil
end

function SetAchievementsPearls(achievement)
    textAchievNamePearls:SetPrelocalizedText(achievement.name)
    progressBarPearls.value = 0
    textProgressBarPearls:SetPrelocalizedText("0/" .. achievement.amountRequired)
    textRewardPearls:SetPrelocalizedText(achievement.reward)
    GetRewardImage(imageRewardPearls, achievement.rewardType)
end

function UpdateAchievementsPearlsProgress(currentAmount, requiredAmount)
    progressBarPearls.value = currentAmount/requiredAmount
    textProgressBarPearls:SetPrelocalizedText(currentAmount .. "/" .. requiredAmount)
end

function EndAchievementsPearls()
    textAchievNamePearls:SetPrelocalizedText("Every achievement obtained!")
    progressBarPearls.value = 1
    textProgressBarPearls:SetPrelocalizedText("")
    textRewardPearls:SetPrelocalizedText("")
    imageRewardPearls.image = nil
end

function SetAchievementsPets(achievement)
    textAchievNamePets:SetPrelocalizedText(achievement.name)
    progressBarPets.value = 0
    textProgressBarPets:SetPrelocalizedText("0/" .. achievement.amountRequired)
    textRewardPets:SetPrelocalizedText(achievement.reward)
    GetRewardImage(imageRewardPets, achievement.rewardType)
end

function UpdateAchievementsPetsProgress(currentAmount, requiredAmount)
    progressBarPets.value = currentAmount/requiredAmount
    textProgressBarPets:SetPrelocalizedText(currentAmount .. "/" .. requiredAmount)
end

function EndAchievementsPets()
    textAchievNamePets:SetPrelocalizedText("Every achievement obtained!")
    progressBarPets.value = 1
    textProgressBarPets:SetPrelocalizedText("")
    textRewardPets:SetPrelocalizedText("")
    imageRewardPets.image = nil
end

function GetRewardImage(image, rewardType)
    if(rewardType == "Shells") then
        image.image = spriteShells
    elseif(rewardType == "Pearls") then
        image.image = spritePearls
    end
end