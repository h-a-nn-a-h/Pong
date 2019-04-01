%pong

%reference for animation function for loop (lines 788-801):
%https://www.mathworks.com/help/matlab/ref/hgtransform.html

%opens figure wondow for title screen
figure1=figure('MenuBar','none','ToolBar','none',...
    'units','normalized','position',[0 0 1 1]);

%button group for radio buttons to select difficulty
buttonboss=uibuttongroup('Position',[0 0 0.5 0.6],...
    'BorderWidth',0,'BackgroundColor',[0 0.46073 0.85552]);

%first radio button in button group- easy
easy=uicontrol(buttonboss,'style','radiobutton','string','easy',...
    'fontname','arial black','units','normalized',...
    'position',[0.15,0.470,0.9,0.30],'BackgroundColor',[0 0.46073 0.85552],...
    'ForeGroundColor',[0.97265 .58472 .061029],'FontSize',35);

%second radio button in button group- medium
medium=uicontrol(buttonboss,'style','radiobutton','string','medium',...
    'fontname','arial black','units','normalized',...
    'position',[0.15,0.24,0.9,0.30],'BackgroundColor',[0 0.46073 0.85552],...
    'ForeGroundColor',[0.97265 .58472 .061029],'FontSize',35);

%third radio button in button group- difficult
hard=uicontrol(buttonboss,'style','radiobutton','string','difficult',...
    'fontname','arial black','units','normalized',...
    'position',[0.15,0.01,0.9,0.30],'BackgroundColor',[0 0.46073 0.85552],...
    'ForeGroundColor',[0.97265 .58472 .061029],'FontSize',35);

%title for difficulty buttons-just text box with blue background
uicontrol('style','text','string','Choose Difficulty','units','normalized',...
    'position',[0.02,0.47,0.47,0.1],'fontsize',45,...
    'BackgroundColor',[0 0.46073 0.85552],'fontname','arial black',...
    'ForeGroundColor',[0.97265 .58472 .061029]);

%player names background
uicontrol('style','text','BackGroundColor',[0.9 0.06 0.3],...
    'units','normalized','position',[0.5 0.12 0.5 0.48]);

%Prompts player 1 to enter name-static text box
uicontrol('style','text','units','normalized','position',[0.5 0.44 0.3 0.1],...
    'string','Player 1:','BackGroundColor',[0.9 0.06 0.3],'fontsize',45,...
    'foregroundcolor',[0 0.54 0.22],'fontname','arial black');

%player 1 enters name in editable text box
player1name=uicontrol('style','edit','units','normalized',...
    'position',[0.8 0.44 0.15 0.1],'fontsize',45,'string','Player 1');

%Prompts player 2 to enter name-static text box
uicontrol('style','text','units','normalized',...
    'position',[0.5 0.24 0.3 0.1],'string','Player 2:',...
    'BackGroundColor',[0.9 0.06 0.3],'fontsize',45,...
    'foregroundcolor',[0 0.54 0.22],'fontname','arial black');

%player 2 enters name in editable text box
player2name=uicontrol('style','edit','units','normalized',...
    'position',[0.8 0.24 0.15 0.1],'fontsize',45,'string','Player 2');

%main title-static text box
uicontrol('style','text','units','normalized','position',[0 0.75 1 0.25],...
    'backgroundcolor',[.977 .959 .049],...
    'foregroundcolor',[0.79892 0.25362 0.62392],'string','MATLAB PONG',...
    'fontsize',100,'fontname','arial black');

%instructions on how to play-static text box
instruction=uicontrol('style','text',...
    'string','Player 1 on the left uses w and s to move up and down. Player 2 on the right uses u and j to move up and down. Use your slider to prevent the ball from hitting your side. The first player to 3 points wins!',...
    'Backgroundcolor',[0 0.907 0.573],'units','normalized',...
    'position',[0 0.59 1 0.2],'fontsize',28,'fontname',...
    'arial black','foregroundcolor',[0.97 0.37 0.41]);

%pushbutton to start-callback is buttonfunc, value of each difficulty radio
%button and players names are passed to buttonfunc
start_button=uicontrol('style','pushbutton',...
    'callback',{@buttonfunc,easy,medium,hard,player1name,player2name},...
    'units','normalized','fontname','arial black',...
    'position',[0.5 0 0.5 0.2],'Backgroundcolor',[0.9956 0.446 0.205],...
    'string','START','fontsize',60);



%callback to start button-stores a value in variable difficulty
%corresponding to the selected difficulty level, stores players name in
%variables.
function[difficulty,play1,play2]=...
    buttonfunc(~,~,easy,medium,hard,player1name,player2name)
%get the value from each radio button
one=get(easy,'value');
two=get(medium,'value');
three=get(hard,'value');
%the selected radio button will have a value of 1-then value is stored in
%difficulty variable
if one==1
    difficulty=1;
elseif two==1
    difficulty=2;
elseif three==1
    difficulty=3;
end
%get the string from player 1 editable text box
play1=get(player1name,'String');
%store in original variable name to keep it consistent
player1name=play1;
%if the string is empty, it will be 'player 1'
if isempty(play1)
    player1name='player 1';
end
%get the string from player 2 editable text box
play2=get(player2name,'String');
%store in original variable name to keep it consistent
player2name=play2;
%if the string is empty, it will be 'player 2'
if isempty(player2name)
    player2name='player 2';
end
%function that opens playing screen, passes difficulty level, and player
%names.
pong50_2(difficulty,player1name,player2name)

end



%function that opens playing screen-accepting variables for difficulty
%level, player names.
function pong50_2(difficulty, player1name,player2name)

%setting up figure window for playing screen
figure2=figure('units','normalized','position',[0 0 1 1],...
    'Color',[0, 0.75, 0.75],'ToolBar','none','MenuBar','none');
get(figure2)
%right slider
sliden1=uicontrol('style','slider','units','normalized',...
    'position',[0.0932 0.047 0.02 0.825],'Max',5,'Min',0,...
    'tag','slident','BackgroundColor',[0, 0.75, 0.75],...
    'ForegroundColor',[0.6350, 0.0780, 0.1840],'Value',2.5);

%three text boxes that cover up bottom, top, and left side of slider so
%that the only part that can be seen is the sliding part.
uicontrol('style','text','BackgroundColor',[0, 0.75, 0.75],...
    'units','normalized','position',[0.0932 0.03 0.02 0.06]);
uicontrol('style','text','BackgroundColor',[0, 0.75, 0.75],...
    'units','normalized','position',[0.0932 0.829 0.02 0.07]);
uicontrol('style','text','BackgroundColor',[0, 0.75, 0.75],...
    'units','normalized','position',[0.0932 0.05 0.001 0.79]);

%left slider
sliden2=uicontrol('style','slider','units','normalized',...
    'position',[0.888 0.047 0.02 0.825],'Max',5,'Min',0,'tag','slident',...
    'BackgroundColor',[0, 0.75, 0.75],...
    'ForegroundColor',[0.6350, 0.0780, 0.1840],'Value',2.5);

%three text boxes that cover up bottom, top, and left side of slider so
%that the only part that can be seen is the sliding part.
uicontrol('style','text','BackgroundColor',[0, 0.75, 0.75],...
    'units','normalized','position',[0.888 0.03 0.02 0.06]);
uicontrol('style','text','BackgroundColor',[0, 0.75, 0.75],...
    'units','normalized','position',[0.888 0.829 0.02 0.07]);
uicontrol('style','text','BackgroundColor',[0, 0.75, 0.75],...
    'units','normalized','position',[0.907 0.05 0.001 0.79]);

%limiting name 1 length to 13 characters-where name is displayed during and
%after game have a maximum length
name1=upper(player1name);
if length(name1)>13
    name1=name1(1:13);
end

%finding length of name, to format textbox
width=length(name1);
%box that displays player 1 name, width of textbox depends on name
%length-since the length of the name is not always the same
uicontrol('style','text','units','normalized',...
    'position',[0.05 0.9 0.015*width-0.0015*width 0.04],'string',name1,...
    'fontsize',20,'Backgroundcolor',[0.99 0.97 0.22]);

%limiting name 2 length to 13 characters-where name is displayed during and
%after game have a maximum length
name2=upper(player2name);
if length(name2)>13
    name2=name2(1:13);
end

%finding length of name, to format textbox
width2=length(name2);
%box that displays player 1 name, width of textbox depends on name
%length-since the length of the name is not always the same
uicontrol('style','text','units','normalized','position',...
    [1-(0.05+0.015*width2-0.0015*width2) 0.9 0.015*width2-0.0015*width2 0.04],...
    'string',name2,'fontsize',20,'Backgroundcolor',[0.7 .32 .533]);

%displays player 1 score
playeronescore=uicontrol('style','text','units','normalized',...
    'position',[0.007 0.7 0.08 0.05],'string','Score: 0',...
    'fontsize',20,'backgroundcolor',[0 0.75 0.75]);

%displays player 2 score
playertwoscore=uicontrol('style','text','units','normalized',...
    'position',[0.909 0.7 0.08 0.05],'string','Score: 0',...
    'fontsize',20,'backgroundcolor',[0 0.75 0.75]);

%keypressfcn callback to figure2-when keys are pressed, sliders move
set(figure2,'keypressfcn',{@sliderscallback,sliden1,sliden2})


%setting up the plot in the figure window
plot(0,0);
%plot color
set(gca,'Color',[0.83336, 0.40363, 0.39018]);
%plot axes- 5 by 5, plus 0.0325(left/right) and 0.06(top/bottom) to
%accomodate ball-actual position of the ball wehn it bounces it not at the
%edge of the axes
axis([-0.0325,5.0325,-0.06,5.06]);
%no xlabel ticks
set(gca,'xtick',[]);
%no y label ticks
set(gca,'ytick',[]);
%set size and position of the plot
set(gca,'units','normalized','position',[0.1125 0.09 0.775 0.74])
%hold on for plot to keep these ? conitions throughout the script
hold on

%countdown function
threetwoone

%part of the game where the ball moves-after the 3 2 1. passing
%difficulty,player names, and player score uicontrols- so they cal be changed when
%someone gets a point. also sliders-the value will be used to determine
%whether or not the ball hits the slider
pong38_movement2(sliden1,sliden2,difficulty,player1name,player2name,playeronescore,playertwoscore)

end


%function that causes sliders to move when certain keys are
%pressed-keypressfunction for figure window, sliders are passed to this
%function so that their values can be changed when a key is pressed.
function[]=sliderscallback(figure2,~,sliden1,sliden2)
%switch staement for charr- variable in which the last key that was pressed
%in the figure window is stored. 
%this command gets the current character property of the figure and stores
%in it a variable
charr=get(figure2,'currentcharacter');
switch charr
    %if the last variable pressed was 'u', slider on the left will move up,
    %unless it is at its maximum value 
    case 'u'
        sliderval=get(sliden2,'value');
        if sliderval<=4.75
            newsliderval=sliderval+0.25;
            set(sliden2,'value',newsliderval);
        end
    case 'j'
        sliderval=get(sliden2,'value');
        if sliderval>=0.25
            newsliderval=sliderval-0.25;
            set(sliden2,'value',newsliderval);
        end
    case 'w'
        sliderval=get(sliden1,'value');
        if sliderval<=4.75
            newsliderval=sliderval+0.25;
            set(sliden1,'value',newsliderval);
        end
    case 's'
        sliderval=get(sliden1,'value');
        if sliderval>=0.25
            newsliderval=sliderval-0.25;
            set(sliden1,'value',newsliderval);
        end
        
end

end


%function that displays 3 2 1 before the game starts
function threetwoone()

%pause at the start becuase the window sometimes takes a second to load,
%want 3 to be displayed for the same amount of time as the others
pause(1.5);
%x and y values that will be patched to make a 3
x=0.001*[637 637 841 1121 1421 1501 1489 1381 1201 1009 889 889 1161 1381 1465 1453 1341 1113 865 705 705 973 1273 1581 1777 1857 1833 1709 1565 1773 1889 1909 1813 1561 1265 941 721]+1.2;
y=0.001*(2400*(ones(1,37))-[1941 1641 1717 1777 1697 1565 1397 1293 1253 1257 1257 949 929 825 693 537 461 457 541 605 300 161 125 189 353 585 769 953 1057 1173 1341 1525 1769 1977 2065 2061 2009])+01.1;
%patching x and y values to make a shape
patch(x,y,[0 .508 .801],'edgecolor',[0 .508 .801])
%pausing for a second before the next value is displayed
pause(1);
%clearing the axes
cla;

%x and y values that will be patched to make a 2
x=0.00085*[541 581 669 769 881 1049 1181 1329 1377 1385 1345 1257 1161 1081 1045 1045 537 553 621 689 817 993 1197 1457 1641 1793 1865 1861 1769 1617 1445 1313 1197 1941 1941]+1.4;
y=0.001*(2400*ones(1,35)-[2117 1825 1641 1493 1329 1169 1041 909 817 681 597 561 569 633 733 873 873 645 473 369 265 181 157 193 285 437 657 861 1105 1273 1421 1561 1717 1717 2117])+1.2;
%patching x and y values to make a shape
patch(x,y,[0.97 0.40 0.12],'edgecolor',[0.97 0.40 0.12])
%pausing for a second before the next value is displayed
pause(1);
%clearing the axes
cla;

%x and y values that will be patched to make a 2
x=0.0006*[509 509 905 905 521 521 1405 1405 1817 1817]+1.7;
y=0.001*((2400*ones(1,10))-[2133 1721 1721 677 765 353 165 1721 1721 2133])+1.2;
%patching x and y values to make a shape
patch(x,y,[0 0.62 0.075],'edgecolor',[0 0.62 0.075]);
%pausing for a second before the next value is displayed
pause(1);
%clearing the axes
cla;
end









function pong38_movement2(sliden,sliden2,difficulty,player1name,player2name,playeronescore,playertwoscore)
%setting the variables for eaxh player's score to zero
leftscore=0;
rightscore=0;
%while neither plaer has reached 3 points, code will restart with the ball
%in the middle after a player has missed
while leftscore<3 && rightscore<3
    
    %x and y coordinates, which will be patched to make the shape of the
    %ball
    x=0.0375*[-1,-sqrt(3)/2,-1/2,0,1/2,sqrt(3)/2,1,sqrt(3)/2,1/2,0,-1/2,-sqrt(3)/2];
    y=0.07*[0,-1/2,-sqrt(3)/2,-1,-sqrt(3)/2,-1/2,0,1/2,sqrt(3)/2,1,sqrt(3)/2,1/2];
    %shape will be the handle of the transform object (ball)
    shape=hgtransform;
    %patching x and y coordintes to make a ball, parent is 'shape'
    patch(x,y,'k','Parent',shape)
    
    %setting the initial position of the ball
    position=[2.5,2.5,0];
    %switch statement for difficulty; the difficulty selected corresponds
    %to a speed of the ball (when ymove=0)
    switch difficulty
        case 1
            speed=0.02;
        case 2
            speed=0.04;
        case 3
            speed=0.05;
    end
    
    %ymove is the movement of the ball in the y direction over the movement
    %in the x direction (slope). This command makes the starting ymove a
    %random number between -0.3 and 0.3
    ymove=0.6*rand-0.3;
    
    %x move is -1 if the ball is moving left, 1 if the ball is moving right.
    %switch case to randomly determine if xmove will be negative or
    %positive (theres a 50/50 change that (rand-0.5) will be positive or
    %negative)
    switch sign(rand-0.5)
        case 1
            xmove=1;
            
        case -1
            xmove=-1;
    end
    %in function ballmove (line ) cspeed is used as the increment for the
    %for loop, so it dteermines how fast the ball moves. If speed was
    %constant for any slope, larger slopes would travel faster; the increment
    %refers to the distance in the x direction that is travelled for each
    %execution of the for loop. cspeed takes into account ymove and xmove,
    %and the dimensions of the plot on the screen to make the speed the
    %same as it would be for a ball travelling with ymove=0
    
    cspeed=speed*cos(atan(5.5*ymove/(xmove*10.5)));
    
    %this for loop is the same as function ball move (line ), except before
    %the ball starts moving, it pauses for 0.6 seconds- not using the function since it should
    %only does this at the beginning of the round
    for xdistance=(0:cspeed:2.5)
        %setting the translation matrix for the ball
        movement=[1 0 0 xmove*xdistance+position(1); 0 1 0 ymove*xdistance+position(2); 0 0 1 0; 0 0 0 1];
        %causeing ball to pause in the middle before moving
        if xdistance==cspeed
            pause(0.6);
        end
        %setting the matrix of the transform object 'shape' to translate it
        set(shape,'Matrix',movement);
        %drawnow: position of the ball will be updated before script continues
        drawnow
    end
    
    %for loop will usually not go to exactly tmax, it will go to the largest
    %value, in increments of cspeed, before passing tmax. next two commands
    %assign what the exact position after the translation needs to be to the
    %position variable. This doesnt change the position of the transform
    %object, but the object will be assigned this position at the beginning
    %of the next transformation. The difference between the actual position
    %of the object and the variable position is very small.
    newposition=position+[xmove*2.5,ymove*2.5,0];
    position=newposition;
    
    %while loop with if statements; while score=1 (ball hasnt touched right or
    %left edge without slider) ball will continue to bounce around
    score=1;
    while score==1
        
        %%%%%%%%%%%%%%%%%CONDITIONS FOR CORNER BOUNCE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %if the ball hits and of the corners
        if (position(1)==0 &&(position(2)==5 || position(2)==0))||(position(1)==5 &&(position(2)==5 || position(2)==0))
            
            %Slider has range set at 0.5-lower bound is actual value minus 0.25,
            %upperbound is actual value plus 0.25. Values are stored in variables to
            %determine if the slider hit the ball.
            lowerbound=(get(sliden2,'Value')-0.25);
            upperbound=(get(sliden2,'Value')+0.249);
            lowerbound2=(get(sliden,'Value')-0.25);
            upperbound2=(get(sliden,'Value')+0.249);
            
            %if the ball hits the slider on the the side that it hits
            if (position(1)==0 && position(2)<=upperbound2 && position(2)>lowerbound2) || (position(1)==5 && position(2)<=upperbound && position(2)>lowerbound)
                
                %instructions for bottom left corner- determining the speed the
                %ball should move at, the slope (xmove and ymove).
                if position(1)==0 && position(2)==0
                    xmove=1;
                    ymove=1.25;
                    cspeedleft=speed*0.8;
                    cspeed=cspeedleft;
                    
                    % top left corner
                elseif position(1)==0 && position(2)==5
                    xmove=1;
                    ymove=-1.25;
                    cspeedleft=speed*0.8;
                    cspeed=cspeedleft;
                    
                    %bottom right corner
                elseif position(1)==5 && position(2)==0
                    xmove=-1;
                    ymove=1.25;
                    cspeedright=speed*0.8;
                    cspeed=cspeedright;
                    
                    %top right corner
                elseif position(1)==5 && position(2)==5
                    xmove=-1;
                    ymove=-1.25;
                    cspeedright=speed*0.8;
                    cspeed=cspeedright;
                end
                
                %finding the distance, in the x direction, that the ball will
                %move before hitting the wall opposite to the one it is at
                tmax=abs(5/ymove);
                if tmax>5
                    tmax=5;
                end
                
                %in the case that the ball would hit a bottom or top wall before
                %the opposite wall
                if position(2)==5
                    bottom=5-tmax*abs(ymove)/abs(xmove);
                    if bottom<0
                        tmax=abs(5*xmove/ymove);
                    end
                elseif position(2)==0
                    top=tmax*ymove/abs(xmove);
                    if top>5
                        tmax=abs(5*xmove/ymove);
                        
                    end
                end
                
                %executing ballmove function, passing relevant variables as
                %arguments. Output is final position of the ball after the
                %translation, so the condition that is met next can be determined
                %and the next translation can occur
                position=ballmove(cspeed,tmax,xmove,ymove,position,shape);
                
            else
                %if the ball is missed, a point is awarded to the other player.
                %the direction of xmove ddetermines which player missed. The
                %string in the uicontrol text displaying the scores is updated
                if xmove<0
                    valz=get(playertwoscore,'string');
                    rightscore=1+str2double(valz(8));
                    newvalz="Score: "+string(rightscore);
                    set(playertwoscore,'String',newvalz);
                elseif xmove>0
                    valz=get(playeronescore,'string');
                    leftscore=1+str2double(valz(8));
                    newvalz="Score: "+string(leftscore);
                    set(playeronescore,'String',newvalz);
                end
                
                %ball leave screen excecutes if the ball is missed, instead of
                %stopping, it loks like the ball leaves the screen.
                ballleavescreen(speed,position,xmove,ymove,shape);
                score=0;
            end
            
            %%%%%%%%%%%%%%%%BALL HITS RIGHT WALL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif position(1)==5
            
            %finding the position of the slider, and the bounds the ball
            %needs to hit within at the moment the ball hits
            lowerbound=(get(sliden2,'Value')-0.25);
            upperbound=(get(sliden2,'Value')+0.249);
            
            %dividing the slider into segments
            bound=zeros(1,6);
            for i=1:6
                bound(i)=lowerbound+0.1*(i-1);
            end
            
            %find which segment slider hits-starting at bottom
            for i=1:5
                if (position(2)>bound(i))&&(position(2)<=bound(i+1))
                    segment=i;
                end
            end
            
            %if slider catches ball
            if position(2)<=upperbound && position(2)>lowerbound
                
                %incase ymove becomes an illegal value, it will just go
                %back the its value before the bounce-stored in ymovetemp
                ymovetemp=ymove;
                
                %bouncing off right wall; x direction reversed
                xmove=-xmove;
                
                %adding small random number to ymove-changes slope. Number
                %depends in which section of the slider was hit. It is
                %meant to be like a curved surface
                switch segment
                    case 1
                        ymove=ymove-(0.2*rand+0.6);
                    case 2
                        ymove=ymove-(0.15*rand+0.3);
                    case 4
                        ymove=ymove+(0.15*rand+0.3);
                    case 5
                        ymove=ymove+(0.2*rand+0.6);
                end
                
                %if ymove is too steep changes to 2 or -2. if ymove is 0
                %(or close to zero) ymove increses to 0.1 In later
                %equations, things are divided into ymove, so it cant be
                %zero.
                if ymove>2
                    ymove=ymovetemp;
                elseif ymove<-2
                    ymove=ymovetemp;
                elseif ymove<0.001 && ymove>-0.001
                    ymove=ymovetemp;
                end
                %tmax-distance travelled by ball in x directon- 2 cases, when ball is
                %travelling upwards, or downwards- this if statement determines tmax
                %in the case that the ball hits a bottom or top wall.
                if ymove>0
                    tmax=(5-position(2))/ymove;
                else
                    tmax=-position(2)/(ymove);
                end
                
                %if ball needs to travel  to a negative x value to
                %bounce, it will bounce off left wall before hitting the
                %top or bottom. tmax is reassigned a value of 5
                if tmax>5
                    tmax=5;
                end
                
                
                %cspeed is the  increment in the animation for loop, in the
                %funcion ballmove, that makes the ball look like it's
                %moving the speed associated with the level- the slope and
                %dimensions of the screen need to be taken into account in
                %order to find cspeed. For different slopes, there are
                %different cspeeds, but the ball appears to be moving at
                %the same speed for every translation.
                cspeedright=speed*cos(atan(5.5*ymove/(xmove*10.5)));
                cspeed=cspeedright;
                
                %function that animates the ball is executed. The arguments
                %determine how the ball moves, except shape, which is the
                %transform object. THe output is the final position of the
                %ball.
                position=ballmove(cspeed,tmax,xmove,ymove,position,shape);
            else
                
                %if ball is missed by right side
                %ballleavescreen function translates the ball past the edge
                %of the plot, so it looks like its passing the wall.
                ballleavescreen(speed,position,xmove,ymove,shape)
                
                %0 stored in score the end while loop
                score=0;
                
                %changing the score
                valz=get(playeronescore,'string');
                leftscore=1+str2double(valz(8));
                newvalz="Score: "+string(leftscore);
                set(playeronescore,'String',newvalz);
            end
            
            %%%%%%%%%%%%%%%%BALL HITS LEFT WALL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %pretty much the same as when the ball hits the left side.
        elseif position(1)==0
            
            lowerbound2=(get(sliden,'Value')-0.25);
            upperbound2=(get(sliden,'Value')+0.249);
            
            bound2=zeros(1,6);
            for i=1:6
                bound2(i)=lowerbound2+0.1*(i-1);
            end
            
            for i=1:5
                if (position(2)>bound2(i))&&(position(2)<=bound2(i+1))
                    segment=i;
                end
            end
            
            if position(2)<=upperbound2 && position(2)>lowerbound2
                
                xmove=-xmove;
                ymovetemp=ymove;
                
                switch segment
                    case 1
                        ymove=ymove-(0.2*rand+0.6);
                    case 2
                        ymove=ymove-(0.15*rand+0.3);
                    case 4
                        ymove=ymove+(0.15*rand+0.3);
                    case 5
                        ymove=ymove+(0.2*rand+0.6);
                end
                
                if ymove>2
                    ymove=ymovetemp;
                elseif ymove<-2
                    ymove=ymovetemp;
                elseif ymove<0.001 && ymove>-0.001
                    ymove=ymovetemp;
                end
                
                if ymove>0
                    tmax=(5-position(2))/ymove;
                else
                    tmax=-position(2)/ymove;
                end
                if tmax>5
                    tmax=5;
                end
                
                cspeedleft=speed*cos(atan(5.5*ymove/(xmove*10.5)));
                cspeed=cspeedleft;
                position=ballmove(cspeed,tmax,xmove,ymove,position,shape);
                
            else
                ballleavescreen(speed,position,xmove,ymove,shape)
                
                score=2;
                
                valz=get(playertwoscore,'string');
                rightscore=1+str2double(valz(8));
                newvalz="Score: "+string(rightscore);
                set(playertwoscore,'String',newvalz);
            end
            
            %%%%%%%%%%%%%%%%BALL HITS TOP WALL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %instead of an exact value to determine if the ball hit the
            %top wall, a small range is used; If a value is used (position(2)=5)
            %sometimes, the y position of the ball when it hit the top would be
            %+/- 5.0000, which caused the ball to stop since it did not
            %meet any conditions in the if statement. The range fixed it,
            %and does not have any other effects on the ball's movement.
        elseif position(2)>=4.9999 && position(2)<=5.0001
            
            % ymove is reversed, hitting a top or bottom wall
            ymove=-ymove;
            
            %finding tmax-the x distance needed to travel for this
            %transaltion. This if statement determines tmax if the ball
            %will hit either the left or right wall next.
            if xmove>0
                tmax=(5-position(1));
            elseif xmove<0
                tmax=position(1);
            end
            
            %If the ball is going to bounce off of the top wall and hit the
            %bottom wall, a different tmax is needed. This would occur if
            %the tmax assigned in the previous if statement made the y
            %position of the ball at tmax less than zero.
            bottom=5-tmax*abs(ymove)/abs(xmove);
            if bottom<0
                tmax=abs(5*xmove/ymove);
            end
            
            %slope does not change, so cspeed does not need to change, should
            %just be equal to the cspeed determined at the wall it just
            %bounced off of.
            if xmove>0
                cspeed=cspeedleft;
            else
                cspeed=cspeedright;
            end
            
            %executing function that animates the ball, output of the
            %function is the new position of the ball.
            position=ballmove(cspeed,tmax,xmove,ymove,position,shape);
            
            
            %%%%%%%%%%%%%%%%BALL HITS BOTTOM WALL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %pretty much the same as when the ball hits the top wall
        elseif position(2)>=-0.0001 && position(2)<=0.0001
            
            ymove=-ymove;
            if xmove>0
                tmax=5-position(1);
            elseif xmove<0
                tmax=position(1);
            end
            
            top=tmax*ymove/abs(xmove);
            if top>5
                tmax=abs(5*xmove/ymove);
            end
            
            if xmove>0
                cspeed=cspeedleft;
            else
                cspeed=cspeedright;
            end
            position=ballmove(cspeed,tmax,xmove,ymove,position,shape);
        end
    end
    
    %clears the transform of object from the plot after while loop
    %ends-when the ball hit the left or right wall without a slider
    cla;
    %pauses for a second before next round starts
    pause(1.2);
    
end

%stores a string of the winners name in a variable winner
if leftscore==3
    winner=string(upper(player1name));
else
    winner=string(upper(player2name));
end
if length(winner)>14
    winner=winner(1:14);
end

%displays the winner in text box
uicontrol('style','text','units','normalized','position',[0.3 0.26 0.4 0.4],...
    'backgroundcolor',[0 0.85 0.35]);
uicontrol('style','text','units','normalized',...
    'position',[0.3 0.42 0.4 0.2],'string',winner,...
    'fontsize',50,'backgroundcolor',[0 0.85 0.35]);
uicontrol('style','text','units','normalized',...
    'position',[0.3 0.32 0.4 0.2],'string','WINS!',...
    'fontsize',50,'backgroundcolor',[0 0.85 0.35]);
%pushbutton that closes the playing screen, returns to title screen
uicontrol('style','pushbutton','units','normalized',...
    'position',[0.42 0.29 0.16 0.09],'string','Quit',...
    'fontsize',20,'callback',@quiter);

end


%function that makes the ball move after bouncing, after
%the distance in the x direction it needs to travel, the speed, and the
%slope (ymove an xmove) have been defined.
%the for loop in this function is based off of a code from mathworks
%documentation, link is at the start of the script.
function[position]=ballmove(cspeed,tmax,xmove,ymove,position,shape)
%for loop- will move the hgtransform object 'shape'
for xdistance=(0:cspeed:tmax)
    %setting the transformation matrix for 'shape' to translate it
    %xmove*xdistance in the x direction, and ymove*xdistance in the
    %y direction, from its orgininal position (start of for loop)
    movement=makehgtform('translate',[xmove*xdistance+position(1) ymove*xdistance+position(2) 0]);
    %assigning 'movement' matrix to the matrix property of the hgtransform
    %object-each time the loop is executed, the position of 'shape' will
    %move to its new position defined by 'movement'
    set(shape,'Matrix',movement);
    %drawnow causes the new position of 'shape' to be updated before
    %continuing. without drawnow, there would be no animation; 'shape'
    %would just appear at its final position
    drawnow
end
%for loop will usually not go to exactly tmax, it will go to the largest
%value, in increments of cspeed, before passing tmax. next two commands
%assign what the exact position after the translation needs to be to the
%position variable.
newposition=position+[xmove*tmax,ymove*tmax,0];
position=newposition;
end

%function that executes when the ball is missed by a slider-instead of just
%disappearing, this makes it look like the ball is actually leaving the
%screen
function ballleavescreen(speed,position,xmove,ymove,shape)
for xdistance=(0:1.2*speed:0.2)
    movement=[1 0 0 position(1)+xmove*xdistance; 0 1 0 position(2)+ymove*xdistance; 0 0 1 0; 0 0 0 1];
    set(shape,'Matrix',movement);
    drawnow
end
end

%callback function to 'quit' push button at the end-closes playing screen,
%returns to title screen-game can be played again
function quiter(~,~)
close
clc
end





