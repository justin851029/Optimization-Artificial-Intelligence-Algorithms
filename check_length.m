
II=[1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8];
aa=[13	25	4	10	15	27	7	3	29	20	6	18	32	30	22	26	11	16	31	2	19	24	8	28	1	14	17	9	12	21	5	23];
bb=[1 6 3 4 1 6 2 5 6 1 3 4 3 1 5 4 1 3 2 4 1 5 6 3 1 5 2 4 1 5 2 4];
Visit_time=[32 17 20 20 18 30 ; 35 17 18 20 16 27 ; 33 15 21 18 16 30 ; 33 17 19 16 17 29 ; 30 16 20 18 19 27 ; 22 13 16 13 14 20 ; 22 14 17 11 12 18 ; 20 11 17 11 13 19]; % 旅客團參觀各展覽室時間
Travel_time=[0 0.8 0.8 1.4 1.4 1.0 
0.8 0 1.0 1.6 2.0 2.4 
0.8 1.0 0 1.0 1.4 2.5 
1.4 1.6 1.0 0 1.2 1.8 
1.4 2.0 1.4 1.2 0 1.2
1.0 2.4 2.5 1.8 1.2 0]; % 各展覽室到其他展覽室之行走時間
Enter_Exit_time=[2.2 2.6 3.2 3.6 3.6 2.6 ; 2.2 2.6 3.2 3.6 3.6 2.6]; % 入口到展覽室時間 & 展覽室到出口時間
Room_time=zeros(1,6);
Group_previous_room=zeros(1,8);
Group_time=zeros(1,8);      % 記錄Group於Room完成時間
Group_visittime=zeros(1,8);

for i=1:max(size(bb))
    %'iiii'
    %i
    [G ,aa_index]=sort(aa);
    G_index=II(1,aa_index(i));
    Room_index=bb(1,aa_index(i));
%Room_index=[3 2 4 1   1 4 2 3    2 3 1 4   4 1 3 2];
%G_index=[

    if (Room_time(1,Room_index)==0)&(Group_previous_room(G_index)==0)
        %'R=0 & G=0'
        %Enter_Exit_time(1,Room_index)
        %Visit_time(G_index,Room_index)
        i
        Room_time(1,Room_index)=Enter_Exit_time(1,Room_index)+Visit_time(G_index,Room_index)
        Group_previous_room(1,G_index)=Room_index
       % '------------Room_Group_time(1,G_index)'
        Group_time(1,G_index)=Room_time(1,Room_index)        
    elseif (Room_time(1,Room_index)>0)&(Group_previous_room(G_index)==0)
                %'R>0 & G=0'
        i
        Visit_time(G_index,Room_index);
        Room_time(1,Room_index)=Room_time(1,Room_index)+Visit_time(G_index,Room_index)
        Group_previous_room(1,G_index)=Room_index
             %   '------------Room_Group_time(1,G_index)'
        Group_time(1,G_index)=Room_time(1,Room_index)
    elseif (Room_time(1,Room_index)==0)&(Group_previous_room(G_index)>0)
               % 'R=0 & G>0'
        %Visit_time(G_index,Room_index)
        i
        Room_time(1,Room_index)=max(Room_time(1,Room_index),Group_time(1,G_index))+Travel_time(Group_previous_room(1,G_index),Room_index)+Visit_time(G_index,Room_index)
        Group_previous_room(1,G_index)=Room_index
            %    '------------Room_Group_time(1,G_index)'
        Group_time(1,G_index)=Room_time(1,Room_index)       
    elseif (Room_time(1,Room_index)>0)&(Group_previous_room(G_index)>0)
              %  'R>0 & G>0'
        %Visit_time(G_index,Room_index)
        %Group_previous_room(1,G_index)
       % Group_time(1,G_index)
        %max(Room_time(1,Room_index),Group_time(1,G_index))
        i
        Room_time(1,Room_index)=max(Room_time(1,Room_index),Group_time(1,G_index)+Travel_time(Group_previous_room(1,G_index),Room_index))+Visit_time(G_index,Room_index)
        %'uuuuuuuuuuuu'
        %Travel_time(Group_previous_room(1,G_index),Room_index)
        %Group_previous_room(1,G_index)
        %Room_index
        %Visit_time(G_index,Room_index)        
        Group_previous_room(1,G_index)=Room_index
         %       '------------Room_Group_time(1,G_index)'
        Group_time(1,G_index)=Room_time(1,Room_index)
        %pause
    end
    Group_visittime(1,G_index)=Group_visittime(1,G_index)+Visit_time(G_index,Room_index);
end
%Room_time=Room_time+Enter_Exit_time(2,:);
Group_time=Group_time+Enter_Exit_time(2,Group_previous_room)
Group_waittime=Group_time-Group_visittime
waitvisitrait=Group_waittime./Group_visittime;
max_rait=max(waitvisitrait);
max(Group_time)-min(Group_time)
sum(Group_waittime)
max(Group_time)