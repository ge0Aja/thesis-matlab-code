function [Flows] = GetFlowsEdit(No,Source,Destination,SrcPort,DstPort,Protocol,Time,Length,x)
l = 1;
TempTuplesCounter = 1;
for i=1:length(No)-1
    if(i == 1)
    TempSourceIP = Source(i);
    TempDestinationIP = Destination(i);
    TempSrcPort = SrcPort(i);
    TempDstPort = DstPort(i);
    TempProtocol = Protocol(i);
    Time = cell2mat(Time);
    No = cell2mat(No);
    %Length = cell2mat(Length);
    end
    TempTuple = strjoin(strcat(Source(i),Destination(i) , SrcPort(i) , DstPort(i) , Protocol(i)));
    TempTupleRev = strjoin(strcat(Destination(i),Source(i) , DstPort(i), SrcPort(i) ,  Protocol(i)));
        if (i ~= 1 && (ismember(TempTuple, TempTuples) || ismember(TempTupleRev, TempTuples)) )
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
            if(isequal(Source(i),x))
                TempFlow(1,5) = -1;
            else
                TempFlow(1,5) = 1;
            end
        end
    TempTuplesCounter = TempTuplesCounter +1 ;
    k = 2;
    for j=i+1:length(No)
        %% added the final clause for the length
        if((isequal(Source(j),TempSourceIP) || isequal(Source(j),TempDestinationIP)) && (isequal(Destination(j),TempDestinationIP) || (isequal(Destination(j),TempSourceIP)) && (isequal(SrcPort(j),TempSrcPort) || isequal(SrcPort(j),TempDstPort)) && (isequal(DstPort(j),TempDstPort) || isequal(DstPort(j),TempSrcPort)) && isequal(Protocol(j),TempProtocol))) %%&& (Time(j) - Time(j-1)) <= 2 )
            TempFlow(k,1) = No(j);
            TempFlow(k,2) = Time(j);
            TempFlow(k,3) =  Length(j);
            TempFlow(k,4) = Time(j) - Time(j-1);
            if(isequal(Source(j),x))
                TempFlow(k,5) = -1;
            else
                TempFlow(k,5) = 1;
            end
            k = k+1;
        end
    end
        Flows{l} = TempFlow;
        l = l +1;
    TempFlow = [];
    
end
end