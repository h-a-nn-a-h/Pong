
clearvars
clc;
fileID = fopen('newphrases.txt');
for i=2:1722
phrase{i}=fgetl(fileID);
end
fclose(fileID);
rng('shuffle')
number=randi([1 1721]);
word=lower(phrase{number});


leggy=length(word);
for i=1:leggy;
    wordo{i}=double(word(i));
end

if leggy>=20
    diffi=1;
else 
    diffi=2;
end
    



elements=[];
for i=1:leggy
    if wordo{i}==32;
        elements=[elements i];
    end
end
[m,n]=size(elements);
spaces=double(logical(n));

switch spaces
    case 1
leggy2=length(elements)+1;
wordlengths=[elements(1) diff(elements) leggy-elements(leggy2-1)+1]-1;
wordnum=length(wordlengths);
wordandspace=wordlengths+1;

    
    counter2=2;
    counter1=0;
    lines=[0];
    exit2=0;
    totalwordcount=0;
    while exit2==0
    exit=0;
    wordsum=0;
    while wordsum<=18 && exit==0
        counter1=counter1+1;
        wordsum=sum(wordandspace(totalwordcount+1:counter1))-1;
        if counter1>=wordnum
            exit=1;
        end
    end
    if wordsum>18 || counter1~=wordnum
        counter1=counter1-1;
    end
    counter2=counter1-totalwordcount;
   
    totalwordcount=totalwordcount+counter2;
    
    lines=[lines counter2];
        if totalwordcount>=wordnum
        exit2=1;
    end
    
    end
    
    linespaces=lines(1:end,2:end);
    
        
    case 0
        linespaces=[1];
        wordnum=1;
        wordlengths=[leggy];
        if leggy>35
            linespaces=[1 1 1];
            wordlengths=[17 17 leggy-34];
        elseif leggy>18
            linespaces=[1 1];
            wordlengths=[17 leggy-17];
        
        end
            
end

figgy=figure('MenuBar','none','ToolBar','none','units','normalized','position',[0 0 1 1]);
annotation('line',[0.06 0.26],[0.2 0.2],'linewidth',3);
annotation('line',[0.16 0.16],[0.2 0.9],'linewidth',3);
annotation('line',[0.16 0.29],[0.9 0.9],'linewidth',3);
annotation('line',[0.29 0.29],[0.9 0.8],'linewidth',3);


linescells{1}=wordlengths(1:linespaces(1));
for i=2:length(linespaces)
    linescells{i}=wordlengths(sum(linespaces(1:i-1))+1:(sum(linespaces(1:i-1))+linespaces(i)));
end
            
numlines=length(linescells);
occupied=0.09*numlines;
firstline=0.5*(1+occupied);


count=0;
count2=0;
count3=0;
positionlines=cell(0,0);
for i=1:numlines
    curarray=linescells{i};
    for j=1:length(curarray)
           positionwords=cell(0,0);
        for k=1:curarray(j)
            annotation('line',[0.40+(k-1)*0.03+(0.03*sum(curarray(1:j))-0.03*curarray(j)+0.03*j) 0.427+(k-1)*0.03+(0.03*sum(curarray(1:j))-0.03*curarray(j)+0.03*j)],[firstline-(i-1)*0.09 firstline-(i-1)*0.09]);
            positionwords{k}=[0.40+(k-1)*0.03+(0.03*sum(curarray(1:j))-0.03*curarray(j)+0.03*j) firstline-(i-1)*0.09];
        end
        positionlines=[positionlines positionwords];
    end
end


spacees=find(double(word)==32);
wordnospace=word;
for i=length(spacees):-1:1
    wordnospace(spacees(i))=[];
end

for i=1:length(wordnospace)
    letterpos(i).letter=wordnospace(i);
    letterpos(i).position=[positionlines{i}];
end


set(figgy,'keypressfcn',{@letterguess,wordnospace,letterpos,diffi});
if exist('info')~=1
    info=struct('characters',[],'mancount',0,'correctguesses',0);
end



guidata(figgy,info)


function letterguess(figgy,~,wordnospace,letterpos,diffi)
keypressed=(get(figgy,'currentcharacter'));
if keypressed>=97 & keypressed<=122
correct=find((wordnospace)==keypressed);
info=guidata(figgy);
find(double(info.characters)==double(keypressed));
if isempty(find(double(info.characters)==double(keypressed)))

info.characters=[info.characters keypressed];


guidata(figgy,info);


if isempty(correct) 
    info.mancount=info.mancount+1;
        guidata(figgy,info)
        switch diffi
            case 2
    switch info.mancount
        case 1
            annotation('ellipse',[0.24 0.64 0.1 0.16]);

        case 2
            annotation('line',[0.29 0.29],[0.48 0.64]);

        case 3
            annotation('line',[0.19 0.29],[0.62 0.55]);

        case 4
            annotation('line',[0.39 0.29],[0.62 0.55]);

        case 5
            annotation('line',[0.19 0.29],[0.27 0.48]);
        case 6
            annotation('line',[0.39 0.29],[0.27 0.48]);
        case 7
            annotation('ellipse',[0.28 0.66 0.02 0.03])
            annotation('line',[0.26 0.275],[0.745 0.73]);
            annotation('line',[0.26 0.275],[0.73 0.745]);
            annotation('line',[0.30 0.315],[0.745 0.73]);
            annotation('line',[0.30 0.315],[0.73 0.745]);
            uicontrol('style','text','units','normalized','position',[0.4 0.75 0.2 0.2],'string','You Lose!','fontsize',40) 
            uicontrol('style','pushbutton','units','normalized','position',[0.65 0.75 0.2 0.09],'string','CLOSE','fontsize',35,'callback',@closer)
            uicontrol('style','pushbutton','units','normalized','position',[0.65 0.86 0.2 0.09],'string','PLAY AGAIN','fontsize',35,'callback',@playagain)
    end
        case 1
    switch info.mancount
        case 1
            annotation('ellipse',[0.24 0.64 0.1 0.16]);
            annotation('line',[0.29 0.29],[0.48 0.64]);

        case 2
            annotation('line',[0.19 0.29],[0.62 0.55]);
            annotation('line',[0.39 0.29],[0.62 0.55]);

        case 3
            annotation('line',[0.19 0.29],[0.27 0.48]);
        case 4
            annotation('line',[0.39 0.29],[0.27 0.48]);
        case 5
            annotation('ellipse',[0.28 0.66 0.02 0.03])
            annotation('line',[0.26 0.275],[0.745 0.73]);
            annotation('line',[0.26 0.275],[0.73 0.745]);
            annotation('line',[0.30 0.315],[0.745 0.73]);
            annotation('line',[0.30 0.315],[0.73 0.745]);
            uicontrol('style','text','units','normalized','position',[0.4 0.75 0.2 0.2],'string','You Lose!','fontsize',40) 
            uicontrol('style','pushbutton','units','normalized','position',[0.65 0.75 0.2 0.09],'string','CLOSE','fontsize',35,'callback',@closer,'backgroundcolor',[0.989 0.003 0.003])
            uicontrol('style','pushbutton','units','normalized','position',[0.65 0.86 0.2 0.09],'string','PLAY AGAIN','fontsize',35,'callback',@playagain,'backgroundcolor',[0.142 0.95 0.2])
    end
    end
    
else 
    for i=1:length(correct)
        switch diffi
            case 1
                a=5
            case 2
                a=7
        end
        if info.mancount<a
        uicontrol('style','text','units','normalized','position',[letterpos(correct(i)).position 0.02 0.041],'string',upper(letterpos(correct(i)).letter),'fontsize',20)
        info.correctguesses=info.correctguesses+1;
            guidata(figgy,info)
        end
    end
end
if info.correctguesses==length(wordnospace)
    uicontrol('style','text','units','normalized','position',[0.4 0.75 0.2 0.2],'string','You Win!','fontsize',40) 
    uicontrol('style','pushbutton','units','normalized','position',[0.65 0.75 0.2 0.09],'string','CLOSE','fontsize',35,'callback',@closer,'backgroundcolor',[0.989 0.003 0.003])
    uicontrol('style','pushbutton','units','normalized','position',[0.65 0.86 0.2 0.09],'string','PLAY AGAIN','fontsize',35,'callback',@playagain,'backgroundcolor',[0.142 0.95 0.2])
  
end
end
end
end

function closer(~,~)
clc;
close all
end

function playagain(~,~)
clc;
close all
run hangman2.m
end