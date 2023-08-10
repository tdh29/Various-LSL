integer astro_hand;
integer hour_hand;
integer minute_hand;


string message  = "Please select whether to add or subtract hours from the clock";
list options    = [" + ","Exit"," - "];

key toucher;
integer adjustment  = 0;
integer listener;
integer chan    =-788976;
integer time    =0;


//Aries
//March 21 -
//April 19
rotation aries_rot = <-0.00001, 0.00003, -0.38268, 0.92388>;

//Taurus
//April 20 -
//May 20
rotation taurus_rot = <-0.00000, -0.00000, -0.60876, 0.79335>;

//Gemini
//May 21 -
//June 20
rotation gemini_rot = <-0.00000, -0.00000, -0.79335, 0.60876>;

//Cancer
//June 21 -
//July 22
rotation cancer_rot = <-0.00000, -0.00000, -0.92388, 0.38268>;

//Leo
//July 23 -
//August 22
rotation leo_rot =  <0.00000, 0.00000, -0.99144, 0.13053>;

//Virgo
//August 23 -
//September 22
rotation virgo_rot = <0.00000, 0.00000, 0.99144, 0.13053>;


//Libra
//September 23 -
//October 22
rotation libra_rot = <-0.00000, -0.00000, 0.92388, 0.38268>;


//Scorpio
//October 23 -
//November 21

rotation scorpio_rot =  <0.00000, 0.00000, 0.79335, 0.60876>;

//Sagittarius
//November 22 -
//December 21
rotation sagittarius_rot = <0.00000, 0.00000, 0.60876, 0.79335>;

//Capricorn
//December 22 -
//January 19
rotation capricorn_rot = <0.00000, 0.00000, 0.38268, 0.92388>;

//Aquarius
//January 20 -
//February 18
rotation aquarius_rot =  <0.00000, 0.00000, 0.13053, 0.99144>;

//Pisces
//February 19 -
//March 20
rotation pisces_rot = <-0.00000, -0.00000, -0.13053, 0.99144>;

check_sign(string date)
{
    list temp = llParseString2List(date,["-"],[]);
    integer month = llList2Integer(temp,1);
    integer day = llList2Integer(temp,2);
    if(month==1)
    {
        if(day<=20)
        {
            set_sign(capricorn_rot);
        }
        else if(day>=21)
        {
            set_sign(aquarius_rot);
        }
    }
    else if(month==2)
    {
        if(day<=18)
        {
            set_sign(aquarius_rot);
        } 
        else if(day>=19)
        {
            set_sign(pisces_rot);
        }
    }
    else if(month==3)
    {
        if(day<=20)
        {
            set_sign(pisces_rot);
        }
        else if(day>=21)
        {
            set_sign(aries_rot);
        }
    }
    else if(month==4)
    {
        if(day<=19)
        {
            set_sign(aries_rot);
        }
        else if(day>=20)
        {
            set_sign(taurus_rot);
        }
    }
    else if(month==5)
    {
        if(day<=20)
        {
            set_sign(taurus_rot);
        }
        else if(day>=21)
        {
            set_sign(gemini_rot);
        }
    }
    else if(month==6)
    {
        if(day<=20)
        {
            set_sign(gemini_rot);
        }
        else if(day>=21)
        {
            set_sign(cancer_rot);
        }
    }
    else if(month==7)
    {
        if(day<=22)
        {
            set_sign(cancer_rot);
        }
        else if(day>=23)
        {
            set_sign(leo_rot);
        }
    }
    else if(month==8)
    {
        if(day<=22)
        {
            set_sign(leo_rot);
        }
        else if(day>=23)
        {
            set_sign(virgo_rot);
        }
    }
    else if(month==9)
    {
        if(day<=22)
        {
            set_sign(virgo_rot);
        }
        else if(day>=23)
        {
            set_sign(libra_rot);
        }
    }
    else if(month==10)
    {
        if(day<=22)
        {
            set_sign(libra_rot);
        }
        else if(day>=23)
        {
            set_sign(scorpio_rot);
        }
    }
    else if(month==11)
    {
        if(day<=21)
        {
            set_sign(scorpio_rot);
        }
        else if(day>=22)
        {
            set_sign(sagittarius_rot);
        }
    }
    else if(month==12)
    {
        if(day<=21)
        {
            set_sign(sagittarius_rot);
        }
        else if(day>=22)
        {
            set_sign(capricorn_rot);
        }
    }
}

set_sign(rotation change)
{
    llSetLinkPrimitiveParamsFast(astro_hand,[PRIM_ROT_LOCAL,change]);
}

rotation make_quaternion( vector axis, float angle )
{
    vector unit_axis = llVecNorm( axis );
    float sine_half_angle = llSin( angle/2 );
    float cosine_half_angle = llCos( angle/2 );

    rotation quat;
    quat.x = sine_half_angle * unit_axis.x;
    quat.y = sine_half_angle * unit_axis.y;
    quat.z = sine_half_angle * unit_axis.z;
    quat.s = cosine_half_angle;

    return quat;
}

stop()
{
    llListenRemove(listener);
    time=0;
}

start(key toucher)
{
    time=1;
    chan = (integer) llFrand(-30-(-9000000));
    listener = llListen(chan,"",toucher,"");
    llDialog(toucher,message, options, chan);   
}

set_hour(float now)
{
    float minute = (integer)now / 60;
    float hour = (minute / 60) + adjustment;
    rotation hand_rot = make_quaternion(<0, 0, -1>, 30 * hour * DEG_TO_RAD);
    llSetLinkPrimitiveParamsFast(hour_hand,[PRIM_ROT_LOCAL,hand_rot]);
}

set_minute(float now)
{
    float now = llGetGMTclock();
    integer minute = (integer)now / 60;
    integer hour = minute / 60;
    minute = minute - (hour * 60);
    rotation hand_rot = make_quaternion(<0, 0, -1>, 6 * minute * DEG_TO_RAD);
    llSetLinkPrimitiveParamsFast(minute_hand,[PRIM_ROT_LOCAL,hand_rot]);
}

get_links()
{
    integer x;
    for(x=0;x<=llGetNumberOfPrims();x++)
    {
        if(llGetLinkName(x)=="Hour Hand")
        {
            hour_hand=x;
        }
        if(llGetLinkName(x)=="Minute Hand")
        {
            minute_hand=x;
        }
        if(llGetLinkName(x)=="Astro Hand")
        {
            astro_hand=x;
        }
    }
}


default
{
    state_entry()
    {
        get_links();
        string desc = llGetObjectDesc();
        if(desc!="")
        {
            adjustment = (integer)desc;
        }
        llSetTimerEvent(1);   
    }
    
    touch_start(integer T)
    {
        start(llDetectedKey(0));
    }
    
    timer()
    {
        float now = llGetGMTclock();
        set_minute(now);
        set_hour(now);
        check_sign(llGetDate());
        if(time>=1)
        {
            time+=1;
            if(time==60)
            {
                stop();
            }
        }
    }
    
    listen(integer C, string N, key id, string M)
    {
        if(M==" + ")
        {
            start(id);
            adjustment+=1;
        }
        else if(M==" - ")
        {
            start(id);
            adjustment-=1;
        }
        else if(M=="Exit")
        {
            stop();
        }
        llSetObjectDesc((string)adjustment);
    }
    
    on_rez(integer rez)
    {
        llResetScript();
    }
    
    changed(integer C)
    {
        if(C&CHANGED_OWNER)
        {
            llSetObjectDesc("");
            llResetScript();
        }
    }
    
}

