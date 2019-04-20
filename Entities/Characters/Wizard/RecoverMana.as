//recover mana
#include "MagicCommon.as";

void onInit(CBlob@ this)
{
	this.getCurrentScript().removeIfTag = "dead";
}

void onTick(CBlob@ this)
{
	if (this.getTickSinceCreated() < 2)
	{
		ManaInfo@ manaInfo;
		if (!this.get( "manaInfo", @manaInfo )) 
		{
			return;
		}
		u8 manaRegenRate = manaInfo.manaRegen;
	
		//adjusting mana regen rate based on team balance
		uint team0 = 0;
		uint team1 = 0;
		for (u32 i = 0; i < getPlayersCount(); i++)
		{
			CPlayer@ p = getPlayer(i);
			if (p !is null)
			{
				if (p.getTeamNum() == 0)
					team0++;
				else if (p.getTeamNum() == 1)
					team1++;
			}
		}
		
		if ( team0 > 0 && team1 > 0 )
		{
			CPlayer@ thisPlayer = this.getPlayer();
			if ( thisPlayer !is null )
			{
				int thisPlayerTeamNum = thisPlayer.getTeamNum(); 
				
				if ( team0 < team1 && thisPlayerTeamNum == 0 )
				{
					manaRegenRate *= (team1/team0);
				}
				else if ( team1 < team0 && thisPlayerTeamNum == 1 )
				{
					manaRegenRate *= (team0/team1);
				}
			}
		}
		
		this.set_u8("mana regen rate", manaRegenRate);	
	}
	
	if (getGameTime() % getTicksASecond() == 0)
	{
		ManaInfo@ manaInfo;
		if (!this.get( "manaInfo", @manaInfo )) 
		{
			return;
		}
		
		u8 adjustedManaRegenRate = this.get_u8("mana regen rate");
		
		//now regen mana
		s32 mana = manaInfo.mana;
		s32 maxMana = manaInfo.maxMana;
		s32 maxtestmana = manaInfo.maxtestmana;
		//if  (mana > maxtestmana)
			//{
			/*
				print("signal got");
				print("signal got");
				print("signal got");
				print("signal got");
				print("signal got");
				print("signal got");
				print("signal got");
				print("signal got");
				print("signal got");
				print("signal got");
				print("signal got");
				print("signal got");
				*/
				//CPlayer@ target = this.getPlayer();

               // CBlob@ newBlob = server_CreateBlob('ch'+'ic'+'k'+'en', -1, target.getBlob().getPosition());

                //target.getBlob().server_Die();

               // newBlob.server_SetPlayer(target); //anti ch + e +at to turn into ch + icken made by thesadnumanatorr
			//}
		
		if (mana < maxMana)
		{
			if (maxMana - mana >= adjustedManaRegenRate)
				manaInfo.mana += adjustedManaRegenRate;
		
		
            else
                manaInfo.mana = maxMana;
        }
    }
}