clc; clear; close all;
%% initialization
slaves_path = '.\data\fastener_stiffness_1E4\slaves.slv';
results_path = 'results.dat';
results_allGaps_path = 'results_allGaps.dat';
results_allNodes_path = 'results_allNodes.dat';

total_steps = 20;
screwindex = 6; % The node to start with
gaps_before = 6*ones(40,1);
 
% Series
final_order = screwindex;
gaps_series = gaps_before;
L_series = object_function(gaps_before);
 
%% Calculating the order
for i = 1:total_steps
    % Write the sequence to slaves.log file
    fileID = fopen(slaves_path,'w');
    fprintf(fileID,'%d ', final_order);
    fclose(fileID);
 
    % Delete the former results
    delete(results_path);
    delete(results_allNodes_path);
    delete(results_allGaps_path);
    % Run the Simulator
    tic
    ! .\Simulator_batch -open=script.log
    toc
 
    % read the results
    fid = fopen('results.dat','rt');
    A = textscan(fid,'%f','Headerline',1);
    A = A{1};
    fclose(fid);
    
    gaps_after = A(5:6:end);
    gaps_series(:,end+1) = gaps_after; 
    
    close all;
    show_gap(gaps_series);
 
    % Loss Function
    L = object_function(gaps_after)
    L_series(end+1) = L;
    figure;
    plot(L_series);
    title('Loss funciton');
    drawnow;
    
    if i==total_steps
        break
    end
    
    screwindex = find_biggest_dgap(gaps_before,gaps_after,final_order);
 
    final_order(end+1) = screwindex;
 
    gaps_before = gaps_after;
end

final_order