function show_gap(gaps)
    figure;
    bar3(0:39,gaps);
    set(gca,'XDir','reverse');
    title('Gaps at each node');
    xlabel('Step');ylabel('Node index');zlabel('Gap');
    axis([-inf,inf,-1,40,0,7]);
    drawnow;
end