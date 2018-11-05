%Records fitness Data
global fitnessSurfData;
dataHolder = zeros(101, 1, 3);
testVal = linspace(0,1,101);
currTime = getTime();
disp(strcat('debug:', num2str(currTime)));

parfor iTestVal = 1:101
    dataHolder(iTestVal, 1, :) = calcG(r, x, E, findK(testVal(iTestVal)), doceLevel, testVal(iTestVal));
end

fitnessSurfData(:, currTime, :) = dataHolder;

clear testVal currTime dataHolder;