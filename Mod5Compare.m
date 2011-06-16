function Result = Mod5Compare(Filespecs, OutputDir, CompareDir)
% Mod5Compare : Compare pairs of corresponding files from 2 directories
%
% This function reads files of the given files types (specifications) and
% presents the files in kdiff3 (must be installed e.g. by installing
% TortoiseHg).

% Copyright 2011, DPSS, CSIR, $Author:$
% $Id:$
% This software is subject to the terms and conditions of the BSD licence.

Result = 0;
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
end

if ~exist('CompareDir', 'var') || isempty(CompareDir)
    CompareDir = uigetdir(MODTRANPath, 'Select the Directory for the Comparison Output');
    if CompareDir(1) == 0
        return;
    end    
end

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
          system(['kdiff3 "' SourceTargFile '" "' ComparisonTargFile '"']);
      else
          warning('Mod5Compare:NoTargetFile','No target comparison file was found for file %s.', SourceTargFile); 
      end
  end
end
end