% Mod5 MODTRAN 5 Case Examples
% $Id: Mod5Examples.m,v 853b3a7dbe50 2014/12/11 10:22:33 dgriffith $
% Copyright 2010, $Author: dgriffith $
%
% Each cell in this script contains a single example. Run examples
% individually by clicking somewhere in the cell and then clicking on the
% "Evaluate Cell" icon on the toolbar.
%
% WARNING : All examples clear variables and close all plots. You
%           will lose all workspace variables.
disp('This script contains one cell per example. Run each cell individually.')
% For reference, here are some of the definitions of MODTRAN outputs:
% Original Source : Ontar 
% http://www.ontar.com/Software/ContentPage.aspx?item=support_faq_pcmodwin_000005 
%
% TRANS - Total transmission through defined path. For example one would
% assume that for a downward looking path from H1 to H2, the transmittance
% is from H1 to H2. For calculation of reflected solar component, one could
% always use the layer by layer transmittance to calculate the total
% attenuation through both the downwelling and upwelling paths.

% PTHTHRML - Radiance component due to the atmosphere received at the
% observer. This term includes the THRMLSCT component which will be 0.0 if
% multiple scattering is not running.

% SOLSCAT - Component of scattered solar radiance received at the observer.
% This term includes the SINGSCAT component.

% GRNDRFLT - GRNDRFLT is the total (direct + diffuse) solar flux impingent
% on the ground and reflected directly to the sensor from the ground. Thus,
% GRNDRFLT = DRCTRFLT + Diffuse Reflected. If the downward solar flux is
% dominated by the direct term, GRND and DRCT will be equal (Lex Burke,
% email 15-Dec-2003). In practice the Diffuse Reflected term will only be
% significant (non-zero) if multiple scattering is selected.

% TOTALRAD = PTHTHRML + SURFEMIS + SOLSCAT + GRNDRFLT

% REFSOL - REFSOL is the top-of-atmosphere solar irradiance times the
% L-shaped path from the sun-to-H2-to-H1. If H2 is the ground, the DRCTRFLT
% is simply the REFSOL times the surface BRDF over pi steradians (Lex
% Burke, email 15-Dec-2003).

% SOLOBS - Total Solar irradiance at the observer. Believe this is
% similar to the REFSOL, but also includes a contribution from the SOLSCAT
% term.
return;
%% Example 1 : Load a Mod5 from a tape5 format file, run it and plot
% This example is a 5 km horizontal path just above sea level
close all
clear variables
% Set parallel friendly mode (allows multiple MODTRAN cases to run in parallel
% on the same computer without a conflict.
Mod5.ParallelFriendly(true);
% Determine the directory in which the Mod5 archive was extracted
MCDir = fileparts(which('Mod5'));
% Load the case
Ex1 = Mod5([MCDir filesep 'Ex1.ltn']);
Ex1.CaseDescr = '5 km Horizontal Path at Sea Level';
% Run the case
Ex1 = Ex1.Run;
% Plot total transmission and water transmission
Ex1.PlotTp7({'COMBINTRANS', 'H2OTRANS'});
Ex1.PlotSc7; % Plot the convolved total transmittance on a wavelength scale 
%% Example 2 : Create a simple satellite EO case from scratch
% This is a downward-looking radiance calculation.
close all
clear variables
% Set parallel friendly mode (allows multiple MODTRAN cases to run in parallel
% on the same computer without a conflict.
Mod5.ParallelFriendly(true);
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
Sat1.BINARY = 'f';     % Output will be ASCII
Sat1.LYMOLC = ' ';     % Exclude 16 auxiliary trace gases
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
Sat1.I_RD2C = 0;       % Normal program operation - no user input for profiles
Sat1.NOPRNT = 0;       % Minimize printing to Tape6 output file
Sat1.TPTEMP = 0;       % Temperature at H2 - not important, only VIS/NIR
Sat1.SURREF = '0.5';   % Earth reflectance (albedo) 50% right across spectrum
% Note that the setting of Card 1 parameters can be accomplished in a single
% call to the Set method as follows :
% Sat1 = Sat1.Set('MODTRN', 'M','SPEED', 'S', 'BINARY', 'f', 'LYMOLC', ' ','MODEL', 3, 'ITYPE', 3, 'IEMSCT', 2, ...
%                 'IMULT', 0, 'M1', 0, 'M2', 0, 'M3', 0, 'M4', 0, 'M5', 0 , 'M6', 0, ...
%                 'MDEF', 0, 'I_RD2C', 0, 'NOPRNT', 1, 'TPTEMP', 0, 'SURREF', '0.5');


% Set up Card 1A (mandatory - main radiative transport continued)
Sat1.DIS = 'f';        % Not using DISORT multiple scattering algorithm
Sat1.DISAZM = 'f';     % Therefore also not using azimuth dependence in DISORT
Sat1.DISALB = 'f';     % Don't calculate atmospheric correction data
Sat1.NSTR = 2;         % Isaacs 2-stream multiple scattering model
Sat1.SFWHM = 0;        % Default solar irradiance data
Sat1.CO2MX = 370;      % CO2 mixing ratio, 370 ppm by volume
Sat1.H2OSTR = '0.';    % No scaling of canned water vapor profile (MODEL/M2)
Sat1.O3STR = '0.';     % No scaling of canned ozone profile (MODEL/M3)
Sat1.C_PROF = '0';     % No scaling of default molecular species profiles
Sat1.LSUNFL = 'f';     % Don't read alternative solar irradiance data
Sat1.LBMNAM = 'f';     % Don't read alternative band model file
Sat1.LFLTNM = 't';     % Must read filter file specified
Sat1.H2OAER = 'f';     % Don't bother to modify aerosol properties on the basis of H2OSTR
Sat1.CDTDIR = 'f';     % Data files are in the default location
Sat1.SOLCON = -1;      % Unity scaling of TOA solar irradiance, but apply seasonal correction
Sat1.CDASTM = ' ';     % No Angstrom law manipulations
% Not really necessary to set the Angstrom law data since it will not be
% used
% Sat1.ASTMC
% Sat1.ASTMX
% Sat1.ASTMO
% Sat1.AERRH
Sat1.NSSALB = 0;       % Use reference aerosol single-scattering albedo

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

% Plot a few of the channel outputs
Sat1.PlotChn({'PATH_TOTAL_SCAT_SOLAR','TOTAL_TRANSM_GRND_REFLECT'})

%% Example 3 : Direct Solar Irradiance Case
close all
clear variables
% Set parallel friendly mode (allows multiple MODTRAN cases to run in parallel
% on the same computer without a conflict.
Mod5.ParallelFriendly(true);
% This case is visible/near-infared (VIS/NIR) wavelengths
Sol1 = Mod5;    % Get an empty case instance
% Set up name and short description
Sol1 = Sol1.SetCaseName('Sol1'); % Must use SetCaseName method to set name
Sol1.CaseDescr = 'Example 3 : Solar Irradiance Case';

% Set up Card 1 (mandatory - main radiative transport)
Sol1 = Sol1.Set('MODTRN', 'M','SPEED','S','BINARY', 'F', 'LYMOLC', ' ', 'MODEL', 2, 'ITYPE', 3, 'IEMSCT', 3, ...
                'IMULT', 0, 'M1', 0, 'M2', 0, 'M3', 0, 'M4', 0, 'M5', 0 , 'M6', 0, ...
                'MDEF', 0, 'I_RD2C', 0, 'NOPRNT', 1, 'TPTEMP', 0, 'SURREF', '0.0');

% Set up Card 1A (mandatory - supplementary radiative transport parameters)
Sol1 = Sol1.Set('DIS', 'f', 'DISAZM', 'f', 'DISALB', ' ', 'NSTR', 2, 'SFWHM', 5, ...
                'CO2MX', 370, 'H2OSTR', '', 'O3STR', '', 'C_PROF', ' ', 'LSUNFL', 'f', ...
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
TotalSolar = trapz(Sol1.sc7.WAVLNM, Sol1.sc7.SOLTR);

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
% H1 = 0, H2 = 3 km, RANGE = 5 km to 40 km
% Spectral range is 800 cm^-1 to 4000 cm^-1 (12.5 µm down to 2.5 µm)
% This case could be for calculating transmission to an airborne platform
% at a specific altitude (H2 = 3 km), at various slant ranges from the observer,
% where the observer is also at a specific altitude (H1 = sea level). 
close all
clear variables
% Determine the directory in which the Mod5 archive was extracted
MCDir = fileparts(which('Mod5'));
% Load the case
Ex4 = Mod5([MCDir filesep 'Ex4.tp5']);
% Plot all user-defined atmospheric data for this case
Ex4.PlotAtm('all');

% Create a sensitivity series with path length of 5 km, 20 km and 40 km
% and with scaling of water vapor to 50% and 100% of specified amount.
Ex4 = Ex4.CreateSeries('RANGE', {5 20 40}, 'H2OSTR', {'0.5', '1.0'});

% Run the case
Ex4 = Ex4.Run;

% Plot total transmission
Ex4.PlotTp7('COMBINTRANS');
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
clear variables
% Determine the directory in which the Mod5 archive was extracted
MCDir = fileparts(which('Mod5'));
% Load the case
Ex5 = Mod5([MCDir filesep 'CaseUSS.ltn']);
% Run the case
Ex5 = Ex5.Run;
% Plot transmittance
Ex5.PlotTp7('COMBINTRANS');

%% Example 6 : Downward looking EO radiance case
% This example reads SensorML (Sensor Markup Language) spectral channel
% filter definitions for a set of MERIS channels
close all
clear variables
% Set parallel friendly mode (allows multiple MODTRAN cases to run in parallel
% on the same computer without a conflict.
Mod5.ParallelFriendly(true);
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
Sat2 = Sat2.Set('MODTRN', 'M','SPEED','S','BINARY', 'F', 'LYMOLC', ' ','MODEL', 1, 'ITYPE', 3, 'IEMSCT', 2, ...
                'IMULT', 0, 'M1', 0, 'M2', 0, 'M3', 0, 'M4', 0, 'M5', 0 , 'M6', 0, ...
                'MDEF', 0, 'I_RD2C', 0, 'NOPRNT', 1, 'TPTEMP', 0, 'SURREF', 'LAMBER');
              
% Set up Card 1A (mandatory - main radiative transport continued)
Sat2 = Sat2.Set('DIS', 'f', 'DISAZM', 'f', 'DISALB', ' ', 'NSTR', 2, 'SFWHM', 0, 'CO2MX', 380, 'H2OSTR', '0.', ...
                'O3STR', '0.', 'C_PROF', ' ', 'LSUNFL', 'f', 'LBMNAM', 'f', 'LFLTNM', 't', ...
                'H2OAER', 'f', 'CDTDIR',' ','SOLCON', -1, 'CDASTM', ' ','ASTMC',0, 'ASTMX',0,'ASTMO',0,'AERRH',0, 'NSSALB', 0);
              
% Deal with MERIS camera band filters
% Read the filters from the SensorML description of MERIS
Sat2Flt = Mod5.ReadFltFromSensorML([MCDir filesep 'CalVal_ENVISAT_MERIS_v01.xml']);
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
OceanAlb = Mod5.ReadAlbFromUSGS([MCDir filesep 'seawater_open_ocean_sw2.27262.asc']);
% Reduce the ocean albedo curve to 30 points in the 0.4 micron to 1 micron spectral region
OceanAlbSparse = Mod5.InterpAlb(OceanAlb, [0.4 1], 30);
% Plot original and sparse data
Mod5.PlotAlb([OceanAlb; OceanAlbSparse], [0.4 1 0 0.05]);
% Read a tree leaf reflectance from ASD data
TreeAlb = Mod5.ReadAlbFromASD([MCDir filesep 'tree100001.asd.ref.txt']);
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
Sat2.PlotChn('SPECTRAL_RADIANCE');

%----------End Example 6--------------

%% Example 7 : Horizontal Near Ground Path at Pretoria
% This example computes horizontal path transmittance and radiance over a
% grassland surface.
clear all
close all
PtaMidSummer = Mod5; % Get a blank case
PtaMidSummer = PtaMidSummer.SetCaseName('PtaMidSummer');
% Card 1 : Main Radiation and Transport Driver, Model, Algorithm, Mode
PtaMidSummer.MODTRN = 'T'; % The Spectral Band Model is the MODTRAN Band Model.
PtaMidSummer.SPEED = ' '; % The 'slow' speed Correlated-k algorithm using 33 absorption coefficients (k values) per spectral bin (1 cm^{-1}or 15 cm^{-1}). This option is recommended for upper altitude (> 40 km) cooling-rate and weighting-function calculations only.
PtaMidSummer.BINARY = ' '; % All MODTRAN outputs will be ASCII text files.
PtaMidSummer.LYMOLC = ' '; % Atmospheric model excludes 16 auxiliary trace gas species.
PtaMidSummer.MODEL = 1; % Tropical Atmosphere
PtaMidSummer.ITYPE = 2; % Slant path between two altitudes
PtaMidSummer.IEMSCT = 2; % MODTRAN will compute spectral transmittance and radiance of the LOS.
PtaMidSummer.IMULT = 1; % MODTRAN executes with computation of multiple scattering.
PtaMidSummer.M1 = 0; % Temperature and Pressure profiles default to whatever is specified by parameter MODEL above.
PtaMidSummer.M2 = 0; % Water vapour profile defaults to whatever is specified by parameter MODEL above.
PtaMidSummer.M3 = 0; % Ozone (O_3) profile defaults to whatever is specified by parameter MODEL above.
PtaMidSummer.M4 = 0; % Methane (CH_4) profile defaults to whatever is specified by parameter MODEL above.
PtaMidSummer.M5 = 0; % Nitrous Oxide (N_20) profile defaults to whatever is specified by parameter MODEL above.
PtaMidSummer.M6 = 0; % Carbon Monoxide (C0) profile defaults to whatever is specified by parameter MODEL above.
PtaMidSummer.MDEF = 0; % Default O2, NO, SO2, NO2, NH3, and HNO3 species profiles as well as default heavy species.
PtaMidSummer.I_RD2C = 0; % For canned atmospheres or when calculations are to be run with the user-defined atmosphere last read in.
PtaMidSummer.NOPRNT = 0; % Normal output operation of program; normal tape6 (PtaMidSummer.tp6) output.
PtaMidSummer.TPTEMP = 0; % No surface emission contributed at H2 (far end from sensor/observer) if H2 is above ground.
PtaMidSummer.SURREF = 'LAMBER'; % Albedo of the earth is lambertian, set later in the script
% Card 1A : Main Radiation and Transport Driver, Multi-Scatter, Solar, CO2
PtaMidSummer.DIS = 't'; % Use the DISORT solver
PtaMidSummer.DISAZM = 'f'; % DISORT will run with azimuth dependent multiple scattering switched off.
PtaMidSummer.DISALB = ' '; % Atmospheric correction data will not be computed.
PtaMidSummer.NSTR = 8; % DISORT will execute with this number of streams.
PtaMidSummer.SFWHM = 0; % The FWHM (Full Width at Half Maximum) of the triangular scanning function used to smooth the TOA solar irradiance (wavenumbers).
PtaMidSummer.CO2MX = 380; % The CO_2 mixing ratio in ppmv (parts per million by volume)
PtaMidSummer.H2OSTR = '    g 2.0 '; % Vertical water vapor column modifier (g/cm^{2}, atm-cm or scaling factor).
PtaMidSummer.O3STR = '          '; % Vertical ozone column modifier (g/cm^{2}, atm-cm or scaling factor).
PtaMidSummer.C_PROF = ' '; % There will be no scaling of default molecular profiles.
PtaMidSummer.LSUNFL = ' '; % If true, read solar irradiance from file named on Card 1A1.
PtaMidSummer.LBMNAM = ' '; % If true, read band model from file named on Card 1A2.
PtaMidSummer.LFLTNM = ' '; % If true, read instrument band filter data from file named on Card 1A3.
PtaMidSummer.H2OAER = ' '; % If true, humidity-based modifications are applied to the aerosols based on water column scaling (H2OSTR).
PtaMidSummer.SOLCON = 0; % Solar TOA irradiance is not scaled.
% Card 2 : Main Aerosol and Cloud Options, Turbidity, Rain, Ground Altitude
PtaMidSummer.APLUS = '  '; % Default aerosol layers and levels.
PtaMidSummer.IHAZE = 5; % URBAN extinction
PtaMidSummer.CNOVAM = ' '; % Navy Oceanic Vertical Aerosol Model (NOVAM) is not used in this run.
PtaMidSummer.ISEASN = 0; % Seasonal aerosol modification determined by the value of MODEL; SPRING-SUMMER for MODEL = 0, 1, 2, 4, 6, 7, 8 FALL-WINTER for MODEL = 3, 5.
PtaMidSummer.ARUSS = '   '; % Use built-in aerosol optical properties.
PtaMidSummer.IVULCN = 0; % BACKGROUND STRATOSPHERIC aerosol profile and extinction.
PtaMidSummer.ICSTL = 0; % Air mass aerosol character for IHAZE = 3. Use 1 for open ocean through to 10 for strong continental influence.
PtaMidSummer.ICLD = 0; % No clouds or rain.
PtaMidSummer.IVSA = 0; % This MODTRAN run does not use the Army Vertical Structure Algorithm (VSA) for aerosols in the boundary layer.
PtaMidSummer.VIS = 18; % User specified surface meteorological range (km). Overrides default range set by IHAZE.
PtaMidSummer.WSS = 0; % Current wind speed in m/s, used by maritime (IHAZE = 3) and desert (IHAZE = 10) aerosol models.
PtaMidSummer.WHH = 0; % Average wind speed in m/s over 24 hours, used by maritime (IHAZE = 3) aerosol model.
PtaMidSummer.RAINRT = 0; % Rain rate (mm/hr). The default value is zero for no rain. Used to top of cloud when cloud is present; when no clouds, rain rate used to 6km.
PtaMidSummer.GNDALT = 1.4; % Altitude of ground surface relative to sea level (km). GNDALT may be negative but may not exceed 6 km.
% Card 3 : Line-Of-Sight (LOS) Geometry, Heights, Zenith Angle, Range
% The Line of Sight (LOS) is a horizontal, so zenith ANGLE is set to 90 degrees 
PtaMidSummer.H1 = 1.41; % Initial path altitude in km.
PtaMidSummer.H2 = 0; % Not used, use zenith angle and range
PtaMidSummer.ANGLE = 89.0; % Initial zenith angle at H1 in degrees
PtaMidSummer.RANGE = 0.212; % Path length in km.
PtaMidSummer.BETA = 0; % Not used in this case. (Earth centre angle in degrees subtended by path from H1 to H2.)
PtaMidSummer.RO = 0; % Radius of the earth in km at the path latitude. Will default to a value depending on MODEL.
PtaMidSummer.LENN = 0; % Default short path - not extending through tangent height.
PtaMidSummer.PHI = 0; % Not used in this case. (Zenith angle in degrees at H2.)
% Card 3A1 : Solar/Lunar Scattering Geometry
PtaMidSummer.IPARM = 2; % Will specify relative solar azimuth and zenith angle
PtaMidSummer.IPH = 2; % Use internal Mie tables for phase functions 
PtaMidSummer.IDAY = 360; % Mid summer in southern hemisphere
PtaMidSummer.ISOURC = 0; % Sun
% Card 3A2 : Solar/Lunar Scattering Geometry cont.
PtaMidSummer.PARM1 = 52.2; % Relative azimuth of sun at target (target azimuth is 40, solar azimuth is 92.2)
PtaMidSummer.PARM2 = 28.8; % Solar zenith angle in degrees
PtaMidSummer.PARM3 = 0; % Not used
PtaMidSummer.PARM4 = 0; % Not used
PtaMidSummer.TIME = 0; % Not used
PtaMidSummer.PSIPO = 0; % Not used
PtaMidSummer.ANGLEM = 0; % Moon phase, not used
PtaMidSummer.G = 0; % Assymetry parameter, not used since Mie database specified
% Card 4 : Spectral Range and Resolution
PtaMidSummer.V1 = 400; % Starting wavelength in nanometres. (Wavenumber is 25000 cm^-1)
PtaMidSummer.V2 = 1000; % Final wavelength in nanometres. (Wavenumber is 10000 cm^-1)
PtaMidSummer.DV = 0.04; % Spectral wavelength increment in nanometres.
PtaMidSummer.FWHM = 1; % Triangular convolution function width (wavelength in nanometres).
PtaMidSummer.YFLAG = ' '; % There will be no plot data output to .plt and .psc files.
PtaMidSummer.XFLAG = ' '; % There will be no plot data output to .plt and .psc files.
PtaMidSummer.DLIMIT = '$       '; % Delimiter string for multiple plots in single plot file.
PtaMidSummer.FLAGS = 'N A    '; % Control flags.
PtaMidSummer.MLFLX = 0; % Number of atmospheric levels for which spectral fluxes [FLAGS(7:7) = 'T' or 'F'] are output, starting from the ground.
PtaMidSummer.VRFRAC = 0; % Index of refraction profile for spherical refraction is performed at central spectral frequency value for input bandpass.
% Card 4A : Ground surface reflectance characterization
PtaMidSummer.NSURF = 1; % Not trying to model adjacency
PtaMidSummer.AATEMP = 0; % Not used (ground surface temperature)
PtaMidSummer.DH2O = 0; % Surface water, not used
PtaMidSummer.MLTRFL = 'f'; % Not used
% Card 4L1 : Lambertian ground surface reflectance data file specification
[~, DataPath] = Mod5.WhereIsMODTRAN;
PtaMidSummer.SALBFL = [DataPath filesep 'DATA' filesep 'spec_alb.dat']; % File of reflectance data
% Card 4L2 : Lambertian ground surface reflectance specification
PtaMidSummer.CSALB = '50'; % Grassland
% Card 5 : Repeat Run Option
PtaMidSummer.IRPT = 0; % MODTRAN Terminates.

% Create a series for the three ranges (path lengths)
PtaMidSummer = PtaMidSummer.CreateSeries('RANGE', {.212 1 5}); % Range Cases for 212 m to 5 km

% Run the case
PtaMidSummer = PtaMidSummer.Run;

% Plot path transmittance and radiance
PtaMidSummer.PlotSc7('TRANS');
title('LOS Spectral Transmittance');
legend('212 m', '1 km', '5 km', 'Location', 'best');
PtaMidSummer.PlotSc7('TOTALRAD');
title('LOS Spectral Path Radiance');
legend('212 m', '1 km', '5 km', 'Location', 'best');
%---------------- End Example 7 -------------------
%% Example 8 : AVIRIS airborne sensor viewing ground - Contributed by Bulent Ayhan

% template.txt, analysis_aviris_reflectance
% -- MODTRAN Parameters taken from from ENVI AVIRIS case --
% enviacc.modtran.visvalue = 40.0000                VIS
% enviacc.modtran.f_resolution = 15.0000            DV
% enviacc.modtran.day = 3                           DAY
% enviacc.modtran.month = 4                         DAY
% enviacc.modtran.year = 1998                       DAY
% enviacc.modtran.gmt = 20.1581                     TIME
% enviacc.modtran.latitude = 37.4042                PARM1 for  IPARM = 11
% -- Remember that MODTRAN uses longitude input positive WEST of Greenwich
% -- This longitude convention is unusual
% enviacc.modtran.longitude = 122.2250              PARM2 for  IPARM = 11
% enviacc.modtran.sensor_altitude = 21.8200         H1
% enviacc.modtran.ground_elevation = 0.1370         GNDALT
% enviacc.modtran.view_zenith_angle = 180.0000      PHI
% enviacc.modtran.view_azimuth = 0.0000             PSIPO
% enviacc.modtran.atmosphere_model = 2              MODEL
% enviacc.modtran.aerosol_model = 1                 IHAZE
% enviacc.modtran.multiscatter_model = 2            IEMSCT
% enviacc.modtran.disort_streams = 8                NSTR
% enviacc.modtran.co2mix = 390.0000                 CO2MX
% enviacc.modtran.water_column_multiplier = 1.0000  H2OSTR

close all
clear variables
% Determine the directory in which the Mod5 archive was extracted
MCDir = fileparts(which('Mod5'));
% This case is visible/near-infared (VIS/NIR) wavelengths
Avi = Mod5;    % Get a completely empty case instance
% Set up name and short description
Avi = Avi.SetCaseName('AVIRIS case');
Avi.CaseDescr = 'AVIRIS trial';

% Set up Card 1 (mandatory - main radiative transport)
Avi = Avi.Set('MODTRN', 'M','SPEED','S','BINARY', 'F', 'LYMOLC', ' ','MODEL', 2, 'ITYPE', 3, 'IEMSCT', 2, ...
                'IMULT', -1, 'M1', 0, 'M2', 0, 'M3', 0, 'M4', 0, 'M5', 0 , 'M6', 0, ...
                'MDEF', 0, 'I_RD2C', 0, 'NOPRNT', 1, 'TPTEMP', 0, 'SURREF', 'LAMBER');
              
% Set up Card 1A (mandatory - main radiative transport continued)
Avi = Avi.Set('DIS', 'f', 'DISAZM', 'f', 'DISALB', ' ', 'NSTR', 8, 'SFWHM', 0, 'CO2MX', 390, 'H2OSTR', '1.', ...
                'O3STR', '0.', 'C_PROF', ' ', 'LSUNFL', 'f', 'LBMNAM', 'f', 'LFLTNM', 't', ...
                'H2OAER', 'f', 'CDTDIR',' ','SOLCON', -1, 'CDASTM', ' ','ASTMC',0, 'ASTMX',0,'ASTMO',0,'AERRH',0, 'NSSALB', 0);

AvirisFltFile = [MCDir filesep 'aviris.flt']; 
AvirisFlt = Mod5.ReadFlt(AvirisFltFile);
            
% % Display the filter channel descriptions
disp(strvcat(AvirisFlt.FilterHeaders));
% % Plot the filters
Mod5.PlotFlt(AvirisFlt);

% And attach the EO camera filters to the case
Avi = Avi.AttachFlt(AvirisFlt); % This will automatically set FILTNM (Card 1A3)

% Set up Card 2 (mandatory - main aerosol and cloud options)
% IHAZE = 1 for rural aerosol character/extinction, VIS = 40 km, no clouds or rain
% ICSTL = 5 for moderate influence from continental aerosols

Avi = Avi.Set('APLUS', '  ', 'IHAZE', 1, 'CNOVAM', ' ', 'ISEASN', 0, 'ARUSS', '   ', ...
                'IVULCN', 0, 'ICSTL', 0, 'ICLD', 0, 'IVSA', 0, 'VIS', 40, 'WSS', 0, ...
                'WHH', 0, 'RAINRT', 0, 'GNDALT', 0.1370);
              
% Set up Card 3 (mandatory - Line of sight geometry)
% To define path (LOS) geometry in this case use PHI, H1 and H2 (combination 3c in manual)
% H1 is sensor (AVIRIS) altitude and H2 is view path ending altitude - MODTRAN will reset to GNDALT
Avi = Avi.Set('H1', 21.820, 'H2', 0, 'ANGLE', 180, 'RANGE', 0, 'BETA', 0, 'RO', 0, 'LENN', 0, 'PHI', 0);

% Set up Card 3A1 and 3A2 (Solar scattering geometry, required for IEMSCT = 2) 
% First set phase function and asymmetry parameter on Card 3A2 to avoid a warning.
% Phase function IPH = 2 for internal Mie database, G is not used
Avi = Avi.Set('IPH', 2, 'G', 0);
% Will use SetScatGeom method, which looks as follows
%   MC = MC.SetScatGeom(IPARM, IDAY, ISOURC, PARM, TIME, PSIPO, ANGLEM)
% ANGLEM is the lunar phase angle and not included.
% IPARM = 11 for lat, long, time and path azimuth
Avi = Avi.SetScatGeom(11, [1998 4 3], 0, [37.4042 122.225], 20.1581, 0);
% Input PARM(1) (relative solar/lunar azimuth angle at H2) must be 0 to 360 deg, 
% and PARM(2) (source zenith angle at H2) must be 0 to 90 deg.

% Set up Card 4 (mandatory - spectral range and resolution)
% Will use SetSpectralRange and the call looks as follows:
%   MC = MC.SetSpectralRange(V1, V2, DV, FWHM, Units, ConvShape, FWHMisRelative)
% and in this case would look as follows :
Avi = Avi.SetSpectralRange(373, 2503, 15, 30, 'N');
% Note : DV=15 is very coarse spectral resolution, but sensor response is 
% calculated from full spectral resolution data.


% Just need to set FLAGS(4) to get all radiance components in tp7
Avi.FLAGS(4) = 'A';   % Put ALL radiance components in convolved data (tp7)
% Must also set the plot-related Card 4 stuff
Avi = Avi.SetPlot(' ', ' ', ''); % Set XFLAG, YFLAG and DLIMIT blank for no plot files

% Card 4A is required because SURREF was set to 'LAMBER' on Card 1
Avi.NSURF = 1; % See MODTRAN manual for explanation
Avi.AATEMP = 0; % Not used

% Read a tree leaf reflectance from ASD data
TreeAlb = Mod5.ReadAlbFromASD([MCDir filesep 'tree100001.asd.ref.txt']);
TreeAlbSparse = Mod5.InterpAlb(TreeAlb, [0.373 2.503], 224);

Avi = Avi.AttachAlb(TreeAlbSparse); % 1 means ocean, 2 means tree

% Now run the case
Avi = Avi.Run;

% Plot the spectral channel output for ocean and tree ...
Avi.PlotChn('SPECTRAL_RADIANCE');
%---------------- End Example 8 - AVIRIS -------------------