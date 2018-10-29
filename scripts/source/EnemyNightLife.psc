Scriptname EnemyNightLife extends Quest  

Event OnInit()
	RegisterForSingleUpdate(1.0)
EndEvent

Event OnUpdate()
	Actor maleact = male.GetActorRef()
	Actor femaleact = female.GetActorRef()
	
	if (!PlayerActor.IsInCombat() && maleact && femaleact)
		debug.notification("EnemyNightLife actors detected")
		
		if (self._fillAlias(maleact) && self._fillAlias(femaleact))
			debug.notification("EnemyNightLife StartSex")
			SexLab.QuickStart(femaleact, maleact)
		else
			debug.notification("EnemyNightLife failed _fillAlias()")
		endif
	endif
	
	float period = SSLEnemyNightLifePeriod.GetValue() as float
	RegisterForSingleUpdate(period)
EndEvent

bool Function _fillAlias(Actor act)
	int i = Enemies.length
	
	while i
		i -= 1
		if (Enemies[i].ForceRefIfEmpty(act))
			return true
		elseif (!Enemies[i].GetActorRef().HasKeywordString("SexLabActive"))
			Enemies[i].ForceRefTo(act)
			return true
		endif
	endwhile
	
	return false
EndFunction

SexLabFramework Property SexLab  Auto  

Actor Property PlayerActor  Auto  
ReferenceAlias Property male  Auto  
ReferenceAlias Property female  Auto  

ReferenceAlias[] Property Enemies  Auto  
GlobalVariable Property SSLEnemyNightLifePeriod  Auto  
