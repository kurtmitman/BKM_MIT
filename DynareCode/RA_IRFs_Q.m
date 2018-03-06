close all;
figure1=figure;
 orient('landscape')
axes1 = axes('Parent',figure1,'FontSize',16);
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'on');
    xrange=1:100;
figure(20);
subplot(2,3,1);
plot(log_q(xrange));
title('Inv Specific Shock', 'FontSize', 12);
subplot(2,3,2);
plot(c(xrange)-c(1));
title('Consumption', 'FontSize', 12);
subplot(2,3,3);
plot(k(xrange)-k(1));
title('Capital', 'FontSize', 12);
subplot(2,3,4);
plot(r(xrange)-r(1));
title('Interest rate', 'FontSize', 12);
subplot(2,3,5);
plot(w(xrange)-w(1));
title('Wages', 'FontSize', 12);
subplot(2,3,6);
plot(y(xrange)-y(1));
title('Output', 'FontSize', 12);


% Enlarge figure to full screen.
set(gcf, 'PaperOrientation','landscape');
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
print(20,'-dpdf', [FigName '.pdf'],'-fillpage')
print(20,'-depsc2', [FigName '.eps'],'-loose')
