function Result = Mod5Test(InputDir, OutputDir, CompareDir)
% Mod5Test : Test reading, writing of MODTRAN 5 cases
%
% This function reads all the .tp5 files in the InputDir and
% writes the same files to the OutputDir. It will also write 
% the file mod5root.in listing all the test cases to the MODTRAN
% executable directory.
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

if ~exist('InputDir', 'var') || isempty(InputDir)
    InputDir = uigetdir(MODTRANPath, 'Select the Directory for MODTRAN Input Test Cases');
    if InputDir(1) == 0
        return;
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
%% Read and write all cases
TheCases = dir([InputDir '\*.tp5']);

for iCase = 1:numel(TheCases)
    ThisMod5 = Mod5([InputDir '\' TheCases(iCase).name]);
    ThisMod5.Write([OutputDir '\' TheCases(iCase).name]);
end
end
