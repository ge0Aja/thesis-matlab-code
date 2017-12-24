function [ Out_Flows,In_Flows ] = GetFlows(No,Source,Destination,SrcPort,DstPort,Protocol,Time,Length)
l_out = 1;
l_in = 1;
TempTuplesCounter = 1;
for i=1:length(No)-1
    if(i == 1)
    TempSourceIP = Source(i);
    TempDestinationIP = Destination(i);
    TempSrcPort = SrcPort(i);
    TempDstPort = DstPort(i);
    TempProtocol = Protocol(i);
    end
    TempTuple = strjoin(strcat(Source(i),Destination(i) , SrcPort(i) , DstPort(i) , Protocol(i))); 
        if (i ~= 1 && ismember(TempTuple, TempTuples))
            continue;
        else
            
            TempSourceIP = Source(i);
            TempDestinationIP = Destination(i);
            TempSrcPort = SrcPort(i);
            TempDstPort = DstPort(i);
            TempProtocol = Protocol(i);
            TempTuples{TempTuplesCounter} = strjoin(strcat(Source(i),Destination(i) , SrcPort(i) , DstPort(i) , Protocol(i))); 
            TempTuples = TempTuples(~cellfun('isempty',TempTuples));
            
            TempFlow(1,1) = No(i);
            TempFlow(1,2) = Time(i);
            TempFlow(1,3) =  Length(i);
            TempFlow(1,4) = 0;
        end
    TempTuplesCounter = TempTuplesCounter +1 ;
    k = 2;
    for j=i+1:length(No)
        if(isequal(Source(j),TempSourceIP) && isequal(Destination(j),TempDestinationIP) && isequal(SrcPort(j),TempSrcPort) && isequal(DstPort(j),TempDstPort) && isequal(Protocol(j),TempProtocol))
            TempFlow(k,1) = No(j);
            TempFlow(k,2) = Time(j);
            TempFlow(k,3) =  Length(j);
            TempFlow(k,4) = Time(j) - Time(j-1);
            k = k+1;
        end
    end
    if(isequal(Source(i),{'192.168.137.3'}))
    Out_Flows{l_out} = TempFlow;
    l_out = l_out+1;
    else
        In_Flows{l_in} = TempFlow;
        l_in = l_in +1;
    end
    TempFlow = [];
    
end
end