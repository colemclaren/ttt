 ENT.Base = "base_ai"
 ENT.Type = "ai"
   
 ENT.PrintName = "T72 Russian Tank"
 ENT.Author = "Xystus234"
 ENT.Contact = "" //fill in these if you want it to be in the spawn menu
 ENT.Purpose = "for npc battles"
 ENT.Instructions = "Spawns a freaking tank(!)"
 ENT.Information	= "Soviet Army MBT"  
 ENT.Category		= "Army"
  
 ENT.AutomaticFrameAdvance = true
   
 ENT.Spawnable = false
 ENT.AdminSpawnable = false

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
  self.AutomaticFrameAdvance = bUsingAnim
end  