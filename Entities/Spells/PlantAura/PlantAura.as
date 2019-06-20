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

float effectRadius = 8*5;

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

	CMap@ map = getMap();
	CBlob@[] blobs;
	map.getBlobsInRadius(this.getPosition(),effectRadius,@blobs);

	if(getGameTime() % 30 == 0)
	{
		for(int i = 0; i < blobs.length; i++)
		{
			CBlob@ b = blobs[i];
			if(b.getPlayer() !is null && b.getTeamNum() == this.getTeamNum())
			{

			}
		}
	}
	

}

void onTick(CSprite@ this)
{
	CBlob@[] plants;
	getBlobsByName("plant_aura",@plants);

	CBlob@ blob = this.getBlob();
	//ParticleAnimated("heal_particle_animated.png",this.getPosition(),Vec2f(XORRandom(6) - 3,XORRandom(6) - 3),0,1,0,0, Vec2f(32,32),1,0.5,true);
	SColor color = SColor(255,XORRandom(191),255,XORRandom(191));
	CParticle@ p = ParticlePixel(blob.getPosition() + Vec2f(XORRandom(effectRadius*2)-effectRadius,XORRandom(effectRadius*2)-effectRadius),Vec2f(XORRandom(8) - 4,XORRandom(8) - 4), color,true,60);
	if(p !is null)
	{
		p.gravity = Vec2f_zero;
		p.damping = 0.9;
		p.collides = false;
	}

	for(int i = 0; i < 360; i += plants.length + 1)
	{
		SColor color = SColor(255,XORRandom(191),255,XORRandom(191));
		Vec2f pos = blob.getPosition() + Vec2f_lengthdir(effectRadius,i);//game time gets rid of some gaps and can add a rotation effect
		ParticlePixel(pos,Vec2f_zero, color,true,1);
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
