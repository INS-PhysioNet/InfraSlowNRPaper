% Figure 1c, 1d: Identification of Nucleus Reuniens infra-slow rythm

% choose session and parameter values
session = '/mnt/hubel-data-139/perceval/Rat003_20231227/Rat003_20231227.xml';
regs = [12;32;70];
labels = ["pfc","hpc","nr"];

% load data
R = regions(session);

% save flag
do_save = true;
file_root = fileparts(fileparts(matlab.desktop.editor.getActiveFilename));

%% 1c. NR slow-rythm raster (example)
[fig_lines,h] = R.plotSpikeRaster(1500,3000,regions=[70,32,12],colors=[0.7,0.7,0.7]);
legend('off')

% copy figure to save once the raster in jpeg once the axes and lines in svg
ax_lines = gca;
fig_raster = figure(Name='raster_copy',NumberTitle='off',Position=get(0,'ScreenSize'));
copyobj(ax_lines,fig_raster)

% save raster as png
set(gca,'XColor','none','YColor','none')
title(gca,'')
do_save && saveFig(fig_raster,fullfile(file_root,'Figures/Fig1c_raster'),'png',res=700,pause=1);

% save axes and lines as svg
delete(h)
yline(ax_lines,cumsum(R.nNeurons(regs([3,2])))+0.5,Color=myColors(1),LineWidth=1.7)
do_save && saveFig(fig_lines,fullfile(file_root,'Figures/Fig1c_axes'),'svg');

%% 1d. avalanches allow to identify slow rythm intervals (example)

% parameters
aval_window = 0.05;
smooth = 25;
aval_thresh = 0.025;

[slow_intervals,slow_avals] = slowIntervals_(session,regs,labels,window=aval_window,smooth=smooth,threshold=aval_thresh,load=false);
slow_dur.nr = sum(diff(slow_intervals.nr,1,2));

start = 1800; stop = 2300;

% save raster as png
[fig_raster,axs] = makeFigure('raster','',[2,1],TileSpacig='none');
[~,h] = R.plotSpikeRaster(start,stop,states='all',regions=70,colors=[0.7,0.7,0.7],ax=axs(1));
set(axs,'XTick',[],'YTick',[],'YColor','none'); legend(axs(1),'off'); set(axs(1),'XColor','none'); set(axs(2),'Color','none')
do_save && saveFig(fig_raster,fullfile(file_root,'Figures/Fig1d_raster'),'png',res=700,pause=1);

% save avalanches as svg
[fig_aval,axs] = makeFigure('identif',"Slow-rythm identification, "+R.printBasename()+', NR (n: '+num2str(R.nNeurons(70))+'), w: '+num2str(aval_window)+' s, s: '+num2str(smooth)+ ...
  ', t: '+num2str(aval_thresh)+', T: '+num2str(slow_dur.nr)+' s',[2,1],TileSpacig='none');
set(axs(1),'XTick',[],'YTick',[]); legend(axs(1),'off'); ylabel(axs(1),'units')
R.plotFiringRates(start,stop,aval_window,states='all',regions=70,smooth=smooth,mode="ratio",ax=axs(2));
PlotIntervals(slow_avals.nr,'color',[1,0.89,0.82],'legend','off','alpha',1)
PlotIntervals(slow_intervals.nr,'legend','off')
set(axs(2),'YLim',[0,0.25],'YTickMode','auto','YTickLabelMode','auto'); legend(axs(2),'off')
do_save && saveFig(fig_aval,fullfile(file_root,'Figures_axes/Fig1d'),'svg');