//A silent auction script
//Owner sets authorised users in authorised_users list alloying spoecific people to end the auction
//Debit permissions are required to refund an outbid bidder
//When someone is oputbid they receive a refund and a message telling them they've been outbid
//At the end of the auction an authorised user ends the auction and is informed of the winner user name and display name

integer Highest =0;
key Highest_bidder;
list winner;
//Comma separated list of people who can use the device user key written in parentheses eg replace "UUID1" with "5d0aab75-2c56-4f27-be30-1e92cb72935 (avatar key)
list authorised_users =["UUID1","UUID2","UUID3"];
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
        llSetPayPrice(Highest+250, [Highest+1, Highest+10, Highest+100, Highest+1000]);
            
        
        
    }
    money(key id, integer amount)
    {
        if (amount > Highest)
        {
            llInstantMessage(id,"You are the new high bidder, congratulations!!");
            if(Highest>0)
            {
                llGiveMoney(Highest_bidder,Highest);
                llInstantMessage(Highest_bidder,"Oh no! You have been outbid, but there's still time to win!");//put your message here
            }
            Highest_bidder = id;
            Highest = amount;
            winner =  [llGetUsername(id),llGetDisplayName(id)];
            llSetText("The highest bid is L$"+(string)Highest, <1,1,1>,1);
            llSetPayPrice(Highest+250, [Highest+1, Highest+10, Highest+100, Highest+1000]);
        }
    }
    touch_start(integer num)
    {
        key toucher = llDetectedKey(0);
        if(toucher=="ad1135c6-5ea6-45d3-917a-aa3609e46cb5"||toucher=="a54bbbfe-507a-4d9b-aae9-29517384647b"||toucher=="5d0aab75-2c56-4f27-be30-1e92cb72935c")
        {
            llInstantMessage(toucher,"The winner is Username "+llList2String(winner,0)+". Display name "+llList2String(winner,1));
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
