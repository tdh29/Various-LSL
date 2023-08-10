//The purpose of the script is to allow users other than the owner to display their photographs on the object
//On touch inventory drop is allowed for 30 seconds
//The avatar drops an texture/photograph into the contents and they are then displayed

string texture;
string new_texture;
integer texture_num;
list textures;

default
{
    state_entry()
    {
         llAllowInventoryDrop(FALSE);
         if(llGetInventoryNumber(INVENTORY_TEXTURE)==1)
         {
            texture=llGetInventoryName(INVENTORY_TEXTURE,0);
            if(texture!="")
            {
                llSetTexture(texture,0);
            }
        }
        else if(llGetInventoryNumber(INVENTORY_TEXTURE)>=2)
        {
             state cleanup;
        }
         else if(llGetInventoryNumber(INVENTORY_TEXTURE)==0)
        {
             texture="06bdd910-df28-20e3-24b6-0c106cc8d525";
             llSetTexture(texture,0);
        }
    }
    
    on_rez(integer rez)
    {
        state cleanup;
    }

    touch_start(integer total_number)
    {
        llInstantMessage(llDetectedKey(0), "Please drag your photo into my inventory, do this by holding control and dragging over me or click again to enlarge the current image.");
        state allow;
    }
    link_message(integer send_num, integer num, string msg, key id)
    {
        if(num==1)
        {
            integer z = llGetInventoryNumber(INVENTORY_TEXTURE);
            texture=msg;
            llSetTexture(texture,0);
            if(z >=1)
            {
                state clearall;
            }
            else if(z==0)
            {
                state default;
            }
        }
    }
}

state allow
{
    state_entry()
    {
        llSetTimerEvent(30);
        llAllowInventoryDrop(TRUE);
    }
    
    changed(integer mask)
    {
        if(mask & CHANGED_INVENTORY)
        {
            
            if(llGetInventoryName(INVENTORY_TEXTURE,0)!=texture && llGetInventoryNumber(INVENTORY_TEXTURE)>=1)
            {
                llSleep(1);
                texture=llGetInventoryName(INVENTORY_TEXTURE,0);
                llSay(0,texture);
                if(llGetInventoryNumber(INVENTORY_TEXTURE)>1)
                {
                    llRemoveInventory(llGetInventoryName(INVENTORY_TEXTURE,1));
                }
            }
            else if (llGetInventoryName(INVENTORY_TEXTURE,0)==texture && llGetInventoryNumber(INVENTORY_TEXTURE)>=1)
            {
                llSleep(1);
                texture=llGetInventoryName(INVENTORY_TEXTURE,1);
                llSay(0,texture);
                if(llGetInventoryNumber(INVENTORY_TEXTURE)>1)
                {
                    llRemoveInventory(llGetInventoryName(INVENTORY_TEXTURE,0));
                }
            }
            else if (llGetInventoryNumber(INVENTORY_TEXTURE)==0)
            {
                llSleep(1);
                texture=llGetInventoryName(INVENTORY_TEXTURE,0);
                llSay(0,texture);
            }
            
        }
        
        llSetTexture(texture,0);
        integer z = llGetInventoryNumber(INVENTORY_TEXTURE);
        if(z >= 2)
        {
            state cleanup;
        }
        else if (z == 0)
        {
            state default;
        }
    }
    
    timer()
    { 
        if(llGetInventoryNumber(INVENTORY_TEXTURE)!=1)
        {
             state cleanup;
        }
        else if(llGetInventoryNumber(INVENTORY_TEXTURE)==1)
        {
            state default;
        }
    }
     
    touch_start(integer T)
    {
        if(llGetInventoryNumber(INVENTORY_TEXTURE) == 0)
        {
            llMessageLinked(LINK_SET,0,texture,NULL_KEY);
        }
        else if(llGetInventoryNumber(INVENTORY_TEXTURE) != 0)
        {
            llMessageLinked(LINK_SET,0,(string)llGetInventoryKey(texture),NULL_KEY);
        }
        state default;
    }
    
    
    link_message(integer send_num, integer num, string msg, key id)
    {
        if(num==1)
        {
            integer z = llGetInventoryNumber(INVENTORY_TEXTURE);
            texture=msg;
            llSetTexture(texture,0);
            if(z >=1)
            {
                state clearall;
            }
            else if(z==0)
            {
                state default;
            }
        }
    }
}

state cleanup
{
    state_entry()
    {
        integer total = llGetInventoryNumber(INVENTORY_TEXTURE);
        integer i;
        for (i = 1; i < total; i++) 
        {
            llRemoveInventory(llGetInventoryName(INVENTORY_TEXTURE, i));
            total = llGetInventoryNumber(INVENTORY_TEXTURE);
        }
        state default;
    }

}


state clearall
{
    state_entry()
    {
        integer total = llGetInventoryNumber(INVENTORY_TEXTURE);
        integer i;
        for (i = 0; i < total; i++) 
        {
            llRemoveInventory(llGetInventoryName(INVENTORY_TEXTURE, i));
            total = llGetInventoryNumber(INVENTORY_TEXTURE);
        }
        state default;
    }

}