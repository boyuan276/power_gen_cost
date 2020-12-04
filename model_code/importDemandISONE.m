function hourlyDemand = importDemandISONE(filename, dataLines)
%IMPORTFILE Import data from a text file
%  HOURLYDEMAND = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  HOURLYDEMAND = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  hourlyDemand = importfile("D:\courses\ECE 4800\Project\power_gen_cost\data\2019_LOAD_ISONE\da_hourlydemand_20190101_20190115.csv", [7, 366]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 27-Nov-2020 20:45:36

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [7, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Date", "Hour", "DayAheadDemand"];
opts.SelectedVariableNames = ["Date", "Hour", "DayAheadDemand"];
opts.VariableTypes = ["string", "datetime", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");
opts = setvaropts(opts, "Date", "InputFormat", "MM/dd/yyyy");

% Import the data
hourlyDemand = readtable(filename, opts);
hourlyDemand = hourlyDemand(~ismissing(hourlyDemand.Date), :);
hourlyDemand.Hour = hourlyDemand.Hour - 1;
hourlyDemand.DateTime = datetime(year(hourlyDemand.Date),month(hourlyDemand.Date),day(hourlyDemand.Date),hourlyDemand.Hour,0,0);
hourlyDemand.DateTime.Format = 'MM/dd/yyyy HH:mm:ss';

end