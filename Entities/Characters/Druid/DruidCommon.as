//Druid Include

#include "MagicCommon.as";

namespace DruidParams
{
	enum Aim 
		{
			not_aiming = 0,
			charging,
			cast_1,
			cast_2,
			cast_3,
			extra_ready,
		}

	const ::f32 shoot_max_vel = 8.0f;
	const ::f32 MAX_ATTACK_DIST = 360.0f;
	const ::s32 MAX_MANA = 150;
	const ::s32 MANA_REGEN = 3;
	
	const ::string[] zombieTypes = {"zombie", "skeleton", "greg", "wraith"};
	
	const ::Spell[] spells = 
	{
		Spell("orb", "Orb", 6, "Fire a basic orb which ricochets off of most surfaces until impacting an enemy and exploding, dealing minor damage.",
			SpellType::other, 2, 40, 0, 360.0f),
							// 2 is the cost // 40 is the charge time //360.0f is the range //the 0 is the cooldown //6 is the icon it uses
			
		Spell("teleport", "Teleport to Target", 8, "Point to any visible position and teleport there.",
			SpellType::other, 20, 6, 0, 270.0f, true), 
			
		Spell("counter_spell", "Counter Spell", 16, "Destroy all spells around you. Also able to severely damage summoned creatures.",
			SpellType::other, 15, 10, 0, 8.0f, true),
			 
		Spell("revive", "Revive", 15, "Fully bring trusty allies back from the dead by aiming a reviving missile at their gravestone.",
			SpellType::other, 50, 40, 0, 360.0f, true),
			
		Spell("spreadheal", "Butt Dagger Scatter", 29, "Test spell i put here because why not.",
			SpellType::other, 30, 40, 3, 360.0f, true),	
										
		Spell("spikeorb", "SpikeBall", 30, "SpikeBall awaiting description",
				SpellType::other, 4, 18, 0, 360.0f),			
				
		Spell("sporeshot", "SporeShot", 31, "Warning Not done at all yet its broken atm",
				SpellType::other, 4, 10, 0, 360.0f),	
				
		Spell("rock_wall", "Rock Wall", 21, "Create a wall of ordinary rock in front of you that blocks most things both ways. Its not exactly durable though.",
			SpellType::other, 12, 7, 0, 14.0f, true),
				
		Spell("healing_plant", "Healing Plant", 31, "Create a plant which heals all friendly players in its aura",
				SpellType::other, 12, 7, 0, 60.0f, true),

		Spell("", "", 0, "Empty spell.",
				SpellType::other, 1, 1, 0, 0.0f),

		Spell("", "", 0, "Empty spell.",
			SpellType::other, 1, 1, 0, 0.0f),

				Spell("", "", 0, "Empty spell.",
		SpellType::other, 1, 1, 0, 0.0f),

				Spell("", "", 0, "Empty spell.",
		SpellType::other, 1, 1, 0, 0.0f),

				Spell("", "", 0, "Empty spell.",
		SpellType::other, 1, 1, 0, 0.0f),

				Spell("", "", 0, "Empty spell.",
		SpellType::other, 1, 1, 0, 0.0f),

				Spell("", "", 0, "Ur Mum Gey.",
		SpellType::other, 1, 1, 0, 0.0f),

				Spell("", "", 0, "Empty spell.",
		SpellType::other, 1, 1, 0, 0.0f),

				Spell("", "", 0, "Empty spell.",
		SpellType::other, 1, 1, 0, 0.0f),

				Spell("", "", 0, "Empty spell.",
		SpellType::other, 1, 1, 0, 0.0f),

				Spell("", "", 0, "Empty spell.",
		SpellType::other, 1, 1, 0, 0.0f)
		/*Spell("", "", 0, "Empty spell.",
				SpellType::other, 1, 1, 0, 0.0f),

		Spell("", "", 0, "Empty spell.",
				SpellType::other, 1, 1, 0, 0.0f),

		Spell("", "", 0, "Empty spell.",
				SpellType::other, 1, 1, 0, 0.0f)*/		
				
	};
}

class DruidInfo
{
	s32 charge_time;
	u8 charge_state;
	bool spells_cancelling;

	DruidInfo()
	{
		charge_time = 0;
		charge_state = 0;
		spells_cancelling = false;
	}
}; 