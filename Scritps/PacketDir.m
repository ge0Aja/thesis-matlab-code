for i=1:length(Source)
if(isequal(Source(i),{'192.168.137.3'}))
Packetdir(i)=-1;
else
Packetdir(i)=1;
end
end
Packetdir = Packetdir';