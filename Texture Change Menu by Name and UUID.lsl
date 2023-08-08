//Texture change script using a list of textrure names and UUID  
//The dialog box will always be served to the user until they select close (to save reclicking the object)

//Required
integer FACE = -1; //-1 = All faces
integer LINK = LINK_SET; //LINK_SET = All prims in set, change to LINK_ROOT, LINK_ALL_OTHERS, or specific link 
integer CHANNEL;
integer listener;
//
//Variables
string part_message="Please select a part to change"; 
string texture_message="Please select texture option"; 
float time=120;
list menu_options=[];//List is generated from texture list

//Texture Name, Texture UUID
list textures = [
"Asian Teahouse", "e417f443-a199-bac1-86b0-0530e177fb54", 
"Beautiful Day", "3ccd6876-dce0-4974-aede-22aa15ad38af", 
"Midnight Oil", "4792e860-2c0f-5686-9313-845d846518ef"];

//
//Functions
start_listener(key toucher){
    llListenRemove(listener);//Clear up before we start
    CHANNEL = (integer)llFrand(-6000-(-900000));//make a random channel
    listener = llListen(CHANNEL,"",toucher,"");//Set the listener
}

stop_listener(){
    llListenRemove(listener);//remove the listener
}

Menu(key id){
    start_listener(id);
    string msg=texture_message;
    llDialog(id,msg,menu_options,CHANNEL);
}

do_texture(string msg, key id){
    integer x = llListFindList(textures,[msg]);
    llSetLinkPrimitiveParamsFast(LINK,[PRIM_TEXTURE,FACE,llList2String(textures,x+1), <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0]);
    Menu(id);
    
}

default
{
    state_entry(){
        integer x = llGetListLength(textures);
        integer y;
        while (y < x)
        {
            menu_options+=[llList2String(textures,y)];
            y+=2;
        }
        menu_options+=["Close"];//This button does nothing but stop further dialog boxes
    }

    touch_start(integer total_number){
        Menu(llDetectedKey(0));
    }
    
    listen(integer CH, string name, key id, string msg)
    {
        //llOwnerSay(msg);
        stop_listener();//always close the listener
        if(msg!="Close"){
            do_texture(msg,id);
        }
    }
}
