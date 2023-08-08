//Split profit sales script

key partnerid = "";//Need the key of who you are splitting profit with (not the owner of the object)
integer pay = 200; // item price
float comission=50; // for % comission

list items;
default
{
    state_entry()
    {
        llSetText("",<1,1,1>,.75);
    }
    touch_start(integer num_detected)
    {
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
        llSetPayPrice(PAY_HIDE, [pay, PAY_HIDE, PAY_HIDE, PAY_HIDE]);
        items=[];
        integer count=llGetInventoryNumber(INVENTORY_ALL);
        integer i;
        string script_name=llGetScriptName();
        for(i=0; i<count; ++i)
        {
            string name=llGetInventoryName(INVENTORY_ALL,i);
            if(name!=script_name)
            {
                items+=name;
            }
        }
        integer list_length=llGetListLength(items);
        if(list_length>=1)
        {
            //llGiveInventoryList(llGetOwner(),"test",items);
            llOwnerSay("/me found items to sell:\n"+llDumpList2String(items,"\n"));
            llSetText((string)pay+"L$",<1,1,1>,.75);
        }
        else
        {
            llOwnerSay("/me found no items to sell! Please put some in and touch again!");
            state reset;
        }
            
        
        
    }
    money(key id, integer amount)
    {
        if (amount == pay)
        {
            llInstantMessage(id,"Thank you for your purchase!");
            llGiveInventoryList(id,"*"+llGetObjectName()+"*",items);
            float percentage = (float)pay/100*comission;
            llGiveMoney(partnerid,(integer)percentage);
            llInstantMessage(partnerid,llKey2Name(id)+"I was bought");//put your message here
        }
    }
    
}

state reset
{
    state_entry()
    {
        llResetScript();
    }
}
