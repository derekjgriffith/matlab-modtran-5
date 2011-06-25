function Result = Mod5Compare(Filespecs, OutputDir, CompareDir)
% Mod5Compare : Compare pairs of corresponding files from 2 directories
%
% This function reads files of the given files types (specifications) and
% presents the files in kdiff3 (must be installed e.g. by installing
% TortoiseHg).
%
% Usage :
%   Mod5Compare(Filespecs, OutputDir, CompareDir);
%
% If the input and output directories are not given, a directory selection
% dialog will be presented. Filespecs is either a single file specification
% or a cell array of file specifications.
%
% Example : 
%   Mod5Compare('*.tp5', 'TESTA', 'TEST/COMPARE');
%
% Compares all .tp5 files found in the selected output directory to files of
% the same name in the comparison directory.
%
% Paths are relative to the MODTRAN executable directory if they do not
% start with a slash or backslash.
%
% See also : Mod5Test, Mod5TestRun

% Copyright 2011, DPSS, CSIR, $Author:$
% $Id:$
% This software is subject to the terms and conditions of the BSD licence.

Result = [];
persistent MODTRANPath MODTRANExe
%% Deal with location of the MODTRAN executable
if isempty(MODTRANExe)
    MODTRANExeFile = [fileparts(which('Mod5.m')) '\MODTRANExe.mat'];
    if exist(MODTRANExeFile, 'file')
        load(MODTRANExeFile);
        if ~exist(MODTRANExe, 'file') % Check that the MODTRAN executable exists
            [MODTRANExe, MODTRANPath] = Mod5.SetMODTRANExe;
        end
    else
        [MODTRANExe, MODTRANPath] = Mod5.SetMODTRANExe;
    end
end

if ~exist('OutputDir', 'var') || isempty(OutputDir)
    OutputDir = uigetdir(MODTRANPath, 'Select the Directory for the Output MODTRAN Cases');
    if OutputDir(1) == 0
        return;
    end
else
    assert(ischar(OutputDir), 'Mod5Compare:BadOutputDir',...
        'The input InputDir must be a string.');
    if ~any(OutputDir(1) == '/\')
        OutputDir = [MODTRANPath OutputDir];
    end
    
end
% The directory must exist
assert(exist(OutputDir, 'dir') == 7, 'Mod5Compare:OutputDirNotExist', ...
    'The output directory %s does not exist.', OutputDir)

if ~exist('CompareDir', 'var') || isempty(CompareDir)
    CompareDir = uigetdir(MODTRANPath, 'Select the Directory for the Comparison Output');
    if CompareDir(1) == 0
        return;
    end
else
    assert(ischar(OutputDir), 'Mod5Compare:BadCompareDir',...
        'The input CompareDir must be a string.');
    if ~any(CompareDir(1) == '/\')
        CompareDir = [MODTRANPath CompareDir];
    end    
end
% The directory must exist
assert(exist(CompareDir, 'dir') == 7, 'Mod5Compare:CompareDirNotExist', ...
    'The Compare directory %s does not exist.', CompareDir)

if exist('Filespecs', 'var') && ~isempty(Filespecs)
    assert(ischar(Filespecs) || iscellstr(Filespecs), 'Mod5Compare:BadFilespecs',...
        'Input Filespecs must be a file specification or cell array of file specifications');
    if ischar(Filespecs)
        Filespecs = {Filespecs};
    end
else
    Filespecs = {'*.*'}; % All files
end
%% Get files of each types and find corresponding files in the comparison
% directory.
for iSpec = 1:numel(Filespecs)
  TheFiles = dir([OutputDir '\' Filespecs{iSpec}]);
  for iFile = 1:numel(TheFiles)
      % Compile the name of the comparison files
      [Path, Fname, Ext] = fileparts(TheFiles(iFile).name);
      SourceTargFile = [OutputDir '\' Fname Ext];      
      ComparisonTargFile = [CompareDir '\' Fname Ext];
      if exist(ComparisonTargFile, 'file')
          Result(iFile) = system(['kdiff3 "' SourceTargFile '" "' ComparisonTargFile '"']);
      else
          warning('Mod5Compare:NoTargetFile','No target comparison file was found for file %s.', SourceTargFile); 
      end
  end
end
end