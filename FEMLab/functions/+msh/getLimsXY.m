function [xlims, ylims] = getLimsXY(files)

load(files.respth, 'x', 'y');
xlims = [min(x), max(x)];
ylims = [min(y), max(y)];