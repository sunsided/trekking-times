classdef TrekkingTimesTest < matlab.unittest.TestCase
    % TrekkingTimesTest Unit tests for the trekking-times rule implementations.

    methods (TestClassSetup)
        function addRepoToPath(testCase)
            here = fileparts(mfilename('fullpath'));
            repoRoot = fileparts(here);
            addpath(repoRoot);
            testCase.addTeardown(@() rmpath(repoRoot));
        end
    end

    methods (Test)

        % ----- naismith ---------------------------------------------------

        function naismithFlatTrack(testCase)
            [w, t, slope] = naismith(10, 0);
            testCase.verifyEqual(slope, 0);
            testCase.verifyEqual(t, 2, 'AbsTol', 1e-12);
            testCase.verifyEqual(w, 5, 'AbsTol', 1e-12);
        end

        function naismithWithAscend(testCase)
            % t = 20/5 + 1/0.6
            [w, t, slope] = naismith(20, 1);
            expectedT = 20/5 + 1/0.6;
            testCase.verifyEqual(t, expectedT, 'AbsTol', 1e-12);
            testCase.verifyEqual(w, 20/expectedT, 'AbsTol', 1e-12);
            testCase.verifyEqual(slope, 1/20, 'AbsTol', 1e-12);
        end

        % ----- naismith_al ------------------------------------------------

        function naismithAlDefaultBaseSpeed(testCase)
            [w1, t1] = naismith_al(10, 0);
            [w2, t2] = naismith_al(10, 0, 4);
            testCase.verifyEqual(t1, t2, 'AbsTol', 1e-12);
            testCase.verifyEqual(w1, w2, 'AbsTol', 1e-12);
        end

        function naismithAlFlat(testCase)
            [w, t] = naismith_al(10, 0, 4);
            testCase.verifyEqual(t, 2.5, 'AbsTol', 1e-12);
            testCase.verifyEqual(w, 4,   'AbsTol', 1e-12);
        end

        function naismithAlAscent(testCase)
            % slope = 0.1, ascent branch applies
            [~, t] = naismith_al(10, 1, 4);
            expectedT = 10/4 + 1/0.6;
            testCase.verifyEqual(t, expectedT, 'AbsTol', 1e-12);
        end

        function naismithAlShallowDescentNoCorrection(testCase)
            % slope = -0.05 -> theta ~ -2.86 deg, no branch matches
            [~, t] = naismith_al(20, -1, 4);
            testCase.verifyEqual(t, 20/4, 'AbsTol', 1e-12);
        end

        function naismithAlMediumDescentSubtracts(testCase)
            % slope = -0.1 -> theta ~ -5.71 deg, in [-12, -5]: subtract time
            [~, t] = naismith_al(10, -1, 4);
            expectedT = 10/4 - 1*((10/60)/0.3);
            testCase.verifyEqual(t, expectedT, 'AbsTol', 1e-12);
        end

        function naismithAlSteepDescentAdds(testCase)
            % slope = -0.5 -> theta ~ -26.57 deg, < -12: add time
            [~, t] = naismith_al(2, -1, 4);
            expectedT = 2/4 + 1*((10/60)/0.3);
            testCase.verifyEqual(t, expectedT, 'AbsTol', 1e-12);
        end

        % ----- tobler -----------------------------------------------------

        function toblerFlat(testCase)
            w = tobler(0, 1);
            expected = 6 * exp(-3.5 * 0.05);
            testCase.verifyEqual(w, expected, 'AbsTol', 1e-12);
        end

        function toblerPeakAtMinusFivePercent(testCase)
            % The Tobler peak is at slope = -0.05 (gentle downhill).
            wPeak = tobler(-0.05, 1);
            wFlat = tobler(0,     1);
            testCase.verifyEqual(wPeak, 6, 'AbsTol', 1e-12);
            testCase.verifyGreaterThan(wPeak, wFlat);
        end

        function toblerScaleIsLinear(testCase)
            wFootpath = tobler(0.1, 1);
            wOffPath  = tobler(0.1, 0.6);
            testCase.verifyEqual(wOffPath, 0.6 * wFootpath, 'AbsTol', 1e-12);
        end

        % ----- tranter ----------------------------------------------------

        function tranterMatchesTableApproximately(testCase)
            % Spot-check the fit against the original Tranter table at
            % fitness = 25 min, time = 5 h, where the table value is 5.5 h.
            tFit = tranter(5, 25);
            testCase.verifyEqual(tFit, 5.5, 'AbsTol', 0.5);
        end

        function tranterIsMonotonicInTime(testCase)
            % For a fixed fitness, corrected time should grow with input time.
            ts = arrayfun(@(t) tranter(t, 25), 2:10);
            testCase.verifyTrue(all(diff(ts) > 0));
        end

        % ----- tranter_table ----------------------------------------------

        function tranterTableShape(testCase)
            [tbl, hours, fitness] = tranter_table();
            testCase.verifyEqual(size(tbl), [length(fitness), length(hours)]);
            testCase.verifyEqual(length(hours), 16);
            testCase.verifyEqual(length(fitness), 6);
            testCase.verifyEqual(tbl(1,1), 1);
        end

        % ----- tranter_ts -------------------------------------------------

        function tranterTsReturnsTimeseries(testCase)
            series = tranter_ts();
            testCase.verifyEqual(numel(series), 6);
            testCase.verifyClass(series(1), 'timeseries');
            % Fitness value is stashed in UserData by tranter_ts.
            testCase.verifyEqual(series(1).UserData, 15);
        end

    end
end
