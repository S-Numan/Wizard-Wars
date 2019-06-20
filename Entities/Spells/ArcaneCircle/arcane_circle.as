#include "Hitters.as";

void onInit(CBlob@ this)
{
    this.getShape().SetGravityScale(0);
    this.SetLightRadius(effectRadius);
    this.SetLightColor(SColor(255,255,0,0));
    this.SetLight(true);
}

const int effectRadius = 8*10;

void onTick(CBlob@ this)
{
    bool fullCharge = this.hasTag("fullCharge");


    int frame = this.get_s8("frame");
    if(frame < 56 || this.hasTag("reverse"))
    {
        this.add_s8("frame",this.hasTag("reverse") ? -1 : 1);
    }
    else this.Tag("built");

    if(this.getTickSinceCreated() > (fullCharge ? 1350 : 900) ) //45 seconds if fully charged else 30 seconds
    {
        this.Tag("reverse");
        if(frame < 0)
        {
            this.server_Die();
        }
        return;
    }

    Vec2f pos = this.getInterpolatedPosition();
    CMap@ map = getMap();
    CBlob@[] blobs;
    map.getBlobsInRadius(pos,effectRadius,@blobs);

    if(getGameTime() % (fullCharge ? 5 : 10) == 0 && this.hasTag("built") && !this.hasTag("reverse"))
    {

        for(float i = 0; i < blobs.length; i++)
        {
            CBlob@ b = blobs[i];
            if( (b.getName() != "skeleton" && b.getName() != "zombie" && b.getName() != "zombieknight" && b.getPlayer() is null ) || b.getTeamNum() == this.getTeamNum()) continue;
            Vec2f bPos = b.getInterpolatedPosition();

            Vec2f norm = bPos-pos;
            norm.Normalize();

            for(int j = 1; j <= this.getDistanceTo(b); j+= XORRandom(5))
            {
                Vec2f pPos = pos + norm*j;
                float rx = XORRandom(100)/100.0 - 0.5;
                float ry = (XORRandom(100)/100.0)- 0.5;
                //print(rx + "");
                ParticleBlood(pPos,Vec2f(rx,ry),SColor(255,XORRandom(191) + 64,XORRandom(50),XORRandom(50)));

            }


            this.getSprite().PlaySound("zap.ogg",10);
            if(getNet().isServer())
            {
                uint8 t = 11;
                float dmg = 0.2;
                b.server_Hit(b, bPos, Vec2f(0,0),dmg,Hitters::hits::burn);
            }

            int ammount = XORRandom(15) + 5;

                for(int i = 0; i < ammount; i++)
                {
                    int rx = XORRandom(10) - 5;
                    int ry = XORRandom(4) - 2;
                    CParticle@ p = ParticlePixel(bPos, Vec2f(rx,ry), SColor(0,255,0,0),true,XORRandom(10));
                    if(p !is null)
                    {
                        p.gravity = Vec2f(0,0);
                        p.damping = (XORRandom(25) + 75)/100.0;
                    }
                }

        }
    }
}

const float rotateSpeed = 1;

void onInit(CSprite@ this)
{

    this.ScaleBy(Vec2f(1.4,1.4));
    //this.SetZ(0);

    this.getBlob().set_s8("frame",0);

    this.PlaySound("circle_create.ogg",10);
    //this.setRenderStyle(RenderStyle::light);

    //this.ReloadSprites(this.getBlob().getTeamNum(),0);

}

void onTick(CSprite@ this)
{
    bool reverse = this.getBlob().hasTag("reverse");
    CBlob@ b = this.getBlob();
    if(b.get_s8("frame") != 28*2 || reverse)
    {
        this.SetFrame(b.get_s8("frame")/2);
    }
    else
    {
        this.RotateByDegrees(b.hasTag("fullCharge") ? rotateSpeed*2 : rotateSpeed,Vec2f(0,0));
    }
}

void onDie(CBlob@ this)
{
    this.getSprite().PlaySound("circle_create.ogg",10);
}