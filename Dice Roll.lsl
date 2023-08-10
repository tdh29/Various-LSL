//Offsets for each number on the texture 4x2 grid
float H1 = -0.375;
float H2 = -0.125;
float H3 = 0.125;
float H4 = 0.375;
float H5 = -0.375;
float H6 = -0.125;
float Top_Row = 0.25;


show_result(integer num)
{
    llSetTextureAnim(LOOP, ALL_SIDES, 4, 2, 0, 0, 10);//Stop texture animation
    if(num==1)
    {
        //The paired sides are always opposite each other and always add up to 7
        llOffsetTexture(H1,Top_Row, 0);
        llOffsetTexture(H6,Top_Row*-1, 5);
        //
        llOffsetTexture(H5,Top_Row*-1, 4);
        llOffsetTexture(H2,Top_Row, 2);
        //
        llOffsetTexture(H3,Top_Row, 1);
        llOffsetTexture(H4,Top_Row, 3);
    }
    if(num==2)
    {
        llOffsetTexture(H2,Top_Row, 0);
        llOffsetTexture(H5,Top_Row*-1, 5);
        //
        llOffsetTexture(H4,Top_Row, 4);
        llOffsetTexture(H3,Top_Row, 2);
        //
        llOffsetTexture(H6,Top_Row*-1, 1);
        llOffsetTexture(H1,Top_Row, 3);
    }
    if(num==3)
    {
        llOffsetTexture(H3,Top_Row, 0);
        llOffsetTexture(H4,Top_Row, 5);
        //
        llOffsetTexture(H5,Top_Row*-1, 4);
        llOffsetTexture(H2,Top_Row, 2);
        //
        llOffsetTexture(H1,Top_Row, 1);
        llOffsetTexture(H6,Top_Row*-1, 3);
    }
    if(num==4)
    {
        llOffsetTexture(H4,Top_Row, 0);
        llOffsetTexture(H3,Top_Row, 5);
        //
        llOffsetTexture(H5,Top_Row*-1, 4);
        llOffsetTexture(H2,Top_Row, 2);
        //
        llOffsetTexture(H1,Top_Row, 1);
        llOffsetTexture(H6,Top_Row*-1, 3);
    }
    
    if(num==5)
    {
        llOffsetTexture(H5,Top_Row*-1, 0);
        llOffsetTexture(H2,Top_Row, 5);
        //
        llOffsetTexture(H3,Top_Row, 4);
        llOffsetTexture(H4,Top_Row, 2);
        //
        llOffsetTexture(H1,Top_Row, 1);
        llOffsetTexture(H6,Top_Row*-1, 3);
    }
    if(num==6)
    {
        llOffsetTexture(H6,Top_Row*-1, 0);
        llOffsetTexture(H1,Top_Row, 5);
        //
        llOffsetTexture(H2,Top_Row, 4);
        llOffsetTexture(H5,Top_Row*-1, 2);
        //
        llOffsetTexture(H4,Top_Row, 1);
        llOffsetTexture(H3,Top_Row, 3);
    }
    if(num==-1)
    {
        llOffsetTexture(H4,Top_Row*-1,ALL_SIDES);
    }
    
    if(num!=-1)//Dont want it to tell us we rolled when we rez it
    {
        llWhisper(0,"You rolled a "+(string)num);//Confirm number rolled
    }
}
        
    
default
{
    state_entry()
    {
        llSetTexture("faf14a99-f961-b446-23b6-9c1e0e803035",ALL_SIDES);
        show_result(-1);//clear the die/dice
    }

    touch_start(integer total_number)
    {
        llSetTextureAnim(ANIM_ON|LOOP, ALL_SIDES, 4, 2, 0, 0, 10);
        llSetTimerEvent(1);//more effective than a sleep
    }
    
    timer()
    {
        llSetTimerEvent(0);//Cancel timer
        integer result = 1 + (integer)(llFrand(6-1+1));//make a random number
        show_result(result);//Show the result
    }    
    
    on_rez(integer rez)
    {
        llResetScript();//just because
    }
}
