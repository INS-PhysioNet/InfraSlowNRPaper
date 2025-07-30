function colors = paperColors(i)
% myColors Get colors for Infra-Slow NR paper
%
% arguments:
%     i          (:,1) double, indices of colors in the palette
%
% output:
%     colors     (n_i,3) RGB color arrays between 0 and 1

% Copyright (C) 2025 by Pietro Bozzo
%
% This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

palette = validatecolor(["#87b69e", ... % 1. HPC
                         "#fc7860", ... % 2. PFC
                         "#a076b9", ... % 3. NR
                         "#fcf2c8", ... % 4. TH
                         "#ecc8e3", ... % 5. nREM
                         "#a8c7ec", ... % 6. REM
                         "#fff3b6", ... % 7. wake
                         "#d8e9bc", ... % 8. NR "up state"
                         "#bee5eb", ... % 9. NR "down state"
                         ],'multiple');

% make colors circular
i = mod(i-1,size(palette,1)) + 1;

colors = palette(i,:);