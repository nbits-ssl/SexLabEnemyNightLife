Scriptname EnemyNightLife extends Quest  

Event OnInit()
	self.Log("Update")
	
	Actor maleact = male.GetActorRef()
	Actor femaleact = female.GetActorRef()
	
	if (!PlayerActor.IsInCombat() && maleact && femaleact)
		self.Log("actors detected")
		
		if (self._fillAlias(maleact) && self._fillAlias(femaleact))
			self.Log("StartSex")
			femaleact.AddSpell(SSLEnemyNightLifeBlind)
			maleact.AddSpell(SSLEnemyNightLifeBlind)
			
			SexLab.QuickStart(femaleact, maleact)
		else
			self.Log("failed _fillAlias()")
		endif
	endif
	
	self.Stop()
EndEvent

bool Function _fillAlias(Actor act)
	int i = Enemies.length
	
	while i
		i -= 1
		if (Enemies[i].ForceRefIfEmpty(act))
			return true
		else
			Actor enemy = Enemies[i].GetActorRef()
			if (!enemy.IsInFaction(SSLEnemyNightLifePicked) && \
				!enemy.HasKeywordString("SexLabActive"))
				
				Enemies[i].ForceRefTo(act)
				return true
			endif
		endif
	endwhile
	
	return false
EndFunction

Function Log(String msg)
	bool debugLogFlag = true
	; bool debugLogFlag = false

	if (debugLogFlag)
		debug.trace("[EnemysNightLife] " + msg)
	endif
EndFunction

SexLabFramework Property SexLab  Auto  

Actor Property PlayerActor  Auto  
ReferenceAlias Property male  Auto  
ReferenceAlias Property female  Auto  
ReferenceAlias[] Property Enemies  Auto  

Faction Property SSLEnemyNightLifePicked  Auto  
SPELL Property SSLEnemyNightLifeBlind  Auto  
