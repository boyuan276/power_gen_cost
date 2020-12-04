function priceISONE = importPriceISONE(filename, dataLines)
%IMPORTFILE Import data from a text file
%  PRICEISONE = IMPORTFILE(FILENAME) reads data from text file FILENAME
%  for the default selection.  Returns the data as a table.
%
%  PRICEISONE = IMPORTFILE(FILE, DATALINES) reads data for the specified
%  row interval(s) of text file FILENAME. Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  priceISONE = importfile("D:\courses\ECE 4800\Project\power_gen_cost\data\2019_DAM_LMP_ISONE\EXAMPLE_WW_DALMP_ISO_20201127.csv", [7, 28902]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 26-Nov-2020 22:41:13

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [7, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 10);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Date", "Hour", "LocationID", "LocationName", "LocationType", "LocationalMarginalPrice", "EnergyComponent", "CongestionComponent", "MarginalLossComponent"];
opts.SelectedVariableNames = ["Date", "Hour", "LocationID", "LocationName", "LocationType", "LocationalMarginalPrice", "EnergyComponent", "CongestionComponent", "MarginalLossComponent"];
opts.VariableTypes = ["string", "datetime", "double", "categorical", "categorical", "categorical", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "LocationName", "LocationType"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "Date", "InputFormat", "MM/dd/yyyy");

% Import the data
priceISONE = readtable(filename, opts);
priceISONE.Hour = priceISONE.Hour - 1;
priceISONE.DateTime = datetime(year(priceISONE.Date),month(priceISONE.Date),day(priceISONE.Date),priceISONE.Hour,0,0);
priceISONE.DateTime.Format = 'MM/dd/yyyy HH:mm:ss';
priceISONE = rmmissing(priceISONE);
priceISONE = priceISONE(priceISONE.LocationType == "LOAD ZONE", :);
end