// money split and notify script

key benefactor = ""; //User key/UUID of who receievs the gift

integer defaultbox = 250;
integer box1 =100; 
integer box2=500;
integer box3=1000;
integer box4=20000;

default
{
    state_entry()
    {
        llSetText("",<1,1,1>,.75);//Clears text
    }
    touch_start(integer num_detected)
    {
        //Check that the person touching is the owner
        if(llDetectedKey(0)==llGetOwner())
        {
            llRequestPermissions(llGetOwner(), PERMISSION_DEBIT);
        }
    }
    
    run_time_permissions(integer perm)
    {
        if (perm & PERMISSION_DEBIT)
        {
            llOwnerSay("Permissions passed...ready to work");
            state run;
        }
        else
        {
            llOwnerSay("Invalid Permissions...resetting now");
            state reset;
        }
    }
}

state run
{
    state_entry()
    {
        llSetClickAction(CLICK_ACTION_PAY);
        llSetPayPrice(250, [100,500,1000,20000]);
    }
    money(key id, integer amount)
    {
        llGiveMoney(benefactor,amount);
        llInstantMessage(id,"Thank you for your kind donation, this will really help out");
    }
}

state reset
{
    state_entry()
    {
        llResetScript();
    }
}
