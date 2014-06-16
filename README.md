# Trekking and Hiking Times #

Trekking and hiking time rule MATLAB implementations for Naismith's rule, Naismith's rule with Aitken-Langmuir corrections and Tobler's rule.

## Naismith's rule ##

* Function available in `naismith.m`
* Example plot available in `naismith_plot.m`

### Example ###

	track_length = 20;  % km
	ascend = 1;         % km
	[w, t] = naismith(track_length, ascend)


## Naismith's rule with Aitken-Langmuir corrections ##

* Function available in `naismith_al.m`
* Example plot available in `naismith_al_plot.m`

### Example ###

	base_speed = 4;     % km /h
	track_length = 20;  % km
	ascend = 1;         % km
	[w, t] = naismith_al(track_length, ascend)

## Tobler's rule ##

* Function available in `tobler.m`
* Plot will be generated when called without return parameter

### Example ###

	slope = tand(10);   % tand(degree)
	track_factor = 1;   % e.g. 1 (footpaths), 0.6 (off-path)
	[w] = tobler(slope, track_factor)

	% create plot
	tobler(slope, track_factor)