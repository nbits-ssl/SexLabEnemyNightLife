Scriptname EnemyNightLifeManager extends ReferenceAlias  

Event OnCellLoad()
	Utility.Wait(3)
	if (self.GetRef().GetCurrentLocation().HasKeyword(LocTypeDungeon))
		self.Reboot()
		; self.Stop()
		; this is the initializer AND Quest Reload Manager
	else
		self.Shutdown()
	endif
EndEvent

Function Reboot()
	self.Shutdown()
	self.Boot()
EndFunction

Function Boot()
	PrimaryQuest.Start()
EndFunction

Function Shutdown()
	if (PrimaryQuest.IsRunning())
		PrimaryQuest.Stop()
	endif
EndFunction

Function Toggle(bool enabled)
	if (enabled)
		self.Boot()
	else
		self.Shutdown()
	endif
EndFunction

Quest Property PrimaryQuest  Auto  
Keyword Property LocTypeDungeon  Auto  
