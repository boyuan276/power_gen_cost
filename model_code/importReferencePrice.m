function damlbmpgenrefbus = importfile(filename, dataLines)
%IMPORTFILE Import data from a text file
%  DAMLBMPGENREFBUS = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  DAMLBMPGENREFBUS = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  damlbmpgenrefbus = importfile("D:\courses\ECE 4800\Project\power_gen_cost\data\2019_DAM_LBMP_Reference_Bus\20190101damlbmp_gen_refbus.csv", [1, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 25-Nov-2020 18:11:48

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [1, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 6);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Datetime", "Var2", "Var3", "LBMP", "Var5", "Var6"];
opts.SelectedVariableNames = ["Datetime", "LBMP"];
opts.VariableTypes = ["datetime", "string", "string", "double", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var2", "Var3", "Var5", "Var6"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var2", "Var3", "Var5", "Var6"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "Datetime", "InputFormat", "MM/dd/yyyy HH:mm");

% Import the data
damlbmpgenrefbus = readtable(filename, opts);

end