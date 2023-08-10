//Rotations required to flip between letters and numbers
rotation number_rot=<-0.00000, -0.00000, 1.00000, 0.00000>;
rotation letter_rot=<-0.00000, -0.00000, -0.70711, 0.70711>;

integer COMM = -666;
integer face;

//Checks across grid for input
say_option(vector T)
{
    if(T.y<0.166)
    {
        if(T.x>0.5)
        {
            if(face==1)
            {
                set_numbers();
            }
            else if(face==2)
            {
                set_letters();
            }
        }
        else if(T.x<0.5)
        {
            llSay(COMM,"OUIJA***GOODBYE");
        }
    } 
    
    else if(T.y>0.166&&T.y<0.332)
    {
        if(T.x<0.322)
        {
            llSay(COMM,"OUIJA***NO");
        }
        else if(T.x>0.664)
        {
            llSay(COMM,"OUIJA***YES");
        }
        if(face==1)
        {
            if(T.x<0.664&&T.x>0.498)
            {
                llSay(COMM,"OUIJA***Z");
            }
            else if(T.x>0.322&&T.x<0.498)
            {
                llSay(COMM,"OUIJA***Y");
            }
        }
    }
    else if(T.y>0.332&&T.y<0.498)
    {
        if(face==1)
        {
            if(T.x<0.166)
            {
                llSay(COMM,"OUIJA***S");
            }
            else if(T.x>0.166&&T.x<0.332)
            {
                llSay(COMM,"OUIJA***T");
            }
            else if(T.x>0.332&&T.x<0.498)
            {
                llSay(COMM,"OUIJA***U");
            }
            else if(T.x>0.498&&T.x<0.664)
            {
                llSay(COMM,"OUIJA***V");
            }
            else if(T.x>0.664&&T.x<0.83)
            {
                llSay(COMM,"OUIJA***W");
            }
            else if(T.x>0.83)
            {
                llSay(COMM,"OUIJA***X");
            }
        }
    }
    else if(T.y>0.498&&T.y<0.664)
    {
        if(T.x<0.166)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***M");
            }
        }
        else if(T.x>0.166&&T.x<0.332)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***N");
            }
        }
        else if(T.x>0.332&&T.x<0.498)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***O");
            }
            else if(face==2)
            {
                llSay(COMM,"OUIJA***9");
            }
        }
        else if(T.x>0.498&&T.x<0.664)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***P");
            }
            else if(face==2)
            {
                llSay(COMM,"OUIJA***0");
            }
        }
        else if(T.x>0.664&&T.x<0.83)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***Q");
            }
        }
        else if(T.x>0.83)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***R");
            }
        }
    }
    
    else if(T.y>0.664&&T.y<0.83)
    {
        if(T.x<0.166)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***G");
            }
        }
        else if(T.x>0.166&&T.x<0.332)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***H");
            }
            else if(face==2)
            {
                llSay(COMM,"OUIJA***5");
            }
        }
        else if(T.x>0.332&&T.x<0.498)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***I");
            }
            else if(face==2)
            {
                llSay(COMM,"OUIJA***6");
            }
        }
        else if(T.x>0.498&&T.x<0.664)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***J");
            }
            else if(face==2)
            {
                llSay(COMM,"OUIJA***7");
            }
        }
        else if(T.x>0.664&&T.x<0.83)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***K");
            }
            else if(face==2)
            {
                llSay(COMM,"OUIJA***8");
            }
        }
        else if(T.x>0.83)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***L");
            }
        }
    }
    else if(T.y>0.83)
    {
        if(T.x<0.166)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***A");
            }
        }
        else if(T.x>0.166&&T.x<0.332)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***B");
            }
            else if(face==2)
            {
                llSay(COMM,"OUIJA***1");
            }
        }
        else if(T.x>0.332&&T.x<0.498)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***C");
            }
            else if(face==2)
            {
                llSay(COMM,"OUIJA***2");
            }
        }
        else if(T.x>0.498&&T.x<0.664)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***D");
            }
            else if(face==2)
            {
                llSay(COMM,"OUIJA***3");
            }
        }
        else if(T.x>0.664&&T.x<0.83)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***E");
            }
            else if(face==2)
            {
                llSay(COMM,"OUIJA***4");
            }
        }
        else if(T.x>0.83)
        {
            if(face==1)
            {
                llSay(COMM,"OUIJA***F");
            }
        }
    }
}

set_letters()
{
    llSetRot(letter_rot);
}

set_numbers()
{
    llSetRot(number_rot);
}
default
{
    state_entry()
    {
        set_letters();
    }

    touch_start(integer total_number)
    {
        face=llDetectedTouchFace(0);
        say_option(llDetectedTouchUV(0));
    }
    
    attach(key attached)
    {
        if(attached)
        {
            set_letters();
        }
    }
}
