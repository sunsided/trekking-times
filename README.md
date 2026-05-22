# Trekking and Hiking Times

MATLAB implementations of common trekking and hiking time rules:

- **Naismith's rule** — original 1892 estimate of walking time from distance and ascent.
- **Naismith's rule with Aitken–Langmuir corrections** — adjustments for variable base speed and descent.
- **Tobler's hiking function** — exponential walking speed model as a function of slope.
- **Tranter's correction table** — fitness-dependent correction applied on top of Naismith times, plus a closed-form best-fit approximation.

## Requirements

- MATLAB R2018a or newer (older versions likely work; the test suite uses `matlab.unittest`).

## Naismith's rule

- Function: [`naismith.m`](naismith.m)
- Example plot: [`naismith_plot.m`](naismith_plot.m)

```matlab
distance = 20;  % km
ascend   = 1;   % km
[w, t] = naismith(distance, ascend)
```

## Naismith's rule with Aitken–Langmuir corrections

- Function: [`naismith_al.m`](naismith_al.m)
- Example plot: [`naismith_al_plot.m`](naismith_al_plot.m)

```matlab
distance   = 20;  % km
ascend     = 1;   % km
base_speed = 4;   % km/h
[w, t] = naismith_al(distance, ascend, base_speed)
```

## Tobler's hiking function

- Function: [`tobler.m`](tobler.m)
- Calling without an output argument produces a plot.

```matlab
slope        = tand(10);  % tand(degree)
track_factor = 1;         % 1 for footpaths, 0.6 for off-path
w = tobler(slope, track_factor)

% Generate the explanatory plot
tobler(slope, track_factor)
```

## Tranter's correction table

A correction table applied on top of Naismith's rule.

- Table: [`tranter_table.m`](tranter_table.m)
- Least-squares best-fit function: [`tranter.m`](tranter.m)
- Plot of table vs. fit: [`tranter_plot.m`](tranter_plot.m)
- Fitting testbench: [`tranter_fit.m`](tranter_fit.m)
- Timeseries view of the table: [`tranter_ts.m`](tranter_ts.m)

```matlab
t       = 5;   % hours (Naismith base time)
fitness = 25;  % Tranter fitness in minutes
tcorrected = tranter(t, fitness)
```

## Running the tests

The repository ships with a small `matlab.unittest` suite under [`tests/`](tests/).

```matlab
results = runtests('tests');
disp(results);
```

A GitHub Actions workflow runs the same suite on every push and pull request — see [`.github/workflows/ci.yml`](.github/workflows/ci.yml).

## License

MIT — see [LICENSE](LICENSE).
