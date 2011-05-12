% Mod5 MODTRAN 5 Case Examples
% $Id$
% Copyright 2010, $Author$d
%
% Each cell in this script contains a single example. Run examples
% individually by clicking somewhere in the cell and then clicking on the
% "Evaluate Cell" icon on the toolbar.
%
% WARNING : All examples clear classes and close all plots. You
%           will lose all workspace variables.
disp('This script contains one cell per example. Run each cell individually.')
return;
%% Example 1 : Load a Mod5 from a tape5 format file, run it and plot
% This example is a 5 km horizontal path just above sea level
close all
clear classes
% Determine the directory in which the Mod5 archive was extracted
MCDir = fileparts(which('Mod5'));
% Load the case
Ex1 = Mod5([MCDir '\Ex1.ltn']);
% Run the case
Ex1 = Ex1.Run;
% Plot total transmission and water transmission
Ex1.PlotTp7({'TRANS', 'H2OTRANS'}); 

%% Example 2 : Create a simple satellite EO case from scratch
% This is a downward-looking radiance calculation.
close all
clear classes
% This case is visible/near-infared (VIS/NIR) wavelengths
Sat1 = Mod5;    % Get a completely empty case instance
% Set up name and short description
Sat1 = Sat1.SetCaseName('Sat1'); % The SetCaseName method is the only way to set the CaseName property
Sat1.CaseDescr = 'Example 2 : Simple EO Camera Case';

% Note that if a card is required, ALL parameters on that card must be set,
% even if the parameters are not used.

% Set up Card 1 (mandatory - main radiative transport)
Sat1.MODTRN = 'M';     % MODTRAN band model
Sat1.SPEED = 'S';      % Slow algorithm
Sat1.MODEL = 3;        % Mid-latitude winter canned atmosphere 
Sat1.ITYPE = 3;        % Slant path to ground
Sat1.IEMSCT = 2;       % Compute path radiance, including solar scatter 
Sat1.IMULT = -1;       % Include multiple scatter, computed at H2 (target/pixel)
Sat1.M1 = 0;           % Temperature/pressure default to MODEL (Mid-latitude winter profile)
Sat1.M2 = 0;           % Water vapor defaults to MODEL profile
Sat1.M3 = 0;           % Ozone defaults to MODEL profile
Sat1.M4 = 0;           % Methane defaults to MODEL profile
Sat1.M5 = 0;           % Nitrous oxide defaults to MODEL profile
Sat1.M6 = 0;           % Carbon monoxide defaults to MODEL profile
Sat1.MDEF = 0;         % Default O2, NO, SO2, NO2, NH3, and HNO3 species profiles.
Sat1.IM = 0;           % Normal program operation - no user input for profiles
Sat1.NOPRNT = 0;       % Minimize printing to Tape6 output file
Sat1.TPTEMP = 0;       % Temperature at H2 - not important, only VIS/NIR
Sat1.SURREF = '0.5';   % Earth reflectance (albedo) 50% right across spectrum
% Note that the setting of Card 1 parameters can be accomplished in a single
% call to the Set method as follows :
% Sat1 = Sat1.Set('MODTRN', 'M','SPEED','S','MODEL', 3, 'ITYPE', 3, 'IEMSCT', 2, ...
%                 'IMULT', 0, 'M1', 0, 'M2', 0, 'M3', 0, 'M4', 0, 'M5', 0 , 'M6', 0, ...
%                 'MDEF', 0, 'IM', 0, 'NOPRNT', 1, 'TPTEMP', 0, 'SURREF', '0.5');


% Set up Card 1A (mandatory - main radiative transport continued)
Sat1.DIS = 'f';        % Not using DISORT multiple scattering algorithm
Sat1.DISAZM = 'f';     % Therefore also not using azimuth dependence in DISORT
Sat1.NSTR = 2;         % Isaacs 2-stream multiple scattering model
Sat1.LSUN = 'f';       % Use default 5 cm^-1 TOA solar irradiance data
Sat1.ISUN = 0;         % Don't smooth the solar irradiance data before use
Sat1.CO2MX = 370;      % CO2 mixing ratio, 370 ppm by volume
Sat1.H2OSTR = '0.';    % No scaling of canned water vapor profile (MODEL/M2)
Sat1.O3STR = '0.';     % No scaling of canned ozone profile (MODEL/M3)
Sat1.LSUNFL = 'f';     % Don't read alternative solar irradiance data
Sat1.LBMNAM = 'f';     % Don't read alternative band model file
Sat1.LFLTNM = 't';     % Must read filter file specified
Sat1.H2OAER = 'f';     % Don't bother to modify aerosol properties on the basis of H2OSTR
Sat1.SOLCON = -1;      % Unity scaling of TOA solar irradiance, but apply seasonal correction

% Deal with EO camera band filters
% Create two bandpass filters with gaussian edges
Sat1Flt = Mod5.CreateFlt('N Synthetic Spectral Filters', ...
        {'Blue Filter', 'Green Filter'}, ... % Filter descriptions
        [450            550          ], ...  % Centre wavelengths (nm)
        [40             50           ], ...  % FWHMs
        {'gauss'}                     , ...  % Both gaussian shape
        [], ... % Default number of samples (nSamples)
        [], ... % Default edge value (EdgeVal)
        [30             20], ...  % FlatTopWidth of 30 nm and 20 nm respectively
        [0.8            0.9]);    % Peak transmittance of 0.8 and 0.9 respectively
% Plot the filters
Mod5.PlotFlt(Sat1Flt);
% And attach the EO camera filters to the case
Sat1 = Sat1.AttachFlt(Sat1Flt); % This will automatically set FILTNM (Card 1A3)

% Set up Card 2 (mandatory - main aerosol and cloud options)
Sat1.APLUS = '  ';     % Don't use flexible aerosol manipulations
Sat1.IHAZE = 1;        % Rural aerosol model, visibility = 23 km (modified below)
Sat1.CNOVAM = ' ';     % Don't invoke NOVAM
Sat1.ISEASN = 0;       % Use default seasonal aerosol tweaking
Sat1.ARUSS = '   ';    % Don't use extended user-defined aerosol facility
Sat1.IVULCN = 0;       % Background stratospheric aerosol profile
Sat1.ICSTL = 1;        % Continental influence of maritime aerosols - not applicable to this case
Sat1.ICLD = 0;         % No clouds or rain
Sat1.IVSA = 0;         % Don't use Army Vertical Structure Algorithm for boundary layer aerosols
Sat1.VIS = 18;         % km. Reduce visibility, scales up aerosol amount in boundary layer
Sat1.WSS = 0;          % Use default wind speed for named MODEL
Sat1.WHH = 0;          % Use default 24 hr average wind speed for named MODEL
Sat1.RAINRT = 0;       % Rain rate is zero (mm/hour), anyway no cloud/rain (ICLD)
Sat1.GNDALT = 0;       % Target surface (H2) is at sea level

% Set up Card 3 (mandatory - Line of sight geometry)
% To define path (LOS) geometry in this case use PHI, H1 and H2 (combination 3c in manual)
Sat1.H1 = 0;           % Not used in this case - we are using a slant path to space
Sat1.H2 = 0;           % km. Target pixel is at sea level
Sat1.ANGLE = 0;        % Not used in this case. (Zenith angle at H1)
Sat1.RANGE = 0;        % Not used in this case. Path length.
Sat1.BETA = 0;         % Not used in this case. Earth centre angle.
Sat1.RO = 0;           % Not used in this case. Radius of the Earth, will default to a reasonable value.
Sat1.LENN = 0;         % Not used in this case. Short path/long path switch.
Sat1.PHI = 10;         % degrees. Zenith angle at H2 (pixel/target) to H1 (satellite camera)

% Set up Card 3A1 (Solar scattering geometry, required for IEMSCT = 2)
Sat1.IPARM = 12;       % Will specify relative solar azimuth angle and solar zenith angle below (PARM1 and PARM2)
Sat1.IPH = 2;          % Use Mie-generated internal database for aerosol phase functions
Sat1.IDAY =[2009 11 2];% Compute day number corresponding to 2 Nov 2009 (works out as IDAY = 306).
Sat1.ISOURC = 0;       % The Sun is the extraterrestrial source of scattered radiation

% Set up Card 3A2 (Solar scattering geometry, also required for IEMSCT = 2)
Sat1.PARM1 = 50;       % deg. The Sun azimuth is 50 deg East of LOS azimuth (H2 to H1)
Sat1.PARM2 = 20;       % deg. Sun zenith angle at H2 (target/pixel).
Sat1.PARM3 = 0;        % Not used in this case.
Sat1.PARM4 = 0;        % Not used in this case.
Sat1.TIME = 0;         % Not used in this case.
Sat1.PSIPO = 0;        % Not used in this case.
Sat1.ANGLEM = 0;       % Not used in this case.
Sat1.G = 0;            % Not used in this case. (Henyey-Greenstein asymmetry parameter)
% An alternative way of setting up cards 3A1 and 3A2 (shortwave source scattering geometry)
% is to use the method SetScatGeom defined as follows:
%   MC = MC.SetScatGeom(IPARM, IDAY, ISOURC, PARM, TIME, PSIPO, ANGLEM)
% In this case, the call would be :
%   Sat1 = Sat1.SetScatGeom(12, [2009 11 2], 0, [50 20]);
% (TIME, PSIPO and ANGLEM are not used and will be set 0 by SetScatGeom)
% Note that IPH must still be set explicitly, as well as G.

% Set up Card 4 (mandatory - spectral range and resolution)
Sat1.V1 = 350;         % Start of spectral computation range in nm (see FLAGS(1))
Sat1.V2 = 650;         % End of spectral computation range in nm
Sat1.DV = 0.1;         % Spectral increment in nm
Sat1.FWHM = 2;         % Convolution filter width in nm
Sat1.YFLAG = ' ';      % Not going to generate .plt or .psc files
Sat1.XFLAG = ' ';      % Not going to generate .plt or .psc files
Sat1.FLAGS(1) = 'N';   % Use nanometres for spectral units (FLAGS(1)).
Sat1.FLAGS(4) = 'A';   % Put ALL radiance components in convolved data (tp7)
% An alternative way of setting up (most of) Card 4 is to use the SetSpectralRange method
% The call looks as follows:
%   MC = MC.SetSpectralRange(V1, V2, DV, FWHM, Units, ConvShape, FWHMisRelative)
% and in this case would look as follows :
%   Sat1 = Sat1.SetSpectralRange(350, 650, 0.1, 2, 'N');
% (ConvShape and FWHMisRelative are not required)
% Note that it will still be necessary to set FLAGS(4) as this is not done
% by SetSpectralRange. YFLAG, XFLAG and DLIMIT can be set using the
% SetPlot method.

% Set up Card 5 (mandatory - Repeat option)
Sat1.IRPT = 0;         % Stop program, only one sub-case in this run

% Now run the case (execute MODTRAN on the case)
Sat1 = Sat1.Run;

% Examine the file Sat1.tp6 to check the integrity of the run.
% The results are in the property fields Sat1.tp7, Sat1.sc7 and Sat1.chn
% Sat1.tp7 is the raw (unconvolved) radiance and transmittance data expressed as
% a function of wavenumber at full MODTRAN spectral resolution (lots of points).
% Sat1.chn contains the spectral channel (band) data for the camera filters.
% The convolved data as a function of wavelength in nm is in property Sat1.sc7.

% Plot the Sat1.sc7 (convolved, wavelength in nm) data
Sat1.PlotSc7({'SOLSCAT','SINGSCAT', 'GRNDRFLT','DRCTRFLT', 'TOTALRAD'});

% Plot some of the raw data for interest, single scattered path radiance, direct reflected and total radiance
Sat1.PlotTp7({'SINGSCAT', 'DRCTRFLT', 'TOTALRAD'});

%% Example 3 : Direct Solar Irradiance Case
close all
clear classes
% This case is visible/near-infared (VIS/NIR) wavelengths
Sol1 = Mod5;    % Get an empty case instance
% Set up name and short description
Sol1 = Sol1.SetCaseName('Sol1'); % Must use SetCaseName method to set name
Sol1.CaseDescr = 'Example 3 : Solar Irradiance Case';

% Set up Card 1 (mandatory - main radiative transport)
Sol1 = Sol1.Set('MODTRN', 'M','SPEED','S','MODEL', 2, 'ITYPE', 3, 'IEMSCT', 3, ...
                'IMULT', 0, 'M1', 0, 'M2', 0, 'M3', 0, 'M4', 0, 'M5', 0 , 'M6', 0, ...
                'MDEF', 0, 'IM', 0, 'NOPRNT', 1, 'TPTEMP', 0, 'SURREF', '0.0');

% Set up Card 1A (mandatory - supplementary radiative transport parameters)
Sol1 = Sol1.Set('DIS', 'f', 'DISAZM', 'f', 'NSTR', 2, 'LSUN', 'f', 'ISUN', 5, ...
                'CO2MX', 370, 'H2OSTR', '', 'O3STR', '', 'LSUNFL', 'f', ...
                'LBMNAM', 'f', 'LFLTNM', 'f', 'H2OAER', 'f', 'SOLCON', 0);

% Set up Card 2 (mandatory - main aerosol and cloud options)
% IHAZE = 1 for rural extinction, VIS = 23 km, no clouds or rain
% Ground altitude of 1400 m
Sol1 = Sol1.Set('APLUS', '  ', 'IHAZE', 1, 'CNOVAM', ' ', 'ISEASN', 0, 'ARUSS', '   ', ...
                'IVULCN', 0, 'ICSTL', 0, 'ICLD', 0, 'IVSA', 0, 'VIS', 0, 'WSS', 0, ...
                'WHH', 0, 'RAINRT', 0, 'GNDALT', 1.4);

% Set up Alternate Card 3 (mandatory for solar irradiance cases, IEMSCT = 3)
% Line-of-sight geometry, solar zenith angle of 30 degrees, observer altitude 1.4 km
Sol1 = Sol1.Set('H1', 1.4, 'H2', 0, 'ANGLE', 30, 'IDAY', [2010 2 22], 'RO', 0, ...
                'ISOURC', 0, 'ANGLEM', 0);
              
% Set up Card 4 (mandatory - Spectral Range and Resolution)
Sol1 = Sol1.Set('V1', 350, 'V2', 1000, 'DV', 0.5, 'FWHM', 2, 'YFLAG', ' ', ...
                'XFLAG', ' ', 'DLIMIT', '', 'FLAGS', 'NGA    ');

% Set up Card 5 (mandatory - Repeat Run Option)
Sol1.IRPT = 0; % Stop program

% Run MODTRAN
Sol1 = Sol1.Run;

% The solar irradiance at H1 will be in Sol1.tp7.SOLTR (unconvolved)
% and in Sol1.sc7.SOLTR (convolved with Gaussian filter of 2 nm FWHM)

% Plot the transmitted solar irradiance (convolved)
Sol1.PlotSc7('SOLTR');

% Compute the integrated transmitted solar irradiance in the band (350 to 1000 nm)
TotalSolar = trapz(Sol1.sc7.FREQNM, Sol1.sc7.SOLTR);

% Create a series of cases based on Sol1 with solar zenith angles of 0 and 40 deg,
% and with visibilities of 10 and 20 km
Sol1 = Sol1.CreateSeries('ANGLE', {0 40}, 'VIS', {10 20});

% Run MODTRAN on the series
Sol1 = Sol1.Run;

% Plot the transmitted solar irradiance for the whole series on a single graph
Sol1.PlotSc7('SOLTR');
% The legends are :
% Sol1(1) :  0 deg zenith angle, 10 km visibility
% Sol1(2) : 40 deg zenith angle, 10 km visibility
% Sol1(3) :  0 deg zenith angle, 20 km visibility
% Sol1(4) : 40 deg zenith angle, 20 km visibility
%% Example 4 : Thermal Spectrum Transmittance Case with Partially User-Defined Atmosphere
% H1 = 0, H2 = 3 km, RANGE = 200 km
% Spectral range is 800 cm^-1 to 4000 cm^-1 (12.5 µm down to 2.5 µm)
% This case could be for calculating transmission to an airborne platform
% at a specific altitude (H2 = 3 km), at various slant ranges from the observer,
% where the observer is also at a specific altitude (H1 = sea level). 
close all
clear classes
% Determine the directory in which the Mod5 archive was extracted
MCDir = fileparts(which('Mod5'));
% Load the case
Ex4 = Mod5([MCDir '\Ex4.ltn']);

% Plot all user-defined atmospheric data for this case
Ex4.PlotAtm('all');

% Create a sensitivity series with path length of 5 km, 20 km and 80 km
% and with scaling of water vapor to 50% and 100% of specified amount.
Ex4 = Ex4.CreateSeries('RANGE', {5 20 40}, 'H2OSTR', {'0.5', '1.0'});

% Run the case
Ex4 = Ex4.Run;

% Plot total transmission
Ex4.PlotTp7('TRANS');
% The combinations plotted are as follows
% Ex4(1) is RANGE =  5 km and H2OSTR = '0.5'
% Ex4(2) is RANGE = 20 km and H2OSTR = '0.5'
% Ex4(3) is RANGE = 40 km and H2OSTR = '0.5'
% Ex4(4) is RANGE =  5 km and H2OSTR = '1.0'
% Ex4(5) is RANGE = 20 km and H2OSTR = '1.0'
% Ex4(6) is RANGE = 40 km and H2OSTR = '1.0'
%% Example 5 : Transmittance, USS (user-supplied aerosol upgrade)
% This example is derived from the case given at the end of
% Appendix A in the MODTRAN 4 User's Manual.
close all
clear classes
% Determine the directory in which the Mod5 archive was extracted
MCDir = fileparts(which('Mod5'));
% Load the case
Ex5 = Mod5([MCDir '\CaseUSS.ltn']);
% Run the case
Ex5 = Ex5.Run;
% Plot transmittance
Ex5.PlotTp7('TRANS');

%% Example 6 : Downward looking EO radiance case
% This example reads SensorML (Sensor Markup Language) spectral channel
% filter definitions for a set of MERIS channels
close all
clear classes
% Determine the directory in which the Mod5 archive was extracted
MCDir = fileparts(which('Mod5'));
% This case is visible/near-infared (VIS/NIR) wavelengths
Sat2 = Mod5;    % Get a completely empty case instance
% Set up name and short description
Sat2 = Sat2.SetCaseName('Sat2');
Sat2.CaseDescr = 'Example 6 : EO Camera Case';

% Set up Card 1 (mandatory - main radiative transport)
% Tropical atmosphere
% Will specify a lambertian target on Card 4L2 later
Sat2 = Sat2.Set('MODTRN', 'M','SPEED','S','MODEL', 1, 'ITYPE', 3, 'IEMSCT', 2, ...
                'IMULT', 0, 'M1', 0, 'M2', 0, 'M3', 0, 'M4', 0, 'M5', 0 , 'M6', 0, ...
                'MDEF', 0, 'IM', 0, 'NOPRNT', 1, 'TPTEMP', 0, 'SURREF', 'LAMBER');
              
% Set up Card 1A (mandatory - main radiative transport continued)
Sat2 = Sat2.Set('DIS', 'f', 'DISAZM', 'f', 'NSTR', 2, 'LSUN', 'f', 'ISUN', 0, 'CO2MX', 380, 'H2OSTR', '0.', ...
                'O3STR', '0.', 'LSUNFL', 'f', 'LBMNAM', 'f', 'LFLTNM', 't', 'H2OAER', 'f', 'SOLCON', -1);
              
% Deal with MERIS camera band filters
% Read the filters from the SensorML description of MERIS
Sat2Flt = Mod5.ReadFltFromSensorML([MCDir '\CalVal_ENVISAT_MERIS_v01.xml']);
% Only want the first 15 filters for camera 1
Sat2Flt.FilterHeaders = Sat2Flt.FilterHeaders(1:15);
% Display the channel descriptions
disp(strvcat(Sat2Flt.FilterHeaders));
Sat2Flt.Filters = Sat2Flt.Filters(1:15); % Extract the filters
% Plot the filters
Mod5.PlotFlt(Sat2Flt);

% And attach the EO camera filters to the case
Sat2 = Sat2.AttachFlt(Sat2Flt); % This will automatically set FILTNM (Card 1A3)

% Set up Card 2 (mandatory - main aerosol and cloud options)
% IHAZE = 3 for navy maritime extinction, VIS = 15 km, no clouds or rain
% ICSTL = 5 for moderate influence from continental aerosols
% Current wind speed and mean wind speed over last 24 hours, WSS = WHH = 5 m/s
Sat2 = Sat2.Set('APLUS', '  ', 'IHAZE', 3, 'CNOVAM', ' ', 'ISEASN', 0, 'ARUSS', '   ', ...
                'IVULCN', 0, 'ICSTL', 5, 'ICLD', 0, 'IVSA', 0, 'VIS', 15, 'WSS', 5, ...
                'WHH', 5, 'RAINRT', 0, 'GNDALT', 0);
              
% Set up Card 3 (mandatory - Line of sight geometry)
% To define path (LOS) geometry in this case use PHI, H1 and H2 (combination 3c in manual)
Sat2 = Sat2.Set('H1', 0, 'H2', 0, 'ANGLE', 0, 'RANGE', 0, 'BETA', 0, 'RO', 0, 'LENN', 0, 'PHI', 10);


% Set up Card 3A1 and 3A2 (Solar scattering geometry, required for IEMSCT = 2) 
% First set phase function and asymmetry parameter on Card 3A2 to avoid a warning.
% Phase function IPH = 2 for internal Mie database, G is not used
Sat2 = Sat2.Set('IPH', 2, 'G', 0);
% Will use SetScatGeom method, which looks as follows
%   MC = MC.SetScatGeom(IPARM, IDAY, ISOURC, PARM, TIME, PSIPO, ANGLEM)
% IPARM = 12 for solar zenith angle and azimuth
% IDAY is set from the date, ISOURC = 0 for the Sun
% Relative zenith angle is 15 deg, relative azimuth is 90 deg (with respect to LOS)
Sat2 = Sat2.SetScatGeom(12, [2010 6 1], 0, [90 15]);

% Set up Card 4 (mandatory - spectral range and resolution)
% Will use SetSpectralRange and the call looks as follows:
%   MC = MC.SetSpectralRange(V1, V2, DV, FWHM, Units, ConvShape, FWHMisRelative)
% and in this case would look as follows :
Sat2 = Sat2.SetSpectralRange(400, 1000, 1, 2, 'N');
% Just need to set FLAGS(4) to get all radiance components in tp7
Sat2.FLAGS(4) = 'A';   % Put ALL radiance components in convolved data (tp7)
% Must also set the plot-related Card 4 stuff
Sat2 = Sat2.SetPlot(' ', ' ', ''); % Set XFLAG, YFLAG and DLIMIT blank for no plot files


% Card 4A is required because SURREF was set to 'LAMBER' on Card 1
Sat2.NSURF = 1; % See MODTRAN manual for explanation
Sat2.AATEMP = 0; % Not used

% Read open ocean albedo from USGS splib06a
OceanAlb = Mod5.ReadAlbFromUSGS([MCDir '\seawater_open_ocean_sw2.27262.asc']);
% Reduce the ocean albedo curve to 30 points in the 0.4 micron to 1 micron spectral region
OceanAlbSparse = Mod5.InterpAlb(OceanAlb, [0.4 1], 30);
% Plot original and sparse data
Mod5.PlotAlb([OceanAlb; OceanAlbSparse], [0.4 1 0 0.05]);
% Read a tree leaf reflectance from ASD data
TreeAlb = Mod5.ReadAlbFromASD([MCDir '\tree100001.asd.ref.txt']);
% Reduce tree albedo to 49 points
TreeAlbSparse = Mod5.InterpAlb(TreeAlb, [0.4 1], 49);
% Plot tree albedo to see any difference in reduced set
Mod5.PlotAlb([TreeAlb; TreeAlbSparse], [0.4 1 0 0.6]);

% Combine the two albedo curves into one structure
OcTreeAlb = [OceanAlbSparse; TreeAlbSparse];
% Plot the albedo data in the 350 nm to 1000 nm range
Mod5.PlotAlb(OcTreeAlb, [0.4 1 0 0.6]);

% Replicate the case to make two identical sub-cases
Sat2 = Sat2.Replicate([1 2]); % Row vector of two cases

% Attach the albedo data, ocean to the first sub-case and tree to the second sub-case
Sat2 = Sat2.AttachAlb(OcTreeAlb, [1 2]); % 1 means ocean, 2 means tree

% Now run the case
Sat2 = Sat2.Run;

% Plot the spectral channel output for ocean and tree ...
Sat2.PlotChn;

%----------End Example 6--------------