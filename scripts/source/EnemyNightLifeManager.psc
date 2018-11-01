Scriptname EnemyNightLifeManager extends ReferenceAlias  

Event OnCellLoad()
	Utility.Wait(5)
	if (self.GetRef().GetCurrentLocation().HasKeyword(LocTypeDungeon))
		self.Reboot()
		; self.Stop()
		; this is the initializer AND Quest Reload Manager
		
		RegisterForSingleUpdate(8.0)
	else
		self.Shutdown()
	endif
EndEvent

Event OnUpdate()
	Actor Player = self.GetActorRef()
	if (!Player.IsInCombat() && !Player.HasKeywordString("SexLabActive"))
		if (PrimaryQuest.IsRunning())
			PrimaryQuest.Stop()
		endif
		PrimaryQuest.Start()
	endif
	
	float period = SSLEnemyNightLifePeriod.GetValue() as float
	RegisterForSingleUpdate(period)
EndEvent

Function Reboot()
	self.Shutdown()
	self.Boot()
EndFunction

Function Boot()
	SecondaryQuest.Start()
	PrimaryQuest.Start()
EndFunction

Function Shutdown()
	if (PrimaryQuest.IsRunning())
		PrimaryQuest.Stop()
	endif
	if (SecondaryQuest.IsRunning())
		SecondaryQuest.Stop()
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
Quest Property SecondaryQuest  Auto  
Keyword Property LocTypeDungeon  Auto  

GlobalVariable Property SSLEnemyNightLifePeriod  Auto  

