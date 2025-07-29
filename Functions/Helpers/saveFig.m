function status = saveFig(fig,file_name,format,opt)
% saveFig Save figure to file
%
% arguments:
%     fig          figure handle, figure to save
%     file_name    string, file name to save figure
%     format       string, format of file
%
% name-value arguments:
%     pause        double = 0, pause time before saving, useful to allow MATLAB to render figures before saving
%
% output:
%     status       logical, always true; necessary to allow the syntax:
%
%                  >> logical_flag && saveFig(fig,file_name,format);
%
%                  which will save the figure only if logical_flag is true

% Copyright (C) 2025 by Pietro Bozzo
%
% This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

arguments
  fig (1,1) matlab.ui.Figure
  file_name (1,1) string
  format (1,1) string
  opt.pause (1,1) {mustBeNumeric,mustBeNonnegative} = 0
end

if opt.pause ~= 0
  pause(opt.pause)
end

% force all graphics update before save  
drawnow;

saveas(fig,file_name+"."+format,format)

status = true;