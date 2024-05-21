--!Type(Module)
local uiAchievements : UIAchievements = nil
local gameManagerScript : module = require("GameManager")

achievementsStage = {}

Stage1 = { name = "Unlock Stage 1!", type = "Stage", amountRequired = 1, reward = 100, rewardType = "Pearls" }
Stage2 = { name = "Unlock Stage 2!", type = "Stage", amountRequired = 1, reward = 100, rewardType = "Pearls" }
Stage3 = { name = "Unlock Stage 3!", type = "Stage", amountRequired = 1, reward = 100, rewardType = "Pearls" }

achievementsStage = { Stage1, Stage2, Stage3 }
local currentStage = 0
local currentIndexStage = 1

achievementsDig = {}

Dig1 = { name = "Dig 25 sandpiles.", type = "Dig", amountRequired = 25, reward = 100, rewardType = "Pearls" }
Dig2 = { name = "Dig 50 sandpiles.", type = "Dig", amountRequired = 50, reward = 250, rewardType = "Pearls" }
Dig3 = { name = "Dig 100 sandpiles.", type = "Dig", amountRequired = 100, reward = 500, rewardType = "Pearls" }

achievementsDig = { Dig1, Dig2, Dig3 }
local currentDigs = 0
local currentIndexDig = 1

achievementsShells = {}

Shells1 = { name = "Get 500 shells.", amountRequired = 500, reward = 100, rewardType = "Pearls" }
Shells2 = { name = "Get 1000 shells.", amountRequired = 1000, reward = 250, rewardType = "Pearls" }
Shells3 = { name = "Get 1500 shells.", amountRequired = 1500, reward = 500, rewardType = "Pearls" }

achievementsShells = { Shells1, Shells2, Shells3, }
local currentShells = 0
local currentIndexShells = 1

achievementsPearls = {}

Pearls1 = { name = "Get 500 pearls.", amountRequired = 500, reward = 100, rewardType = "Pearls" }
Pearls2 = { name = "Get 1000 pearls.", amountRequired = 1000, reward = 250, rewardType = "Pearls" }
Pearls3 = { name = "Get 1500 pearls.", amountRequired = 1500, reward = 500, rewardType = "Pearls" }

achievementsPearls = { Pearls1, Pearls2, Pearls3 }
local currentPearls = 0
local currentIndexPearls = 1

achievementsPetsAmount = {}

Pets1 = { name = "Get 5 pets!", amountRequired = 5, reward = 100, rewardType = "Pearls" }
Pets2 = { name = "Get 10 pets!", amountRequired = 10, reward = 250, rewardType = "Pearls" }
Pets3 = { name = "Get 20 pets!", amountRequired = 20, reward = 500, rewardType = "Pearls" }

achievementsPetsAmount = { Pets1, Pets2, Pets3 }
local currentPets = 0
local currentIndexPets = 1

function UpdateStageQuestProgress()
  print("Updating Stage Quest Progress")
  currentStage = currentStage + 1
  if(currentStage >= achievementsStage[currentIndexStage].amountRequired) then
    currentIndexStage = currentIndexStage + 1
    if(currentIndexStage > #achievementsStage) then
      uiAchievements.EndAchievementsStage()
    else
      CompleteQuest(achievementsStage[currentIndexStage].rewardType, achievementsStage[currentIndexStage].reward)
      uiAchievements.SetAchievementsStage(achievementsStage[currentIndexStage])
    end
  else
    uiAchievements.UpdateAchievementsStageProgress(currentStage, achievementsStage[currentIndexStage].amountRequired)    
  end  
end

function UpdateDigQuestProgress()
  print("Updating Dig Quest Progress")
  currentDigs = currentDigs + 1
  if(currentDigs >= achievementsDig[currentIndexDig].amountRequired) then
    currentIndexDig = currentIndexDig + 1
    if(currentIndexDig > #achievementsDig) then
      uiAchievements.EndAchievementsDig()
    else
      CompleteQuest(achievementsDig[currentIndexDig].rewardType, achievementsDig[currentIndexDig].reward)
      uiAchievements.SetAchievementsDig(achievementsDig[currentIndexDig])
    end
  else
    uiAchievements.UpdateAchievementsDigProgress(currentDigs, achievementsDig[currentIndexDig].amountRequired)
  end      
end

function UpdateShellsQuestProgress(shells)
  print("Updating Shells Quest Progress")
  currentShells = currentShells + shells
  if(currentShells >= achievementsShells[currentIndexShells].amountRequired) then
    currentIndexShells = currentIndexShells + 1
    if(currentIndexShells > #achievementsShells) then
      uiAchievements.EndAchievementsShells()
    else
      CompleteQuest(achievementsShells[currentIndexShells].rewardType, achievementsShells[currentIndexShells].reward)
      uiAchievements.SetAchievementsShells(achievementsShells[currentIndexShells])
    end
  else
    uiAchievements.UpdateAchievementsShellsProgress(currentShells, achievementsShells[currentIndexShells].amountRequired)
  end          
end

function UpdatePearlsQuestProgress(pearls)
  print("Updating Pearls Quest Progress")
  currentPearls = currentPearls + pearls
  if(currentPearls >= achievementsPearls[currentIndexPearls].amountRequired) then
    currentIndexPearls = currentIndexPearls + 1
    if(currentIndexPearls > #achievementsPearls) then
      uiAchievements.EndAchievementsPearls()
    else
      CompleteQuest(achievementsPearls[currentIndexPearls].rewardType, achievementsPearls[currentIndexPearls].reward)
      uiAchievements.SetAchievementsPearls(achievementsPearls[currentIndexPearls])
    end
  else
    uiAchievements.UpdateAchievementsPearlsProgress(currentPearls, achievementsPearls[currentIndexPearls].amountRequired)      
  end    
end

function UpdatePetsQuestProgress()
  print("Updating Pets Quest Progress")
  currentPets = currentPets + 1
  if(currentPets >= achievementsPetsAmount[currentIndexPets].amountRequired) then
    currentIndexPets = currentIndexPets + 1
    if(currentIndexPets > #achievementsPetsAmount) then
      uiAchievements.EndAchievementsPets()
    else
      CompleteQuest(achievementsPetsAmount[currentIndexPets].rewardType, achievementsPetsAmount[currentIndexPets].reward)
      uiAchievements.SetAchievementsPets(achievementsPetsAmount[currentIndexPets])
    end
  else
    uiAchievements.UpdateAchievementsPetsProgress(currentPets, achievementsPetsAmount[currentIndexPets].amountRequired)
  end      
end

function CompleteQuest(rewardType, rewardAmount)
  if(rewardType == "Shells") then
    gameManagerScript.AddShells(rewardAmount)
  elseif(rewardType == "Pearls") then
    gameManagerScript.AddPearls(rewardAmount)
  end
end

function self:ClientStart()
  local uiObj = GameObject.Find("UIManager")
  uiAchievements = uiObj:GetComponent("UIAchievements")
  uiAchievements.SetAchievementsStage(achievementsStage[1])
  uiAchievements.SetAchievementsDig(achievementsDig[1])
  uiAchievements.SetAchievementsShells(achievementsShells[1])
  uiAchievements.SetAchievementsPearls(achievementsPearls[1])
  uiAchievements.SetAchievementsPets(achievementsPetsAmount[1])
end