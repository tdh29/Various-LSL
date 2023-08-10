integer pointer;
integer listener;
integer COMM = -666;

list questions = ["who are you?","who is the best?","what are the lotto numbers?","what are the lottery numbers?"];

list positions =[
"A" ,<-0.35759, 0.01716, 0.03394>,
"B" ,<-0.29512, 0.03525, 0.03394>,
"C" ,<-0.22740, 0.05355, 0.03394>,
"D" ,<-0.16902, 0.07070, 0.03394>,
"E" , <-0.10217, 0.07070, 0.03394>,
"F" , <-0.04282, 0.08192, 0.03394>,
"G" , <0.01918, 0.08192, 0.03394>,
"H" , <0.08424, 0.07553, 0.03394>,
"I" , <0.13571, 0.07553, 0.03394>,
"J" , <0.17834, 0.06489, 0.03394>,
"K" , <0.22043, 0.06489, 0.03394>,
"L" , <0.28197, 0.04287, 0.03394>,
"M" , <0.36041, 0.02189, 0.03394>,
"N" , <-0.38676, -0.11030, 0.03394>, 
"O" , <-0.32352, -0.08291, 0.03394>,
"P" , <-0.26419, -0.05923, 0.03394>,
"Q" , <-0.20360, -0.05222, 0.03394>,
"R" , <-0.14214, -0.04063, 0.03394>,
"S" , <-0.07892, -0.04063, 0.03394>,
"T" , <-0.02328, -0.03021, 0.03394>,
"U" , <0.04196, -0.03021, 0.03394>,
"V" , <0.11128, -0.03189, 0.03394>,
"W" , <0.18883, -0.04648, 0.03394>,
"X" , <0.26730, -0.06048, 0.03394>,
"Y" , <0.33490, -0.08761, 0.03394>,
"Z" , <0.39935, -0.10404, 0.03394>,
"0" , <0.21649, -0.19049, 0.03394>,
"1" , <-0.21590, -0.19049, 0.03394>,
"2" , <-0.17160, -0.19049, 0.03394>,
"3" , <-0.12233, -0.19049, 0.03394>,
"4" , <-0.07207, -0.19049, 0.03394>,
"5" , <-0.02365, -0.19049, 0.03394>,
"6" , <0.02783, -0.19049, 0.03394>,
"7" ,<0.07625, -0.19049, 0.03394>,
"8" , <0.11774, -0.19049, 0.03394>,
"9" , <0.16087, -0.19049, 0.03394>,
"YES" ,<-0.30504, 0.29837, 0.03394>,
"NO" ,<0.29210, 0.29837, 0.03394>,
"HOME" ,<-0.49957, 0.07001, 0.03394>,
"GOODBYE" ,<-0.02568, -0.29559, 0.03394>];

vector default_size_board = <1.2, 0.8, 0.0450>;
vector default_size_pointer = <0.0886674, 0.118084, 0.0201811>;

set_position(string cmd)
{
    integer x = llListFindList(positions,[cmd]);
    if(x!=-1)
    {
        //string tempstring = llList2String(positions,(x+1));
        //llOwnerSay(tempstring);
        vector temp = llList2Vector(positions,(x+1));
        //llOwnerSay((string)temp);
        vector size = llGetScale();
        float tempx = size.x/default_size_board.x;
        //llOwnerSay((string)tempx);
        //llOwnerSay((string)temp.x);
        float tempy = size.y/default_size_board.y;
        float tempz = size.z/default_size_board.z;
        tempx = temp.x*tempx;
        //llOwnerSay((string)tempx);
        tempy = temp.y*tempy;
        tempz = temp.z*tempz;
        llSetLinkPrimitiveParamsFast(pointer,[PRIM_POS_LOCAL,<tempx,tempy,tempz>]);
    }
}

check_links()
{
    integer x;
    integer y = llGetNumberOfPrims();
    for(x=0;x<=y;x++)
    {
        if(llGetLinkName(x)=="pointer")
        {
            pointer = x;
        }
    }
}

stop()
{
    llListenRemove(listener);
    llSetTimerEvent(0);
}

random_answer()
{
    float rand = llFrand(1);
    if(rand<0.5)
    {
        set_position("NO");
    }
    else if(rand>=0.5)
    {
        set_position("YES");
    }
}

satan()
{
    set_position("6");
    llSleep(1);
    set_position("HOME");
    llSleep(1);
    set_position("6");
    llSleep(1);
    set_position("HOME");
    llSleep(1);
    set_position("6");
    llSleep(1);
    set_position("HOME");
}

you_are()
{
    set_position("Y");
    llSleep(1);
    set_position("HOME");
    llSleep(1);
    set_position("O");
    llSleep(1);
    set_position("HOME");
    llSleep(1);
    set_position("U");
    llSleep(1);
    set_position("HOME");;
    llSleep(1);
    set_position("A");
    set_position("HOME");;
    llSleep(1);
    set_position("R");
    set_position("HOME");;
    llSleep(1);
    set_position("E");
}

lotto()
{
    set_position("1");
    llSleep(1);
    set_position("HOME");
    llSleep(1);
    set_position("2");
    llSleep(1);
    set_position("7");
    llSleep(1);
    set_position("HOME");
    llSleep(1);
    set_position("3");
    llSleep(1);
    set_position("9");
    llSleep(1);
    set_position("HOME");
    llSleep(1);
    set_position("1");
    llSleep(1);
    set_position("7");
    llSleep(1);
    set_position("HOME");
    llSleep(1);
    set_position("6");
    llSleep(1);
    set_position("HOME");
    llSleep(1);
    set_position("4");
    llSleep(1);
    set_position("0");
}

default
{
    state_entry()
    {
        check_links();
        set_position("HOME");
        llListen(COMM,"","","");
    }

    touch_start(integer total_number)
    {
        set_position("HOME");
        llInstantMessage(llDetectedKey(0),"Please ask the spirits your question in main chat, may the ghosts of Lindens past be kind to you");
        listener = llListen(0,llDetectedName(0),llDetectedKey(0),"");
        llSetTimerEvent(300);
    }
    
    listen(integer chan, string name, key id, string msg)
    {
        if(chan==COMM)
        {
            list line = llParseString2List(msg,["***"],[]);
            if(llList2String(line,0)=="OUIJA")
            {
                set_position(llList2String(line,1));
            }
        }
        else if(chan==0)
        {
            stop();
            msg = llToLower(msg);
            if(msg=="who are you?")
            {
                satan();
            }
            if(msg=="who is the best?")
            {
                you_are();
            }
            if(msg=="what are the lotto numbers?"||msg=="what are the lottery numbers?")
            {
                lotto();
            }
            else if(llListFindList(questions,[msg])==-1)
            {
                random_answer();
            }
        }
    }
    
    timer()
    {
        stop();
    }
    
    on_rez(integer rez)
    {
        llResetScript();
    }
}


