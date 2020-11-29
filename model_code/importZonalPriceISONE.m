function WWDALMPISO20190101 = importZonalPriceISONE(filename, dataLines)
%IMPORTFILE Import data from a text file
%  WWDALMPISO20190101 = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  WWDALMPISO20190101 = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  WWDALMPISO20190101 = importfile("C:\Users\mi\Desktop\Cornell\ECE4800\code\data\2019_LMP_ISONE\WW_DALMP_ISO_20190101.csv", [1, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 2020-11-28 07:31:11

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [1, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 10);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["H", "Date", "HourEnding", "Var4", "Var5", "LocationType", "LocationalMarginalPrice", "EnergyComponent", "CongestionComponent", "MarginalLossComponent"];
opts.SelectedVariableNames = ["H", "Date", "HourEnding", "LocationType", "LocationalMarginalPrice", "EnergyComponent", "CongestionComponent", "MarginalLossComponent"];
opts.VariableTypes = ["categorical", "datetime", "double", "string", "string", "categorical", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var4", "Var5"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["H", "Var4", "Var5", "LocationType"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "Date", "InputFormat", "MM/dd/yyyy");

% Import the data
WWDALMPISO20190101 = readtable(filename, opts);

end