void onInit(CBlob@ this)
{
	this.getCurrentScript().tickFrequency = 29;//Slow onTick to only work every second

	if(!isServer())//If this isn't the server that is doing these calculations
	{
		return;//Stop
	}
	
	CBlob @blob = server_CreateBlob("mat_bombs", this.getTeamNum(), this.getPosition());
	if (blob != null)
	{
		this.server_PutInInventory(blob);//Make the player blob pick this up
	}
}

void onTick(CBlob@ this)
{
	if(!isServer())//If this isn't the server that is doing these calculations
	{
		return;//Stop
	}
	
	s8 timeuntilbomb = this.get_s8("timetilbomb");
	
	if(timeuntilbomb >= 15)//If the time is right
	{
		if(this.getInventory().getItemsCount() < 4)//If there are are less than 4 things in the inventory
		{
			CBlob @blob = server_CreateBlob("mat_bombs", this.getTeamNum(), this.getPosition());//Make the bomb at this blobs position
			if (blob != null)//If the blob was made (to prevent errors incase it somehow wasn't)
			{
				this.server_PutInInventory(blob);//Make the player blob pick this up
			}
			timeuntilbomb = 0;//We have made a bomb, and we can revert the timer
		}
		else//We are unable to make the bomb as the inventory of this blob is full (probably)
		{
			return;
		}
		
	}
	
	this.set_s8("timetilbomb", timeuntilbomb + 1);
	

}