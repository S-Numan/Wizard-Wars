
void onInit(CBlob@ this)
{
	CShape@ shape = this.getShape();
    shape.SetGravityScale(0.0f);
	shape.getConsts().mapCollisions = false;
    shape.SetVelocity(Vec2f(0, 1.0f));
    shape.getConsts().collidable = false;
    this.addCommandID("die");	
	
}

void onTick( CBlob@ this )
{
	if (this.getTickSinceCreated() < 1)
	{		
		this.getSprite().PlaySound("EnergySound1.ogg", 1.0f, 1.0f);	
		
		CSprite@ sprite = this.getSprite();
		sprite.getConsts().accurateLighting = false;
		sprite.SetRelativeZ(1001);
	}
    Vec2f pos = this.getPosition();
	
}

bool doesCollideWithBlob( CBlob@ this, CBlob@ b )
{
    return false;
}


void onCollision( CBlob@ this, CBlob@ blob, bool solid )
{
    if(isClient())
    {
        if(blob.hasTag("player") && !blob.hasTag("extra_damage") && blob.getConfig() != "knight")
        {
            CBitStream params;
	        this.SendCommand(this.getCommandID("die"), params);//kill serverside

            ParticleAnimated( "Flash1.png",
                this.getPosition(),//pos
                Vec2f(0,0),//vecloity
                0.0f,//angle
                1.0f,//scale
                3,//animated speed
                0.0f, true );//gravity // selflit
            this.SetVisible(false);
            this.getSprite().PlaySound("snes_coin.ogg", 0.8f, 1.0f);
            
            blob.Tag("extra_damage");
            client_AddToChat("You now have increased damage for the remainder of this life.", SColor(255, 255, 0, 0));
        }
    }
}

void onCommand( CBlob@ this, u8 cmd, CBitStream @params )
{
    if(cmd == this.getCommandID("die") )
    {
        this.server_Die();
    }
}