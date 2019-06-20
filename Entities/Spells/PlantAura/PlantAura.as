#include "SpellCommon.as";
#include "TeamColour.as";

void onInit(CBlob@ this)
{
	CShape@ shape = this.getShape();
	shape.SetGravityScale(0.0f);
	shape.getConsts().mapCollisions = false;
	shape.getConsts().collidable = false;
	
	this.Tag("counterable");
}

void onTick( CBlob@ this )
{
	if (this.getTickSinceCreated() < 1)
	{		
		//this.getSprite().PlaySound("rock_hit3.ogg", 1.0f, 1.0f);	
		this.server_SetTimeToDie(this.get_u16("lifetime"));
		
		CShape@ shape = this.getShape();
		shape.SetStatic(true);
		
		CSprite@ sprite = this.getSprite();
		sprite.SetRelativeZ(1000);
	}

}

void onDie(CBlob@ this)
{
	//counterSpell( this );
	
	
	//this.getSprite().PlaySound("rocks_explode2.ogg", 1.0f, 1.0f);
}

void onSetStatic(CBlob@ this, const bool isStatic)
{
	if (!isStatic) return;

	//this.getSprite().PlaySound("/build_wood.ogg");
}

bool canBePickedUp(CBlob@ this, CBlob@ byBlob)
{
	return false;
}

bool isEnemy( CBlob@ this, CBlob@ target )
{
	CBlob@ friend = getBlobByNetworkID(target.get_netid("brain_friend_id"));
	return ( !target.hasTag("dead") 
		&& target.getTeamNum() != this.getTeamNum() 
		&& (friend is null
			|| friend.getTeamNum() != this.getTeamNum()
		)
	);
}
