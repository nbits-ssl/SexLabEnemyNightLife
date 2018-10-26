Scriptname EnemyNightLifeEnemy extends ReferenceAlias  

Form PreSource = None

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked) 
	
	if (PreSource == akSource)
		return
	endif
	
	GotoState("Busy")
	PreSource = akSource
	
	self._stopSex()
	
	Utility.Wait(0.5)
	PreSource = None
	GotoState("")
	
	self.Clear()
EndEvent

State Busy
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
		; do nothing
	EndEvent
EndState

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
	if (aeCombatState > 0)
		self._stopSex()
		self.Clear()
	endif
EndEvent

Event OnDying(Actor akKiller)
	ObjectReference wobj = self.GetActorRef() as ObjectReference
	wobj.SetPosition(wobj.GetPositionX(), wobj.GetPositionY() + 10.0, wobj.GetPositionZ())
	debug.sendAnimationEvent(wobj, "ragdoll")
	self.Clear()
EndEvent

Event OnDeath(Actor akKiller)
	self.Clear()
EndEvent

Function _stopSex()
	Actor selfact = self.GetActorRef()
	
	if (selfact)
		if selfact.HasKeyWordString("SexLabActive")
			sslThreadController controller = SexLab.GetActorController(selfact)
			if (controller)
				controller.EndAnimation()
			endif
		endif
	endif
EndFunction

SexLabFramework Property SexLab  Auto  
