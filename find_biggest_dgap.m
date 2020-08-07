function index=find_biggest_dgap(gaps_before,gaps_after,existing_nodes)
    dgaps=gaps_before-gaps_after;
    nodesOI=[1 2 3 6 8 10 11 14 16 18 19 22 24 26 27 30 32 34 35 38];
    for i=1:length(existing_nodes)
        nodesOI(find(nodesOI==existing_nodes(i)))=[];
    end
        
    for i=1:length(nodesOI)
        dgaps(nodesOI(i)+1)=dgaps(nodesOI(i)+1)+10;
    end
    index=find(dgaps==max(dgaps))-1;
end