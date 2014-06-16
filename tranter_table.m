% added Tranter's correction table to Naismith's rule

hours   = [2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 22, 24];
fitness = [15, 20, 25, 30, 40, 50];
tranter = [1,    1.5,  2,    2.75, 3.5, 4.5,  5.5,  6.75, 7.75,  10,   12.5, 14.5, 17,  19.5, 22, 24;
           1.25, 2.25, 3.25, 4.5,  5.5, 6.7,  7.75, 8.75, 10,    12.5, 15,   17.5, 20,  23,  NaN, NaN;
           1.5,  3,    4.25, 5.5,  7,   8.5,  10,   11.5, 13.25, 15,   17.5, NaN,  NaN, NaN, NaN, NaN;
           2,    3.5,  5,    6.75, 8.5, 10.5, 12.5, 14.5, NaN,   NaN,  NaN,  NaN,  NaN, NaN, NaN, NaN;
           2.75, 4.25, 5.75, 7.5,  9.5, 11.5, NaN,  NaN,  NaN,   NaN,  NaN,  NaN,  NaN, NaN, NaN, NaN;
           3.25, 4.75, 6.5,  8.5,  NaN, NaN,  NaN,  NaN,  NaN,   NaN,  NaN,  NaN,  NaN, NaN, NaN, NaN];