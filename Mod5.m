classdef Mod5
% Mod5 - A class for working with MODTRAN 5 atmospheric model cases
% 
% This class is a functional wrapper and does not include a GUI. For
% MODTRAN GUIs, see PcModWin (Ontar Corporation), MODO (Rese), or MIG. 
%
% The class includes methods to read and write MODTRAN5 case files. Once
% a case has been read in, it is possible to adjust the parameters and
% write the modified .ltn or .tp5 file.
%
% There is also a method to run MODTRAN and read many results immediately
% into the class instance. For a full list of methods, see below the
% property listing.
%
% For this version of Mod5, the canonical reference for MODTRAN
% parameters is the MODTRAN 5.2.0.0 User's Manual dated July 2008.
%
% The class Mod5 has the following properties:
% 
%            CaseName: Name of the case. Defaults to the filename (no extension)
%           CaseIndex: The sub-case index number. This is a cross-check.
%           CaseDescr: Single line description of case. Used for plot titles.
%           LongDescr: Longer, perhaps multiline, description.
%          OriginFile: Full filename of original file from which case was read.
%           MODStatus: Status flag produced when MODTRAN is run on the case.
%             MODSays: Console output from MODTRAN produced when case is run.
%    The following properties with names that are all in upper case are 
%    MODTRAN5 case input parameters. These are the parameters read from
%    a .ltn or .tp5 (or tape5) file. For definitions of these parameters
%    see the MODTRAN5 User's Manual.
%              MODTRN: See MODTRAN5 User's Manual Card 1 Series, Main Radiation Transport
%               SPEED: See MODTRAN5 User's Manual, Algorithm control
%              BINARY: See MODTRAN5 User's Manual, Binary/ASCII output switch
%              LYMOLC: See MODTRAN5 User's Manual, Auxiliary trace gases
%               MODEL: See MODTRAN5 User's Manual, Canned Atmospheric Model
%               ITYPE: See MODTRAN5 User's Manual, Type of atmospheric path
%              IEMSCT: See MODTRAN5 User's Manual, Mode of execution, Rad/Trans etc.
%               IMULT: See MODTRAN5 User's Manual, Controls multiple scattering
%                  M1: See MODTRAN5 User's Manual
%                  M2: See MODTRAN5 User's Manual
%                  M3: See MODTRAN5 User's Manual
%                  M4: See MODTRAN5 User's Manual
%                  M5: See MODTRAN5 User's Manual
%                  M6: See MODTRAN5 User's Manual
%                MDEF: See MODTRAN5 User's Manual
%              I_RD2C: See MODTRAN5 User's Manual
%              NOPRNT: See MODTRAN5 User's Manual, Controls .tp8 and .clr output.
%              TPTEMP: See MODTRAN5 User's Manual
%              SURREF: See MODTRAN5 User's Manual
%                 DIS: See MODTRAN5 User's Manual
%              DISAZM: See MODTRAN5 User's Manual
%              DISALB: See MODTRAN5 User's Manual
%                NSTR: See MODTRAN5 User's Manual
%               SFWHM: See MODTRAN5 User's Manual
%               CO2MX: See MODTRAN5 User's Manual
%              H2OSTR: See MODTRAN5 User's Manual
%              C_PROF: See MODTRAN5 User's Manual
%               O3STR: See MODTRAN5 User's Manual
%              LSUNFL: See MODTRAN5 User's Manual
%              LBMNAM: See MODTRAN5 User's Manual
%              LFLTNM: See MODTRAN5 User's Manual
%              H2OAER: See MODTRAN5 User's Manual
%              CDTDIR: See MODTRAN5 User's Manual
%              SOLCON: See MODTRAN5 User's Manual
%              CDASTM: See MODTRAN5 User's Manual
%               ASTMC: See MODTRAN5 User's Manual
%               ASTMX: See MODTRAN5 User's Manual
%               ASTMO: See MODTRAN5 User's Manual
%               AERRH: See MODTRAN5 User's Manual
%              NSSALB: See MODTRAN5 User's Manual
%              USRSUN: See MODTRAN5 User's Manual
%              BMNAME: See MODTRAN5 User's Manual
%              FILTNM: See MODTRAN5 User's Manual
%               APLUS: See MODTRAN5 User's Manual Card 2 Series
%               IHAZE: See MODTRAN5 User's Manual
%              CNOVAM: See MODTRAN5 User's Manual
%              ISEASN: See MODTRAN5 User's Manual
%               ARUSS: See MODTRAN5 User's Manual
%              IVULCN: See MODTRAN5 User's Manual
%               ICSTL: See MODTRAN5 User's Manual
%                ICLD: See MODTRAN5 User's Manual
%                IVSA: See MODTRAN5 User's Manual
%                 VIS: See MODTRAN5 User's Manual
%                 WSS: See MODTRAN5 User's Manual
%                 WHH: See MODTRAN5 User's Manual
%              RAINRT: See MODTRAN5 User's Manual
%              GNDALT: See MODTRAN5 User's Manual
%              ZAER11: See MODTRAN5 User's Manual
%              ZAER12: See MODTRAN5 User's Manual
%              SCALE1: See MODTRAN5 User's Manual
%              ZAER21: See MODTRAN5 User's Manual
%              ZAER22: See MODTRAN5 User's Manual
%              SCALE2: See MODTRAN5 User's Manual
%              ZAER31: See MODTRAN5 User's Manual
%              ZAER32: See MODTRAN5 User's Manual
%              SCALE3: See MODTRAN5 User's Manual
%              ZAER41: See MODTRAN5 User's Manual
%              ZAER42: See MODTRAN5 User's Manual
%              SCALE4: See MODTRAN5 User's Manual
%               CTHIK: See MODTRAN5 User's Manual
%                CALT: See MODTRAN5 User's Manual
%                CEXT: See MODTRAN5 User's Manual
%              NCRALT: See MODTRAN5 User's Manual
%              NCRSPC: See MODTRAN5 User's Manual
%              CWAVLN: See MODTRAN5 User's Manual
%              CCOLWD: See MODTRAN5 User's Manual
%              CCOLIP: See MODTRAN5 User's Manual
%              CHUMID: See MODTRAN5 User's Manual
%              ASYMWD: See MODTRAN5 User's Manual
%              ASYMIP: See MODTRAN5 User's Manual
%               ZCVSA: See MODTRAN5 User's Manual
%               ZTVSA: See MODTRAN5 User's Manual
%              ZINVSA: See MODTRAN5 User's Manual
%                  ML: See MODTRAN5 User's Manual
%                IRD1: See MODTRAN5 User's Manual
%                IRD2: See MODTRAN5 User's Manual
%              HMODEL: See MODTRAN5 User's Manual
%                  ZM: See MODTRAN5 User's Manual
%                   P: See MODTRAN5 User's Manual
%                   T: See MODTRAN5 User's Manual
%               JCHAR: See MODTRAN5 User's Manual
%              JCHARX: See MODTRAN5 User's Manual
%                WMOL: See MODTRAN5 User's Manual
%               WMOLX: See MODTRAN5 User's Manual
%               AHAZE: See MODTRAN5 User's Manual
%              EQLWCZ: See MODTRAN5 User's Manual
%               RRATZ: See MODTRAN5 User's Manual
%                IHA1: See MODTRAN5 User's Manual
%               ICLD1: See MODTRAN5 User's Manual
%               IVUL1: See MODTRAN5 User's Manual
%               ISEA1: See MODTRAN5 User's Manual
%               ICHR1: See MODTRAN5 User's Manual
%                IREG: See MODTRAN5 User's Manual
%              AWCCON: See MODTRAN5 User's Manual
%               TITLE: See MODTRAN5 User's Manual
%              VARSPC: See MODTRAN5 User's Manual
%                EXTC: See MODTRAN5 User's Manual
%                ABSC: See MODTRAN5 User's Manual
%                ASYM: See MODTRAN5 User's Manual
%                ZCLD: See MODTRAN5 User's Manual
%                 CLD: See MODTRAN5 User's Manual
%              CLDICE: See MODTRAN5 User's Manual
%                  RR: See MODTRAN5 User's Manual
%              WAVLEN: See MODTRAN5 User's Manual
%                  H1: See MODTRAN5 User's Manual Card 3 Series
%                  H2: See MODTRAN5 User's Manual
%               ANGLE: See MODTRAN5 User's Manual
%               RANGE: See MODTRAN5 User's Manual
%                BETA: See MODTRAN5 User's Manual
%                  RO: See MODTRAN5 User's Manual
%                LENN: See MODTRAN5 User's Manual
%                 PHI: See MODTRAN5 User's Manual
%                IDAY: See MODTRAN5 User's Manual
%              ISOURC: See MODTRAN5 User's Manual
%              ANGLEM: See MODTRAN5 User's Manual
%               IPARM: See MODTRAN5 User's Manual
%                 IPH: See MODTRAN5 User's Manual
%               PARM1: See MODTRAN5 User's Manual
%               PARM2: See MODTRAN5 User's Manual
%               PARM3: See MODTRAN5 User's Manual
%               PARM4: See MODTRAN5 User's Manual
%                TIME: See MODTRAN5 User's Manual
%               PSIPO: See MODTRAN5 User's Manual
%                   G: See MODTRAN5 User's Manual
%              NANGLS: See MODTRAN5 User's Manual
%                NWLF: See MODTRAN5 User's Manual
%                ANGF: See MODTRAN5 User's Manual
%                   F: See MODTRAN5 User's Manual
%                 WLF: See MODTRAN5 User's Manual
%                  V1: See MODTRAN4 User's Manual Card 4 Series, start wavelength/number
%                  V2: See MODTRAN5 User's Manual, Finishing wavelength/number
%                  DV: See MODTRAN5 User's Manual, Wavlength/number increment
%                FWHM: See MODTRAN5 User's Manual, filter width for convolution
%               YFLAG: See MODTRAN5 User's Manual, Data output to .plt
%               XFLAG: See MODTRAN5 User's Manual, Units for .plt (plot file)
%              DLIMIT: See MODTRAN5 User's Manual, Plot file delimiter
%               FLAGS: See MODTRAN5 User's Manual, V1/V2 Units and convolution control
%               NSURF: See MODTRAN5 User's Manual
%              AATEMP: See MODTRAN5 User's Manual
%               CBRDF: See MODTRAN5 User's Manual
%              NWVSRF: See MODTRAN5 User's Manual
%              SURFZN: See MODTRAN5 User's Manual
%              SURFAZ: See MODTRAN5 User's Manual
%              WVSURF: See MODTRAN5 User's Manual
%             PARAMS1: See MODTRAN5 User's Manual
%             PARAMS2: See MODTRAN5 User's Manual
%             PARAMS3: See MODTRAN5 User's Manual
%             PARAMS4: See MODTRAN5 User's Manual
%              SALBFL: See MODTRAN5 User's Manual
%               CSALB: See MODTRAN5 User's Manual
%                IRPT: See MODTRAN5 User's Manual Card 5,
%                      Determines whether there are more sub-cases in the file.
%        RunStartTime: Date and time at which MODTRAN run was started on this case.
%          RunEndTime: Date and time at which MODTRAN terminated.
%     RunStartSerTime: Serial date of run start time.
%       RunEndSerTime: Serial date of termination.
%         RunDuration: Duration of MODTRAN run in seconds.
%                 alb: Spectral albedo data of targets
%                 flt: Spectral channel filters (read with ReadFlt)
%  The following properties are MODTRAN outputs and are populated only when
%  the case is run (using the statement MyCase = MyCase.Run;).
%                 tp6: Placeholder for possible selected tape 6 outputs. Not implemented.
%                 tp7: MODTRAN outputs to tape 7 (unconvolved)
%                 sc7: Outputs as for tp7, but convolved, written to CaseName.7sc
%                 plt: MODTRAN Plot outputs to .plt file (unconvolved)
%                 psc: Convolved plot outputs.
%                 chn: Spectral band (sensor channel) outputs.
%                 tp8: Radiant fluxes, unconvolved (not implemented)
%                 flx: Radiant fluxes, convolved (not yet implemented).
%                 clr: Cooling rates (not yet implemented).
% The following 2 properties are constant for this revision of the class.
%                 Rev: The revision of this class definition (Mod5)
%          MODTRANExe: The name of the MODTRAN excutable that this class was
%                      tested with.
%
% Methods:
% Constructor methods to create cases:
%  MyEmptyCase = Mod5;   % Returns empty instance of the class
%
%  CaseM01 = Mod5('CaseM01.ltn'); % Read case from .ltn file in current directory
%
%  MyCase = Mod5(''); % Open file dialog to read case from .ltn or .tp5 file
%
% To run a MODTRAN case and retrieve results into the class instance
%  MyCase = MyCase.Run;     % Run case and obtain results
%
%  MyCase = MyCase.Run(4);  % Run case and plot any .plt or .psc plot files
%
% Manipulation of Cases:
%  To extract a specific sub-case from a multiple case run:
%   SingleCase = MultiCase.Extract(iSubCaseNumbers);
%  
% To replicate a case (don't use repmat, instead use ..)
%   MyReplicatedCase = MyCase.Replicate(NewSize);
%
%
%  To merge several cases into a single case:
%   SuperCase = Mod5.Merge(MODCase1, MODCase2);
%     or, equivalently,
%   SuperCase = MODCase1.Merge(ModCase2);
%
%  To create a sensitivity series:
%   SensiSeries = MyBaseCase.CreateSeries(ParamName1, ParamValues1, ...)
%
% Plotting of Cases:
%   MyCase.PlotTp7  - plots selectable MODTRAN tape7 outputs
%   MyCase.PlotSc7  - plots selectable convolved MODTRAN tape7 outputs
%   MyCase.PlotChn  - plots channel (.chn) MODTRAN outputs
%
% Utility and Static Methods:
%   Mod5.SetMODTRANExe   - Set MODTRAN executable location
%   Mod5.SetCasePath     - Set default directory for MODTRAN cases
%   Mod5.WhereIsMODTRAN  - Get MODTRAN executable location
%   Mod5.Read7           - Read .tp7, tape7, tape7.scn or .7sc files
%   Mod5.ReadPlt         - Read .plt, .psc plot files (plotout and plotout.scn also)
%   Mod5.ReadChn         - Read .chn outputs from MODTRAN
%
% Functions for working with sensor spectral band (channel) response filters
%   Mod5.CreateFlt       - Create synthetic spectral response filter(s)
%   Mod5.ReadFlt         - Read a spectral response filter set file
%   Mod5.ReadFltFromSensorML - Read spectral response data from a SensorML (.xml) file 
%   Mod5.WriteFlt        - Write a spectral response filter set file
%   MyCase.AttachFlt            - Attach a spectral response filter set to a case
%   Mod5.PlotFlt         - Plot a spectral response filter set
%
% Functions for working with spectral albedo (reflectance) data
%   Mod5.CreateAlb       - Create spectral albedo data structure
%   Mod5.ReadAlb         - Read albedo data from MODTRAN spec_alb.dat format file
%   Mod5.WriteAlb        - Write albedo data in MODTRAN format
%   Mod5.ReadAlbFromUSGS - Read reflectance data from USGS splib06a file
%   Mod5.ReadAlbFromASD  - Read reflectance data from ASD spectroradiometer file
%   Mod5.InterpAlb       - Interpolate albedo to new set of wavelengths
%   Mod5.MixAlb          - Mix weighted reflectance data
%   MyCase.AttachAlb            - Attach albedo data to a MODTRAN (radiance) case
%
% Scripting and Description of Cases
%  There are two incomplete functions for obtaining scripts and descriptions
%  of cases:
%   MyCase.Describe
%   MyCase.Script
% 
%  
% Atmospheric Parametric Studies using MODTRAN
%----------------------------------------------
% One of the chief purposes of this class is to be able to read existing
% "template" cases, and then tweak parameters for the purposes of 
% performing parametric/sensitivity studies, or to mutate cases. This
% mutation process can also be used to perform "retrieval" of atmospheric
% parameters by adjusting MODTRAN inputs until the outputs match
% your measurements/observations.
%
% For this tweaking/mutation to be possible, only certain parameters
% can be meddled with, namely those that do not alter the structure
% of the input card deck. These MODTRAN parameters that maintain case
% "congruency" are called "tweakable" or "mutable". Some parameters
% have limited mutability. Such a parameter is MODEL, which is
% mutable within the set [1 2 3 4 5 6], but not outside that set.
% Some of the MODTRAN parameters that are not mutable include:
% ITYPE, IEMSCT, IMULT, SURREF, LSUNFL, LBMNAM, LFLTNM, IREG,
% APLUS, ICLD, IVSA, IM, MDEF, IRD1, NCRALT, NCRSPC, IHAZE, ARUSS
% NANGLS, NWLF, IPH and others. 
%
% Of course, any MODTRAN parameters can be altered, as long as the
% card deck is kept consistent. Detailed knowledge of the MODTRAN
% inputs is required in order to do this. Currently, this class does
% almost no integrity checking on cases. "Set" methods that enforce
% integrity should be implemented.
%
% A useful tool for debugging a card deck is to read the deck with the
% debug flag set. e.g.
%
% MyMod5Case = Mod5('MyBuggyMODTRANCaseFile.ltn', 1);
%
% Bugs and Limitations :
%  1) The format of the MODTRAN 5 case file is complex, and exhaustive testing
%  on this class has not been performed. Most of the test cases appear to
%  read and write correctly.
%
%  2) On the PC platform, %E format specifiers produce 3 digits in the exponent
%  whereas on Unix, only 2 digits are produced. This is tricky to resolve, and
%  residual bugs due to this problem may be present. Affected cards include
%  2C1, 2C2, 2C2X, 2D1, 3C3, 3C4, 3C5, and 3C6. The workaround to attempt
%  to resolve this, is to use a %E format with a field width of one extra 
%  character on the PC platform, writing the output first to a string,
%  and then replacing occurrances of 'E+0' with 'E+' and 'E-0' with 'E-'
%  before writing to the output .ltn file. This workaround seems to work
%  for all the test cases run so far. The process is only applied if 
%  running on the Windows platform.
%
%  3) Mod5 class has only been tested on the PC under Windows XP (TM).
%  The class may or may not work on Unix-like systems.
%
%  4) There is almost no integrity checking and if the user changes MODTRAN
%  parameters, the results attached to the case will be invalidated without
%  being deleted. The user is responsible for rerunning MODTRAN once a case
%  has been altered to refresh the results. To see what case parameter
%  validation is currently implemented, see the 'set/get' methods section. 
%
%  5) Attachment of results to the correct sub-case is not guaranteed. There
%  are some apparently pathological cases where assignment may be incorrect.
%  Generally a warning will be issued to signify a possible problem. This is
%  especially true of plot files, where the conditions for generation of
%  plot data for a particular sub-case are not clear from the documentation.
%  It is assumed that output to .plt is controlled only by YFLAG. If YFLAG
%  is blank then there is no .plt or .psc output. Otherwise, it is assumed
%  that if a particular case had output to .tp7, then there is also output
%  to .plt. Likewise, if there is output to .7sc, then it is assumed that
%  there is also output to .psc. There are cases that suggest these 
%  assumptions are wrong. If in doubt, extract and run the single
%  sub-case using 
%     MySingleCase = MyMultipleCase.Extract(IndexOfTheSubCaseIWant)
%     MySingleCase = MySingleCase.Run(4);  % The parameter 4 requests plotting
%
%  6) The Matlab fprintf function will produce no output for %f fields
%  when the value given is empty ([]). Since not all parameters are 
%  currently validated (using set methods), this can result in MODTRAN
%  input card field misalignments when writing out a .tp5 file, and
%  consequent incorrect or aborted runs of MODTRAN. The only workaround
%  appears to be to implement a set method that enforces a default value.
%  This applies only to numeric values where MODTRAN accepts blanks
%  to mean either 0 or some other numerical default. This problem 
%  is of particular relevance to casefiles written for older versions
%  of MODTRAN. 
%
%  A possible fix for this problem is to check to see if the field is
%  blank when read from a file, and to substitute a blank string instead
%  of a numeric value. Likewise, when the value is written to a file
%  (e.g. tp5 file), the value is written as a string if found to be a
%  string, but as numeric if found to be numeric. The former would be
%  fairly easy, but the latter might require substantial rewrites of
%  the WriteCard private methods.
%
% For examples of use, see the script file Mod5Examples.m
% Note that properties that are also MODTRAN inputs are fully in 
% upper case.
%
  
  % Check overview documentation, include new functionality
  % BRDF visualisation
  % Reading and plotting of fluxes (irradiances)
  % Create .zip archive, make sure all relevant files included e.g. BSDlicence.txt, Albedo Spectra files
  % .ltn files, Ex1.ltn, Ex4.ltn, CaseUSS.ltn, MERIS .xml
  % Test .zip archive on clean installation - get help from Meena
  
  % Copyright 2009-2011, DPSS, CSIR $Author$
  % Dedicated to the memory of Mimi Jansen.
  % This software is subject to the terms and conditions of the BSD licence.
  % For further details, see the file BSDlicence.txt
  % $Id$
  properties (GetAccess = public, SetAccess = private)
    CaseName = 'Matlab'; % The name of the super-case, must be the same across all sub-cases    
    CaseIndex = 1; % This is the sub-case index. Must run from 1 to numel(Mod5Instance).    
  end
  properties
    SubCaseName = ''; % Name of the sub-case, can be changed per sub-case
    CaseDescr = ''; % Single line short user specifiable case description. Used for plot titles.
    LongDescr = ''; % Long description - can contain carriage returns and tex formatting.
    OriginFile = ''; % Original file from which the case was read/constructed
    MODStatus = []; % This is the status code returned by MODTRAN when the case is run. If this value is empty, it means that MODTRAN has not been run on the case.
    MODSays = 'MODTRAN has not been run on this case.'; % This is any text output by MODTRAN to standard output (console) when run.
    % The following properties in capital letters are the MODTRAN input parameters
    % None of the MODTRAN parameters are given defaults. If building a case from
    % scratch, the user must supply all parameters required for a valid case.
    % There are a few parameters that are given default values on instance
    % construction, but only in cases where such defaults are considered
    % innocuous, or where they would in any case be the logical MODTRAN default.
 
    MODTRN  % Band model selection. Must be blank, 'T', 'M', 'C', 'K', 'F' or 'L' 
    SPEED   % 'S' or blank for slow correlated-k, 'M' for medium
    BINARY  % Flag to specify if main MODTRAN outputs are in binary or text format
    LYMOLC  % '+' indicates inclusion of 16 auxiliary trace gas species
    MODEL   % Canned atmospheric model or 7 for user-defined atmosphere
            % 0 If single-altitude meteorological data are specified (constant pressure, horizontal
            %   path only; see instructions for CARDs 2C, 2C1, 2C2, 2C2X, and 2C3).
            % 1 Tropical Atmosphere.
            % 2 Mid-Latitude Summer.
            % 3 Mid-Latitude Winter.
            % 4 Sub-Arctic Summer. 
            % 5 Sub-Arctic Winter.
            % 6 1976 US Standard.
            % 7 If a user-specified model atmosphere (e.g. radiosonde data) is to be read in; see
            %   instructions for CARDs 2C, 2C1, 2C2, 2C2X, and 2C3.
    ITYPE   % Type of atmospheric path
    IEMSCT  % MODTRAN computation mode - radiance, transmittance or direct solar irradiance
    IMULT   % Execute MODTRAN with multiple scattering (radiance modes)
    M1      % Canned atmosphere selection for pressure and temperature profiles
    M2      % Canned atmosphere selection for water vapor profile
    M3      % Canned atmosphere selection for ozone profile
    M4      % Canned atmosphere selection for methane profile
    M5      % Canned atmosphere selection for nitrous oxide profile
    M6      % Canned atmosphere selection for carbon monoxide profile
    MDEF    % Other light and heavy molecular species profile control flag
    I_RD2C  % Controls reading of user-defined atmosphere in this run
    NOPRNT  % Controls output files and content
    TPTEMP  % Boundary temperature at H2
    SURREF  % Controls reflectance or BRDF at H2
    DIS     % Controls use of DISORT multiple scatter algorithm
    DISAZM  % Controls whether azimuthal dependency of DISORT is used
    DISALB  % Controls computation of atmospheric correction data
    NSTR    % Controls number of streams for DISORT
    SFWHM   % FWHM of triangular scanning filter for TOA solar irradiance smoothing 
%     LSUN    % Flag selecting spectral resolution of solar TOA database 
%     ISUN    % If LSUN set true, ISUN is FWHM for smoothing of TOA spectrum
    CO2MX   % CO2 mixing ratio in ppmv. 2010 value is about 380 ppmv
    H2OSTR  % Allows scaling of water vapor profile
    O3STR   % Allows scaling of ozone profile
    C_PROF  % Controls scaling of vertical profiles of various species
    LSUNFL  % Flag to control reading of solar TOA irradiance data
    LBMNAM  % Flag to control reading of band model
    LFLTNM  % Flag to control reading of spectral channel filters
    H2OAER  % Allows control of water vapor scaling effects on aerosols
    CDTDIR  % Directory where MODTRAN will search for data files
    SOLCON  % Scaling of solar constant
    CDASTM  % Controls application of aerosol angstrom law inputs
    ASTMC   % Angstrom law coefficient for boundary layer and troposphere
    ASTMX   % Angstrom law offset for the boundary layer and troposphere
    ASTMO   % Angstrom law offset for the boundary layer and troposphere
    AERRH   % Relative humidity for the boundary layer aerosol
    NSSALB  % Controls aerosol single scattering albedo
    USRSUN  % File from which to read solar TOA irradiance (if LSUNFL set true)
    BMNAME  % File from white to read band model (if LBMNAM set true)
    FILTNM  % File (.flt) from which to read spectral channel filters (if LFLTNM set true)
    DATDIR  % The MODTRAN data directory
    APLUS   % Flag to indicate extended user-defined aerosol input
    IHAZE   % Main aerosol control option
    CNOVAM  % Use Navy Oceanic Vertical Aerosol Model or not
    ISEASN  % Seasonal modication to aerosol profiles
    ARUSS   % Flag to indicate User-supplied aerosol properties
    IVULCN  % Stratospheric aerosol control
    ICSTL   % Air mass character to mix continental and open ocean influences on aerosols
    ICLD    % Cloud and rain model selection
    IVSA    % Selects US Army vertical structure algorithm (VSA) for aerosols
    VIS     % Surface meteorological range in km
    WSS     % Current wind speed to modify navy maritime and desert aerosol models (no influence on other models)
    WHH     % Average wind speed for last 24 hours. Also only for navy maritime (IHAZE = 3) and desert (IHAZE = 10) models
    RAINRT  % Rain rate in mm/hour
    GNDALT  % Ground altitude in km
    ZAER11  % Flexible aerosol model controls
    ZAER12  % Flexible aerosol model controls
    SCALE1  % Flexible aerosol model controls
    ZAER21  % Flexible aerosol model controls
    ZAER22  % Flexible aerosol model controls
    SCALE2  % Flexible aerosol model controls
    ZAER31  % Flexible aerosol model controls
    ZAER32  % Flexible aerosol model controls
    SCALE3  % Flexible aerosol model controls
    ZAER41  % Flexible aerosol model controls
    ZAER42  % Flexible aerosol model controls
    SCALE4  % Flexible aerosol model controls
    CTHIK   % Cloud thickness in km
    CALT    % Cloud base altitude in km
    CEXT    % Cloud extinction coefficient
    NCRALT  % Number of layer boundary altitudes (from CARD 2E1) in user-defined cloud/rain profile
    NCRSPC  % Number of wavelength at which cloud spectral data is being entered (on CARD 2E2)
    CWAVLN  % The reference wavelength used in defining cloud vertical extinction
    CCOLWD  % Cloud liquid water droplet vertical column density [km gm / m^3]
    CCOLIP  % Cloud ice particle vertical column density or amount [km gm / m^3]
    CHUMID  % The relative humidity at all layer boundaries with either a positive rain rate or a positive cloud density
    ASYMWD  % The Henyey-Greenstein phase function asymmetry factor for scattering by cloud liquid water droplets
    ASYMIP  % Ice particle Henyey-Greenstein scattering phase function asymmetry factor at all wavelengths
    ZCVSA   % Cloud ceiling height in km for Vertical Structure Algorithm (VSA)
    ZTVSA   % Cloud thickness in km for Vertical Structure Algorithm
    ZINVSA  % Inversion layer height in km, for Vertical Structure Algorithm
    ML        % Number of layers in the user-defined atmospheric profile
    IRD1      % Controls reading of additional light molecule abundances in user-defined atmospheric profiles
    IRD2      % Controls reading of Card 2C3, AHAZE, EQLWCZ ...
    HMODEL    % Name or description of user-defined atmospheric profile
    ZM        % Layer boundary altitudes for user-defined atmospheres 
    P         % Pressure at layer boundaries in user-defined atmospheric profile
    T         % Temperatures at layer boundaries in user-defined atmospheric profile 
    JCHAR     % Flags indicating units or canned atmosphere default for light modelcues in user-defined atmospheric components
    JCHARX    % Flags indicating units or canned atmosphere default for heavy molecules in user-defined atmospheric components 
    WMOL      % Light molecule abundances in user-defined atmospheric profiles
    WMOLX     % Heavy molecule abundances in user-defined atmospheric profiles
    AHAZE     % Aerosol or cloud scaling factor at altitudes ZM
    EQLWCZ    % Equivalent liquid water content at altitudes ZM for aerosol, cloud or fog
    RRATZ     % Rain rate (mm/hour) at altitudes ZM
    IHA1      % Aerosol model extinction and meteorological range control for the altitude, ZM. See IHAZE (CARD 2) for options
    ICLD1     % Cloud extinction control for the altitude, ZM; see ICLD (CARD 2) for options
    IVUL1     % Stratospheric aerosol profile and extinction control for the altitude ZM; see IVULCN (CARD 2) for options
    ISEA1     % Aerosol season control for the altitude, ZM, see ISEASN (CARD 2) for options
    ICHR1     % Used to indicate a boundary change between 2 or more adjacent user defined aerosol or cloud regions at altitude ZM (required for IHAZE = 7 or ICLD = 11)
    IREG      % Specifies in which of the four altitude regions a user-defined aerosol or cloud model is used (IHAZE = 7 / ICLD = 11)
    AWCCON    % Conversion factor from extinction coefficient (km-1) to equivalent liquid water content (g/m^3)
    TITLE     % Aerosol or cloud region title
    VARSPC    % Wavelengths for user-supplied (USS) aerosol data    
    EXTC      % Aerosol or cloud extinction coefficients, normalized so that EXTC for a wavelength of 0.55 mm is 1.0 km^-1
    ABSC      % Aerosol or cloud absorption coefficient, normalized so that EXTC for a wavelength of 0.55 mm is 1.0 km-1
    ASYM      % Aerosol or cloud asymmetry parameter
    ZCLD      % Altitude above ground level of layer boundary I for the user-defined cloud/rain profile in km
    CLD       % Liquid water drop density at altitude ZCLD
    CLDICE    % Ice particle density at altitude ZCLD
    RR        % Rain rate at altitude ZCLD
    WAVLEN    % Wavelengths in spectral grid for user-defined clouds
    H1        % Initial altitude of LOS (observer/sensor) (km)
    H2        % Final altitude or tangent height of path (km)
    ANGLE     % Initial zenith angle of LOS (degrees)
    RANGE     % Range of H2 from H1 (km)
    BETA      % Earth center angle subtended by H1 to H2 (LOS)
    RO        % Earth radius at latitude of calculation (km)
    LENN      % Switch to choose between long and short paths (LOS)
    PHI       % Zenith angle at H2 (target)
    IDAY      % Day of the year
    ISOURC    % Selects Sun or Moon as source for irradiance calculation (IEMSCT = 3)
    ANGLEM    % Phase angle of the Moon for Lunar irradiance calculation
    IPARM     % Solar/Lunar scattering geometry parameter combination switch
    IPH       % Scattering phase function selector
    PARM1     % Solar/Lunar scattering geometry parameter 1 
    PARM2     % Solar/Lunar scattering geometry parameter 2 
    PARM3     % Solar/Lunar scattering geometry parameter 3
    PARM4     % Solar/Lunar scattering geometry parameter 4
    TIME      % Greenwich Time (now Universal Time or UTC)
    PSIPO     % Path azimuth (degrees)
    G         % Asymmetry factor for use with Henyey-Greenstein phase function (IPH = 0)
    NANGLS    % Number of angles for user-defined aerosol phase function (IPH = 1)
    NWLF      % Number of wavelengths for USS-style user-defined aerosols
    ANGF      % Scattering angle in degrees for user-defined aerosol phase functions
    F         % User-defined aerosol phase function
    WLF       % Wavelengths for USS-style user-defined aerosols
    V1        % Start of spectral range for MODTRAN calculation
    V2        % End of spectral range for MODTRAN calculation
    DV        % Spectral step size for MODTRAN calculation
    FWHM      % Full-width and Half Maximum for convolution of MODTRAN results
    YFLAG     % Controls transmittance or radiances output to plot file
    XFLAG     % Controls units in plot file
    DLIMIT    % Delimiter for multiple plots in the plot file
    FLAGS = '       '; % Control flags for spectral range units and convolution
    NSURF     % Control for area-averaged reflectance in target region
    AATEMP    % Area-averaged ground surface temperature
    CBRDF     % Gives name or number of BRDF parametrization (if SURREF = 'BRDF')
    NWVSRF    % Number of BRDF spectral grid points
    SURFZN    % Zenith angle of surface normal for BRDF calculation (only 0 is supported in MODTRAN 4)
    SURFAZ    % True azimuth angle of the surface normal for BRDF calculation (Not used in MODTRAN 4)
    WVSURF    % BRDF spectral wavelengths
    PARAMS1   % BRDF parameter 1 for wavelengths WVSURF 
    PARAMS2   % BRDF parameter 2 for wavelengths WVSURF
    PARAMS3   % BRDF parameter 3 for wavelengths WVSURF
    PARAMS4   % BRDF parameter 4 for wavelengths WVSURF
    SALBFL    % Gives name of file defining spectral albedo of the target
    CSALB     % Gives number of name of predefined spectral albedo data
    IRPT = 0; % MODTRAN control flag for running next sub-case or terminating.
    RunStartTime = '';   % The starting date/time of the MODTRAN run for this case.
    RunEndTime = '';     % The finishin date/time of the MODTRAN run for this case.
    RunStartSerTime = [];% Serial start time of run
    RunEndSerTime = [];  % Serial finish time of run
    RunDuration = [];    % MODTRAN run duration in seconds.
    
    alb = [];     % Spectral albedo data of targets
    % The property flt is a filter definition typically read from a .flt file, or created using CreateFlt.
    flt = [];     % Spectral channel filter set data.
    
    % The following are results computed by MODTRAN. They are all structures and the field
    % names in these structures will depend on what columns of data appear in the MODTRAN
    % output file. Some are only placeholders and currently there is no method to read the data.
    
    tp6 = [];     % Placeholder for possible tape6 outputs. There is no method to read this data yet.
    tp7 = [];     % tape7 or .tp7 file outputs for this sub-case, full spectral resolution
    sc7 = [];     % tape7.scn or .7sc output for this sub-case (filtered/convolved to reduced spectral resolution)
    plt = [];     % Plot file, full spectral resolution, rather use data taken from tp7 or sc7
    psc = [];     % Plot file, filtered to reduced spectral resolution
    chn = [];     % Spectral channel computations for computing band radiance.
    tp8 = [];     % Radiant spectral fluxes, diffuse and total, unconvolved. There is no method to read this data yet.
    flx = [];     % Radiant spectral fluxes, convolved. 
    clr = [];     % Cooling rates. No method currently exists to read this data yet.
    acd = [];     % Atmospheric correction data. No methods to read this data yet.
  end
  properties (Constant)
    Rev = '$RevisionNode$';         % The revision node of the class
    MODTRANExe = 'Mod5.2.0.0_cons.exe'; % This is the version of MODTRAN used by this class
  end
  properties (Hidden)
    % There are a total of ? possible card formats in MODTRAN 5
    CardNames = {'1'  ,'1A' ,'1A1' ,'1A2','1A3','1A4','2','2A+','2A' ,'Alt2A','2B' ,'2C', ...
                '2C1','2C2','2C2X','2C3', '2D','2D1','2D2','2E1','2E2'  ,'3'  ,'Alt3', ...
                '3A1','3A2','3B1' ,'3B2','3C1','3C2','3C3','3C4','3C5'  ,'3C6','4', ...
                '4A','4B1','4B2','4B3','4L1','4L2','5'};
    CardDescr = {'Main Radiation and Transport Driver, Model, Algorithm, Mode', ... 1
                 'Main Radiation and Transport Driver, Multi-Scatter, Solar, CO2', ... 1A
                 'Spectral Data and Sensor Response Function Files, TOA Solar Irradiance', ... 1A1
                 'Spectral Data and Sensor Response Function Files, Band Model Parameter File', ... 1A2
                 'Spectral Data and Sensor Response Function Files, Instrument Filter File', ... 1A3
                 'MODTRAN Data File Directory', ... 1A4
                 'Main Aerosol and Cloud Options, Turbidity, Rain, Ground Altitude', ... 2
                 'Flexible Aerosol Model', ... 2A+
                 'Cirrus Cloud Models', ... 2A
                 'Water/Ice Cloud Models', ... Alt2A
                 'Army Vertical Structure Algorithm (VSA), Fog, Haze', ... 2B
                 'User-Defined Atmospheric Profiles, Control Card', ... 2C
                 'User-Defined Atmospheric Profiles, Layers, Temperature, Pressure, Species', ... 2C1
                 'User-Defined Atmospheric Profiles, Molecular Species', ... 2C2
                 'User-Defined Atmospheric Profiles, Molecular Species', ... 2C2X
                 'User-Defined Atmospheric Profiles, Aerosols, Cloud, Rain', ... 2C3
                 'User-Defined Aerosol and Cloud Parameters, Altitude Region Control', ... 2D
                 'User-Defined Aerosol and Cloud Parameters, AWCCON and Layer Title', ... 2D1
                 'User-Defined Aerosol and Cloud Parameters, Extinction, Absorption, Assymetry', ... 2D2
                 'User-Defined Cloud Parameters, Layer Altitudes and Content', ... 2E1
                 'User-Defined Cloud Parameters, Spectral Data', ... 2E2
                 'Line-Of-Sight (LOS) Geometry, Heights, Zenith Angle, Range', ... 3
                 'Line-Of-Sight (LOS) and Transmitted Solar/Lunar Irradiance, Heights, Day-Of-Year, Source', ... Alt3
                 'Solar/Lunar Scattering Geometry, Control, Phase Function Control', ... 3A1
                 'Solar/Lunar Scattering Geometry, Lat, Long, Azimuth', ... 3A2
                 'User-Defined Scattering Phase Functions, Number of Angles, Spectral Dependence', ... 3B1
                 'User-Defined Scattering Phase Functions, Angle, Phase Function per Region', ... 3B2
                 'User-Defined Scattering Phase Functions, Phase Function Data', ... 3C1
                 'User-Defined Scattering Phase Functions, Phase Function Data', ... 3C2
                 'User-Defined Scattering Phase Functions, Phase Function Data', ... 3C3
                 'User-Defined Scattering Phase Functions, Phase Function Data', ... 3C4
                 'User-Defined Scattering Phase Functions, Phase Function Data', ... 3C5
                 'User-Defined Scattering Phase Functions, Phase Function Data', ... 3C6
                 'Spectral Range and Resolution', ... 4
                 'Ground Surface Characterization, Control', ... 4A
                 'Ground Surface Characterization, BRDF Name', ... 4B1
                 'Ground Surface Characterization, BRDF Grid, Angles', ... 4B2
                 'Ground Surface Characterization, BRDF Parameters', ... 4B3
                 'Ground Surface Characterization, Lambertian Spectral Albedo File', ... 4L1
                 'Ground Surface Characterization, Lambertian Spectral Albedo Material', ... 4L2
                 'Repeat Run Option'};  % Card 5 
              
    % The names of the parameters follow.
    % Note that some parameters are vectors or matrices.
    % If a parameter is a vector, the shape of the vector mimics that shape in the .ltn input file
    % if possible. That is, if a parameter is given in a column in the input file, then it is read into
    % a column vector. There may be exceptions to this rule.
                
    ParmNames = {{'MODTRN','SPEED','BINARY','LYMOLC','MODEL','ITYPE','IEMSCT','IMULT','M1','M2','M3','M4','M5','M6','MDEF','I_RD2C','NOPRNT','TPTEMP','SURREF'}, ... % 1
                {'DIS','DISAZM','DISALB','NSTR','SFWHM','CO2MX','H2OSTR','O3STR','C_PROF','LSUNFL','LBMNAM','LFLTNM','H2OAER','CDTDIR','SOLCON','CDASTM','ASTMC','ASTMX','ASTMO','AERRH','NSSALB'}, ... % 1A
                {'USRSUN'}, ... % 1A1
                {'BMNAME'}, ... % 1A2
                {'FILTNM'}, ... % 1A3
                {'DATDIR'}, ... % 1A4
                {'APLUS','IHAZE','CNOVAM','ISEASN','ARUSS','IVULCN','ICSTL','ICLD','IVSA','VIS','WSS','WHH','RAINRT','GNDALT'} ... % 2
                {'ZAER11','ZAER12','SCALE1','ZAER21','ZAER22','SCALE2','ZAER31','ZAER32','SCALE3','ZAER41','ZAER42','SCALE4'}, ... % 2A+
                {'CTHIK', 'CALT', 'CEXT'}, ... % 2A
                {'CTHIK','CALT','CEXT','NCRALT','NCRSPC','CWAVLN','CCOLWD','CCOLIP','CHUMID','ASYMWD','ASYMIP'}, ... % Alt2A
                {'ZCVSA','ZTVSA','ZINVSA'}, ... % 2B
                {'ML','IRD1','IRD2','HMODEL'}, ... % 2C
                {'ZM','P','T','JCHAR','JCHARX'}, ... % 2C1
                {'WMOL'}, ... % 2C2
                {'WMOLX'}, ... % 2C2X
                {'AHAZE', 'EQLWCZ','RRATZ','IHA1','ICLD1','IVUL1','ISEA1','ICHR1'}, ... % 2C3
                {'IREG'}, ... % 2D
                {'AWCCON','TITLE'}, ... % 2D1
                {'VARSPC','EXTC','ABSC','ASYM'}, ... % 2D2
                {'ZCLD','CLD','CLDICE','RR'}, ... % 2E1
                {'WAVLEN','EXTC','ABSC','ASYM','EXTC','ABSC','ASYM'}, ... % 2E2
                {'H1','H2','ANGLE','RANGE','BETA','RO','LENN','PHI'}, ... % 3
                {'H1','H2','ANGLE','IDAY','RO','ISOURC','ANGLEM'}, ... % Alt3
                {'IPARM','IPH','IDAY','ISOURC'}, ... % 3A1
                {'PARM1','PARM2','PARM3','PARM4','TIME','PSIPO','ANGLEM','G'}, ... % 3A2
                {'NANGLS','NWLF'}, ... % 3B1
                {'ANGF','F'}, ... % 3B2
                {'ANGF'}, ... % 3C1
                {'WLF'}, ... % 3C2
                {'F'}, ... % 3C3
                {'F'}, ... % 3C4
                {'F'}, ... % 3C5
                {'F'}, ... % 3C6
                {'V1','V2','DV','FWHM','YFLAG','XFLAG','DLIMIT','FLAGS'}, ... % 4
                {'NSURF','AATEMP'}, ... % 4A
                {'CBRDF'}, ... % 4B1
                {'NWVSRF','SURFZN','SURFAZ'}, ... % 4B2
                {'WVSURF', 'PARAMS1', 'PARAMS2', 'PARAMS3', 'PARAMS4'}, ... % 4B3
                {'SALBFL'}, ... % 4L1
                {'CSALB'}, ... % 4L2                
                {'IRPT'}};    % 5
    
  end % Properties (Hidden)
  properties (Hidden, Transient)
              DebugFlag = 0; % if set true, debug printing of case file reading is provided.
  end % Properties (Hidden, Transient)
  methods (Access = public, Static)
    function [MODTRANExe, MODTRANPath] = SetMODTRANExe(MODTRANExe)
    % SetMODTRANExe : Set the name of the MODTRAN executable file
    % 
    % Usage :
    %    Mod5.SetMODTRANExe(MODTRANExe);
    %        Or
    %    Mod5.SetMODTRANExe;
    %
    % Where MODTRANExe is the full pathname of the MODTRAN executable
    % If the parameter MODTRANExe is omitted or empty, a directory
    % selection dialog will be presented. 
    %
    % MODTRANExe is saved in the file MODTRANExe.mat, and is read whenever
    % MODTRAN-related functions need to know where MODTRAN is. It is used
    % particularly by Mod5.Run. It only needs to be set once after MODTRAN
    % installation, or if you move or reinstall MODTRAN somewhere else.
    %
    % See Also : Mod5.Write, Mod5.Run
    
    ExpectedMODTRAN = 'Mod5.2.0.0_cons.exe';
    if ~exist('MODTRANExe', 'var') || isempty(MODTRANExe)
      [MODTRANExe, MODTRANPath] = uigetfile('*.exe','Select MODTRAN Executable. This is a once-off operation.');
      if ~ischar(MODTRANExe)
        warning('SetMODTRANExe:ExeNotSet','The MODTRAN executable file was not set.');
        return;
      end
    else
      assert(ischar(MODTRANExe), 'Input MODTRANExe must be a string.')
    end
    
    if ~strcmpi(MODTRANExe, ExpectedMODTRAN)
      warning('SetMODTRANEExe:MODTRANVers', ['This class currently supports ' ExpectedMODTRAN ' and may not work with other versions.']);
    end
    MODTRANExe = [MODTRANPath MODTRANExe];
    if ~exist(MODTRANExe, 'file')
      error('MODTRANExe must be an existing MODTRAN executable file.')
    end
    Direc = fileparts(which('Mod5.m'));
    % Save the root directory to a file for later use by other Mod5 functions
    save([Direc '\MODTRANExe.mat'], 'MODTRANPath', 'MODTRANExe');   
    
    end % function SetMODTRANExe
    function CasePath = SetCasePath(CaseDirectory)
    % SetCasePath : Set the default directory for MODTRAN case files (.ltn, .tp5)
    %
    % Usage :
    %
    %  Mod5.SetCasePath(CaseDirectory)
    %    Or
    %  Mod5.SetCasePath;  % Opens directory browse dialog
    %
    % Sets the default case directory used by Mod5.
    %
    if ~exist('CaseDirectory', 'var') || isempty(CaseDirectory)
      CaseDirectory = uigetdir(pwd,'Select Case Directory');
      if ~ischar(CaseDirectory)
        warning('SetCasePath:CasePathNotSet','The default MODTRAN case directory was not set.');
        return;
      end
    else
      assert(ischar(CaseDirectory) && exist(CaseDirectory, 'dir'), 'Input CaseDirectory must be a string and a valid, existing directory.')
    end
    CasePath = CaseDirectory; % it exists !
    % Save the root directory to a file for later use by other Mod5 functions
    Direc = fileparts(which('Mod5.m'));
    save([Direc '\Mod5Dir.mat'], 'CaseDirectory');   
      
    end % SetCasePath
    function [MODExe, MODPath] = WhereIsMODTRAN
      % WhereIsMODTRAN : Displays the location of your MODTRAN executable
      %
      % Usage:
      %   Mod5.WhereIsMODTRAN
      %
      % To set the location of your MODTRAN executable use SetMODTRANExe.
      % If you have not set your MODTRAN executable location, then
      % SetMODTRANExe will be called the first time you use the Run method.
      %
      
      persistent MODTRANPath MODTRANExe
      %% Deal with location of the MODTRAN executable
      MODExe = 'Unknown';
      MODPath = 'Unknown';
      if isempty(MODTRANExe)
        MODTRANExeFile = [fileparts(which('Mod5.m')) '\MODTRANExe.mat'];
        if exist(MODTRANExeFile, 'file')
          load(MODTRANExeFile);
          if ~exist(MODTRANExe, 'file') % Check that the MODTRAN executable exists
            fprintf(1, 'The MODTRAN executable file location has been previously set, but the executable file does not exist.\n');
            fprintf(1, 'Set the location of the MODTRAN executable using Mod5.SetMODTRANExe.\n');
          else
            MODExe = MODTRANExe;
            MODPath = MODTRANPath;
          end          
        else
          fprintf(1, 'The MODTRAN executable file has not been set.\n');
          fprintf(1, 'Set the location of the executable using Mod5.SetMODTRANExe.\n');
          % [MODTRANExe, MODTRANPath] = Mod5.SetMODTRANExe;
        end
      end
      
    end % function WhereIsMODTRAN
    function Valid = isValidFilename(fn)
      % isValidFilename : Check that a string is a valid filename (Windows)
      %
      % Usage :
      %  Valid = Mod5.isValidFilename(fn)
      % 
      % The valid filenames are contrained by Windows requirements, which
      %   are usually more restrictive than Unix-style filename.
      %
      % While Windows allows filenames longer than 80 characters, MODTRAN 4
      %   makes a retriction of 80 characters per Card. To give some headroom
      %   for appending stuff to filenames, the name is restricted to
      %   less than 75 characters.
      %
      
      % Name cannot be empty, must be shorter than 75 characters
      % Name may not start or end with a ' ', or end with a '.'
      if ~ischar(fn) || isempty(fn) || numel(fn) >= 75 || fn(1) == ' ' || fn(end) == ' ' || fn(end) == '.'
        Valid = false;
        return;
      end
      % Check for bad things on Windows inherited from DOS
      DOSCrud = {'CON','PRN','AUX','NUL','COM1','COM2','COM3','COM4','COM5','COM6','COM7','COM8','COM9',...
                 'LPT1','LPT2','LPT3','LPT4','LPT5','LPT6','LPT7','LPT8','LPT9'};
      iMatch = strmatch(upper(fn), DOSCrud, 'exact');
      if ~isempty(iMatch)
        Valid = false;
        return;
      end
      % Get the non-alphanumeric characters
      n = fn(~isstrprop(fn, 'alphanum'));
      % Check for forbidden characters, there are other forbidden things, but hope they don't crop up
      Valid = ~any( n <= 31 | n == '<' | n == '>' | n == ':' | n == '"' | n == '/' | ...
                    n == '\' | n == '|' | n == '?' | n == '*' | all(n == '.'));
    end % isValidFilename
    function FixedHeaders = FixHeaders(Headers)
      % FixHeaders : Corrects some of the problems with column headers in MODTRAN output
      % Both input and output are cell arrays of strings.
      assert(iscellstr(Headers), 'Mod5_FixHeaders:BadInput','Input parameter Headers must be a cell array of strings.');
      FixedHeaders = Headers;
      for iHead = 1:numel(Headers)
        switch Headers{iHead}
          case 'FREQ CM-1', FixedHeaders{iHead} = 'FREQ';
          case 'FREQ (CM-1)', FixedHeaders{iHead} = 'FREQ';
          case 'FREQ(CM-1)', FixedHeaders{iHead} = 'FREQ';
          case 'FREQ NANOMETER', FixedHeaders{iHead} = 'WAVLNM';
          case 'WAVLEN(NM)', FixedHeaders{iHead} = 'WAVLNM';
          case 'WAVLEN (uM)', FixedHeaders{iHead} = 'WAVLUM';
          case 'WAVLEN(MCRN)', FixedHeaders{iHead} = 'WAVLUM';
          case 'FREQMCRN', FixedHeaders{iHead} = 'WAVLUM';
          case 'TRAN', FixedHeaders{iHead} = 'TRANS';
          case 'TOT TRANS', FixedHeaders{iHead} = 'TRANS';
          case 'TOTAL TRANS', FixedHeaders{iHead} = 'TRANS';
          case 'CO2+ TRANS', FixedHeaders{iHead} = 'CO2PTRANS';
          case 'SOL T', FixedHeaders{iHead} = 'SOLTR';
          case 'OLAR', FixedHeaders{iHead} = 'SOLAR';
          case 'EQ -1', FixedHeaders{iHead} = 'FREQ';
          case 'REQ M-1', FixedHeaders{iHead} = 'FREQ';            
          case '', FixedHeaders{iHead} = 'DEPTH';
          % Probably others I don't know about yet  
          otherwise
            % Remove anything that is not a letter or a number (including blanks)
            FixedHeaders{iHead} = upper(Headers{iHead}(isstrprop(Headers{iHead}, 'alphanum'))); 
        end
      end
    end % FixHeaders
    function Descr = LookupHeaders(Headers)
      % LookupHeaders : Find descriptions for MODTRAN output data headers
      % There is a question mark over "Aerosol Absorptance".
      persistent Header Description
      Descr = {};
      if isempty(Headers)
        return;
      end
      assert(ischar(Headers) || iscellstr(Headers), 'Mod5:LookupHeaders:BadHeaders', ...
        'Input Headers must be a string or cell array of strings');
      if isempty(Description)
        OutputDescr = {'TRANS','Total Transmittance'; 'SOLTR','Transmitted Solar Irradiance'; 'SOLAR','Incident Solar Irradiance'; ...
          'LOGTRANS','Total Optical Depth'; 'FREQ', 'Wavenumber (cm^-1)'; 'FREQMCRN', ['Wavelength (' char(181) 'm)']; ...
          'FREQNM', 'Wavelength (nm)'; 'PTHTHRML', 'Path Thermal Radiance'; 'THRMLSCT', 'Scattered Thermal Radiance'; ...
          'SURFEMIS','Surface Emission Radiance'; 'SOLSCAT', 'Scattered Solar Radiance'; 'SINGSCAT', 'Single Scattered Radiance'; ...
          'GRNDRFLT', 'Total Ground Reflected Radiance'; 'DRCTRFLT', 'Direct Ground Reflected Radiance'; ...
          'TOTALRAD', 'Total Radiance'; 'REFSOL', 'Reflected Solar Radiance'; 'SOLOBS', 'Backscattered Solar at Observer Radiance'; ...
          'DEPTH', 'Optical Depth'; 'H2OTRANS', 'Water (Band Model) Transmittance'; 'CO2PTRANS', 'CO2+ Transmittance'; ...
          'O3TRANS', 'Ozone Transmittance'; 'TRACETRANS', 'Trace Gases Transmittance'; 'N2CONT', 'Nitrogen Continuum Transmittance'; ...
          'H2OCONT', 'Water Continuum Transmittance'; 'MOLECSCAT', 'Molecular Scattering Transmittance'; ...
          'AERTRANS', 'Aerosol Transmittance'; 'HNO3TRANS', 'Nitric Acid Transmittance'; 'AERABTRANS', 'Aerosol Unabsorbed Transmittance'; ...
          'LOGTOTAL', 'Optical Depth'; 'CO2TRANS', 'Carbon Dioxide Transmittance'; ...
          'COTRANS', 'Carbon Monoxide Transmittance'; 'CH4TRANS', 'Methane Transmittance'; ...
          'N2OTRANS', 'Nitrous Oxide Transmittance'; 'O2TRANS', 'Oxygen Transmittance'; 'NH3TRANS','Ammonia Transmittance'; ...
          'NOTRANS', 'Nitric Oxide Transmittance'; 'NO2TRANS','Nitrogen Dioxide Transmittance'; ...
          'SO2TRANS', 'Sulphur Dioxide Transmittance'; 'H2OOD', 'Water (Band Model) Optical Depth'; 'CO2POD', 'CO2+ Optical Depth'; ...
          'O3OD', 'Ozone Optical Depth'; 'TRACEOD', 'Trace Gases Optical Depth'; 'N2CONTOD', 'Nitrogen Continuum Optical Depth'; ...
          'H2OCOD', 'Water Continuum Optical Depth'; 'MOLECOD', 'Molecular Scattering Optical Depth'; ...
          'AEROD', 'Aerosol Optical Depth'; 'HNO3OD', 'Nitric Acid Optical Depth'; 'AERABOD', 'Aerosol Absorption Optical Depth'; ...
          'LOGTOTAL', 'Total Optical Depth'; 'CO2OD', 'Carbon Dioxide Optical Depth'; ...
          'COOD', 'Carbon Monoxide Optical Depth'; 'CH4OD', 'Methane Optical Depth'; ...
          'N2OOD', 'Nitrous Oxide Optical Depth'; 'O2OD', 'Oxygen Optical Depth'; 'NH3OD','Ammonia Optical Depth'; ...
          'NOOD', 'Nitric Oxide Optical Depth'; 'NO2OD','Nitrogen Dioxide Optical Depth'; ...
          'SO2OD', 'Sulphur Dioxide Optical Depth'; 'COMBINTRANS', 'Total Transmittance'; 'LOGCOMBIN', 'Total Optical Depth'; ...
          'AERCLDTRANS', 'Aerosol and Cloud Transmittance'; 'AERCLDABTRNS', 'Aerosol and Cloud Unabsorbed Transmittance'; ...
          'CLOUDTRANS', 'Cloud Transmittance'; 'CLOUDOD', 'Cloud Optical Depth'; ...
          'CFC11TRANS', 'CFC11 Transmittance'; 'CFC11OD', 'CFC11 Optical Depth'; ...
          'CFC12TRANS', 'CFC12 Transmittance'; 'CFC12OD', 'CFC12 Optical Depth'; ...
          'CFC13TRANS', 'CFC13 Transmittance'; 'CFC13OD', 'CFC13 Optical Depth'; ...
          'CFC14TRANS', 'CFC14 Transmittance'; 'CFC14OD', 'CFC14 Optical Depth'; ...
          'CFC22TRANS', 'CFC22 Transmittance'; 'CFC22OD', 'CFC22 Optical Depth'; ...
          'CFC113TRANS', 'CFC113 Transmittance'; 'CFC113OD', 'CFC113 Optical Depth'; ...
          'CFC114TRANS', 'CFC114 Transmittance'; 'CFC114OD', 'CFC114 Optical Depth'; ...
          'CFC115TRANS', 'CFC115 Transmittance'; 'CFC115OD', 'CFC115 Optical Depth'; ...
          'CCL4TRANS', 'Carbon Tetra-Chloride Transmittance'; 'CCL4OD', 'Carbon Tetra-Chloride Optical Depth'; ...
          'CLONO2TRANS', 'Chlorine Nitrate Transmittance'; 'CLONO2OD', 'Chlorine Nitrate Optical Depth'; ...
          'HNO4TRANS', 'Peroxynitrous Acid Transmittance'; 'HNO4OD', 'Peroxynitrous Acid Optical Depth'; ...
          'N2O5TRANS', 'Dinitrogen Pentoxide Transmittance'; 'N2O5OD', 'Dinitrogen Pentoxide Optical Depth'; ...
          'CHCL2FTRANS', 'Dichlorofluoromethane Transmittance'; 'CHCL2FOD', 'Dichlorofluoromethane Optical Depth'; ...
          'DIREM', 'Directional Emissivity'; 'BBODYTK', 'Brightness Temperature'; ...
          'WAVLNM', 'Wavelength (nm)'; 'WAVLUM', ['Wavelength (' char(181) 'm)']; ...
          };
        Header = OutputDescr(:,1);
        Description = OutputDescr(:,2);
      end
      if ischar(Headers) % Convert to a cell array of strings
        Headers = strtrim(cellstr(Headers));
      end
      for iHead = 1:length(Headers)
        iFind = strmatch(upper(Headers{iHead}), upper(Header), 'exact');
        if ~isempty(iFind)
          Descr{iHead} = Description{iFind(1)};
        else
          Descr{iHead} = '';  % Not found, return empty string, not empty array
        end
      end
      if isempty(Descr)
        disp(Headers);
        warning('Mod5:LookupHeaders:NotFound','Above header not found in data.')
      end
    end % LookupHeaders
    function Alb = CreateAlb(Header, title, wv, refl)
      % CreateAlb : Create a lambertian reflectance (albedo) data structure
      %
      % Usage :
      %
      %  Alb = Mod5.CreateAlb(Header, title, wv, refl);
      %
      % Where :
      %  Header is a string array or cell array of strings giving a
      %    description of the albedo data being created.
      %  title is string comprising an integer label, followed by
      %    a text description, optionally followed by a comment that
      %    begins with a '!' (exclamation mark). There may not be any
      %    decimal points '.' before the start of the comment.
      %  wv is a vector of wavelengths in microns at which the albedo
      %    data is to be defined. wv must be increasing.
      %  refl is a vector of the same length as wv that the gives the
      %    albedo data.
      %
      % The returned structure Alb has the following fields, that are
      %   mostly just validated copies of the input parameters.
      %
      %   Filename : This field will be empty
      %     Header : The Header data given, in a char array.
      %      title : The validated title input
      %         wv : The wavelengths in µm given
      %       refl : The reflectance the material at the given wavelengths.
      %
      % To create multiple albedo curves, multiple calls to CreateAlb are
      %   required, together with concatenation into a single vector.
      %
      % Example :
      %   MyAlb = Mod5.CreateAlb({'Albedo data for green slime.', 'Created by Schrek.'}, ...
      %                      '  1  Green Slime ! Sample A', [0.4 0.45 0.5 0.55 0.6 0.65], ...
      %                      [0.1 0.3 0.7 0.9 0.5 0.1]);
      %   Mod5.PlotAlb(MyAlb);  % Plot the albedo
      %   Mod5.WriteAlb(MyAlb, 'GreenSlime.alb'); % Write albedo file in MODTRAN spec_alb format.
      %
      % See Also : ReadAlb, WriteAlb, PlotAlb, ReadAlbFromUSGS, ReadAlbFromASD
      %            AttachAlb
      %
      
      % Create empty structure
      Alb = struct('Filename', {}, 'Header', {}, 'title', {}, 'wv', {}, 'refl', {});
      % Validate inputs
      assert(ischar(Header) || iscellstr(Header), 'Mod5:CreateAlb:BadHeader', ...
        'Input Header must be a char array (string) or cell array of strings.');
      if iscellstr(Header)
        Alb(1).Header = strvcat(Header);
      else
        Alb(1).Header = Header;
      end
      assert(ischar(title) && ~isempty(title), 'Mod5:CreateAlb:Badtitle', ...
        'Input title must be a string with a numeric tag and a text name, seperated by one or more spaces e.g. '' 1  Black Tar''');
      [AlbName, AlbIndex] = Mod5.AlbedoName(title);
      assert(~isempty(AlbIndex) && ~isnan(AlbIndex), 'Mod5:CreateAlb:Badtitle', ...
        'Input title must be a string with a numeric tag and a text name, seperated by one or more spaces e.g. '' 1  Black Tar''');
      assert(~isempty(AlbName) && ~any(AlbName == '.'), 'Mod5:CreateAlb:Badtitle', ...
        'There is no valid text name in the title input. There may not be decimal points in the title before the comment.');
      assert(isnumeric(wv) && isvector(wv) && all(wv > 0), 'Mod5:CreateAlb:Badwv', ...
        'Input wv must be a positive numeric vector of wavelengths in microns.');
      assert(isnumeric(refl) && isvector(refl) && all(refl >= 0) && all(refl <= 1) && numel(wv)==numel(refl), 'Mod5:CreateAlb:Badrefl', ...
        'Input refl must be a numeric vector of length identical to input wv, with elements having values from 0 to 1.');
      Alb(1).title = title;
      Alb(1).wv = reshape(wv, numel(wv), 1);  % Make it a column vector
      Alb(1).refl = reshape(refl, numel(refl), 1); % Make it a column vector
    end % CreateAlb
    function Alb = ReadAlb(Filename)
      % ReadAlb : Read spectral albedo (reflectance) data from MODTRAN spec_alb format file
      %
      % Usage:
      %
      %  Alb = Mod5.ReadAlb(Filename)
      %
      % Where Filename is the name of the file from which to read MODTRAN
      %   format spectral albedo data. If the Filename is not given or
      %   is empty, a file/open dialog will be presented.
      %
      % The returned structure Alb has the following fields:
      %
      %   Filename : The name of the file from which the data was read.
      %     Header : The comments (lines starting with !) prior to the albedo data
      %      title : The title of the material or substance
      %         wv : The wavelengths at which the albedo is given in µm
      %       refl : The reflectance (albedo) of the material at the given wavelengths.
      %
      % Here are the rules for a valid MODTRAN spectral albedo file.
      %  Lines beginning with an exclamation (!) are ignored.
      %  Comments after an exclamation are also ignored.
      %  
      %  Each surface is defined by a positive integer label
      %  a surface name, and its spectral data.  The integer label
      %  and surface name must appear as a pair on a header line
      %  with the integer label followed by a blank.
      %  
      %  Header lines must not include a decimal point (.) before an
      %  exclamation, and spectral data must include a decimal point.
      %  
      %  Spectral data is entered with one wavelength (in microns)
      %  and one spectral albedo per line, separated by one or more
      %  blanks.  The spectral wavelengths for each surface type must
      %  be entered in increasing order, and be spectral albedos
      %  should be between 0. and 1., inclusively.
      %  
      %  The first 80 characters of each line is read in.
      %      
      % See Also : ReadAlbFromASD, ReadAlbFromUSGS, WriteAlb, PlotAlb,
      %            CreateAlb, MixAlb, AttachAlb
      
      Alb = struct('Filename', {}, 'Header', {}, 'title', {}, 'wv', {}, 'refl', {});
      %%  Verify Filename input or open dialog as appropriate
      if ~exist('Filename', 'var') || isempty(Filename)
        MODTRANPath = '';
        % Check for default case directory
        Direc = fileparts(which('Mod5.m'));
        if exist([Direc '\MODTRANExe.mat'], 'file');
          load([Direc '\MODTRANExe.mat']);
        end
        
        % Use dialog
        if isempty(MODTRANPath)
          [Filename, Pathname] = uigetfile({'*.dat', 'MODTRAN Spectral Albedo Files (*.dat)'; ...
                                            '*.alb', 'MODTRAN Spectral Albedo Files (*.alb)'; ...
                                            '*.*', 'All Files'}, 'Select MODTRAN Spectral Albedo File');
        else
          [Filename, Pathname] = uigetfile({'*.dat', 'MODTRAN Spectral Albedo Files (*.dat)';...
                                            '*.alb', 'MODTRAN Spectral Albedo Files (*.alb)'; ...
                                            '*.*', 'All Files'}, 'Select MODTRAN Spectral Albedo File', MODTRANPath);
        end
        if Filename
          Filename = [Pathname Filename];
        else
          return;
        end
      else % Filename is not empty, meaning that an explicit filename was given
        assert(ischar(Filename), 'Mod5:ReadFlt:FilenameNotString', 'Input Filename must be a string.');
        if ~exist(Filename, 'file')
          error('Mod5:ReadFlt:FileDoesNotExist', ...
            'The file %s does not seem to exist. Provide full path if not in current directory.', Filename);
        end
      end
      
      try % to read the spectral albedo file
        iAlb = 0; % This will count the number of material (surface type) entries
        theHeader = '';
        fid = fopen(Filename, 'rt');
        while ~feof(fid)
          lin = fgetl(fid);
          tlin = strtrim(lin);
          if ~isempty(tlin) && tlin(1) == '!'
            tlin(1) = ' ';
            theHeader = strvcat(theHeader, tlin);
          elseif ~isnan(str2double(strtok(lin))) % Seem to have found a material entry
            theData = textscan(fid, '%f %f');
            if ~any(isnan(theData{1})) && ~any(isnan(theData{2})) && all(diff(theData{1}) > 0)
              iAlb = iAlb + 1;
              Alb(iAlb).Filename = Filename;
              Alb(iAlb).Header = theHeader;
              Alb(iAlb).title = lin;
              Alb(iAlb).wv = theData{1};
              Alb(iAlb).refl = theData{2};
              theHeader = '';
            end
          end
        end
        fclose(fid);
      catch AlbReadFailed
        fclose(fid);
        rethrow(AlbReadFailed)
      end
      Alb = Alb'; % Return a column vector by default
    end % ReadAlb
    function Alb = ReadAlbFromUSGS(Filename)
      % ReadAlbFromUSGS : Read spectral reflectance data from USGS splib06a ascii file
      %
      % Usage :
      %  Alb = Mod5.ReadAlbFromUSGS(Filename);
      %
      % Where Filename is a string or cell array giving the Filename or names
      %  of the USGS spectral library (splib06a) files(s) to read. These files must
      %  be the ascii text files (.asc) version of the spectra.
      %  For more information and USGS spectral library downloads, go to
      %   http://speclab.cr.usgs.gov/spectral-lib.html
      %  If the input Filename is missing or empty, a file/open dialog is
      %  presented which allows multiple selection of splib files. 
      %
      % Alb is a structure (or vector of structures if multiple files were
      %  read/selected), containing the follwing fields:
      %
      %   Filename : The name of the file from which the data was read.
      %     Header : The comments (lines starting with !) prior to the albedo data
      %      title : The title of the material or substance
      %         wv : The wavelengths at which the albedo is given in µm
      %       refl : The reflectance (albedo) of the material at the given wavelengths.
      %
      % See Also : ReadAlb, WriteAlb, ReadAlbFromASD, PlotAlb, AttachAlb
      %            CreateAlb, MixAlb
      
      Alb = struct('Filename', {}, 'Header', {}, 'title', {}, 'wv', {}, 'refl', {});      
      % Get the data from the USGS files
      if exist('Filename', 'var') && ~isempty(Filename)
        SData = Mod5.ReadUSGSsplib06a(Filename);
      else
        SData = Mod5.ReadUSGSsplib06a;
      end
      % Unpack the spectral data into the Alb structure
      for iAlb = 1:numel(SData)
        Alb(iAlb).Filename = SData(iAlb).Filename;
        [Pn Fn] = fileparts(SData(iAlb).Filename);
        Alb(iAlb).Header = SData(iAlb).Header;
        TheTitle = SData(iAlb).title;
        Toks = textscan(TheTitle, '%s');
        TheTitle = Toks{1}{1}; % Hopefully there is at least one
        if numel(Toks{1}) > 1
          for iTok = 2:numel(Toks{1})
            TheTitle = [TheTitle '_' Toks{1}{iTok}];
          end
        end
        TheTitle = genvarname(strrep(TheTitle, ' ', '_'));
        Alb(iAlb).title = sprintf('    %i   %s', iAlb, TheTitle);
        wv = SData(iAlb).wv;
        refl = SData(iAlb).refl;
        % Remove any NaN or negative data at the beginning
        while isnan(refl(1)) || refl(1) < 0
          refl(1) = [];
          wv(1) = [];
        end
        % and at the end
        while isnan(refl(end)) || refl(end) < 0
          refl(end) = [];
          wv(end) = [];
        end
        % Now check for any bad data in between
        iGoodData = ~isnan(refl) & refl >= 0;
        if any(~iGoodData) % If there are bad points in between, issue a warning, because there could be big gaps in the data
          warning('Mod5:ReadAlbFromUSGS:DeletedData', ...
            'Spectral data titled "%s" from file "%s" is not contiguous (internal deleted points). Check the data before using.', ...
            SData(iAlb).title, SData(iAlb).Filename);
        end
        Alb(iAlb).wv = wv(iGoodData);
        Alb(iAlb).refl = refl(iGoodData);
      end
      Alb = Alb';
    end % ReadAlbFromUSGS
    function SpectralData = ReadUSGSsplib06a(Filename)
      % ReadUSGSsplib06a : Read spectral reflectance data from the USGS splib06a database
      % Usage :
      %  SpectralData = Mod5.ReadUSGSsplib06a(Filename)
      %
      %  Where Filename is the splib text data file. Filename can also be a
      %  cell array of strings with multiple files.
      %
      %  If no filename is given, a file open dialog will be presented. Multiple
      %  files can be selected. If multiple files are given or selected, a
      %  column vector of structures will be returned.
      %
      %  The returned spectral data is a structure with the following fields.
      %       Filename: The filename of the file from which the data was read
      %        Version: The version of the USGS speclib database e.g. 'speclib06a'
      %         Header: The header of the file (all text before start of numeric data)
      %           Year: The year of the data file
      %     DataSeries: The data series of the data file
      %          title: The title of the data e.g. 'Seawater_Coast_Chl SW1 W1R1Ba AREF'
      %        history: History of the data.
      %             wv: Wavelengths of the reflectance data in microns
      %           refl: The reflectance of the substance/material at the wavelengths
      %         stddev: The standard deviation of the reflectance at the given wavelength
      %
      % Deleted values and standard deviations not measured are returned as NaNs.
      %
      % See Also : PlotUSGSspeclib06a
      %
      % This function replaces the deprecated function ReadUSGSspeclib05a
      %
      % Reference : http://speclab.cr.usgs.gov/spectral-lib.html
      
      persistent USGSPath
      SpectralData = [];
      Pathname = '';
      if exist('Filename', 'var') && ~isempty(Filename)
        assert(ischar(Filename) || iscellstr(Filename), 'Mod5:ReadUSGSsplib06a:BadFilename', ...
          'Input Filename must be a string or cell array of strings.');
      else
        if isempty(USGSPath)
          [Filename, Pathname] = uigetfile('*.asc','Open USGS splib06a ASCII File(s)', 'MultiSelect', 'on');
        else
          [Filename, Pathname] = uigetfile('*.asc','Open USGS splib06a ASCII File(s)', USGSPath, 'MultiSelect', 'on');     
        end
        if ~ischar(Filename) && ~iscellstr(Filename) % User cancelled
          return;
        end
      end
      USGSPath = Pathname; % Remember last location of USGS data read
      if ischar(Filename)
        Filename = cellstr(Filename);
      end
      
      for iFile = 1:numel(Filename)
        if ~exist([Pathname Filename{iFile}], 'file')
          error(['Mod5:ReadUSGSsplib06a:Filename ' Filename{iFile} ' not found.']);
        end
      end
      
      for iFile = 1:numel(Filename)
        fid = fopen([Pathname Filename{iFile}], 'r');
        SpectralData(iFile).Filename = Filename{iFile};
        ilin = 1;
        lin = fgetl(fid);
        [A, count] = sscanf(lin, 'USGS Digital Spectral Library %s');
        if count == 1
          SpectralData(iFile).Version = char(A);
        else
          warning('Mod5:ReadUSGSspeclib06a:FileFormatSuspect', ...
            'This file may not be the correct format. Ensure you have the individual .asc spectral files.')
        end
        
        historyline = 0; % History line of data
        titleline = 0; % Title line of data
        startline = 0; % Starting line of data
        deletednumber = [];
        notmeasuredstddev = [];
        nCol = 0; % number of columns
        SpectralData(iFile).Header = lin;
        while ~feof(fid)
          ilin = ilin + 1;
          lin = fgetl(fid);
          SpectralData(iFile).Header = strvcat(SpectralData(iFile).Header, lin);     % Record the full header
          [A, count] = sscanf(lin, 'Clark %*s %*s %i, USGS, Data Series %f');
          if count == 2
            SpectralData(iFile).Year = A(1);
            SpectralData(iFile).DataSeries = A(2);
          end
          [tok, rest] = strtok(lin);
          if strcmp(tok, 'line')
            [tok, rest] = strtok(rest);
            linenumber = str2double(tok);
            rest = strtrim(rest);
            [nCol, count] = sscanf(rest, 'to end:  %i-columns of data:');
            if strcmp(rest, 'title')
              titleline = linenumber;
            elseif strcmp(rest, 'history')
              historyline = linenumber;
            elseif count == 1
              startline = linenumber;
              
            end
          end
          [A, count] = sscanf(lin, '(      %f  indicates a deleted number)');
          if count == 1
            deletednumber = A;
          end
          [A, count] = sscanf(lin, '(standard deviation of %f means not measured)');
          if count == 1
            notmeasuredstddev = A;
          end
          
          if ilin == titleline
            TheTitle = lin;
            SpectralData(iFile).title = TheTitle;
          end
          if ilin == historyline
            SpectralData(iFile).history = lin;
          end
          if ilin == startline - 1 % Scan the data using textscan
            if nCol ~= 3
              warning('Mod5:ReadUSGSspeclib06a:nColProblem', ...
                'There should be three columns of data in the speclib file %s. There may only be %i.', Filename{iFile}, nCol);
            end
            specdata = textscan(fid, '%f %f %f');
            SpectralData(iFile).wv = specdata{1};
            SpectralData(iFile).refl = specdata{2};
            SpectralData(iFile).stddev = specdata{3};
            
            % Replace deleted values with NaN
            if ~isempty(deletednumber)
              SpectralData(iFile).wv(SpectralData(iFile).wv == deletednumber) = NaN;
              SpectralData(iFile).refl(SpectralData(iFile).refl == deletednumber) = NaN;
              SpectralData(iFile).stddev(SpectralData(iFile).stddev == deletednumber) = NaN;
            else
              warning('Mod5:ReadUSGSsplib06a:FormatSuspect',...
                'There could be a format problem with file %s.', Filename{iFile});
            end
            % Replace unmeasured standard deviations with NaN as well
            if ~isempty(notmeasuredstddev)
              SpectralData(iFile).stddev(SpectralData(iFile).stddev == notmeasuredstddev) = NaN;
            end
            
          end
        end
        
        fclose(fid);
      end
      SpectralData = SpectralData'; % Make it a column vector
    end % ReadUSGSsplib06a     
    function Alb = ReadAlbFromASD(Filename)
      % ReadAlbFromASD : Read albedo (reflectance) data from ASD text file
      %
      % Analytical Spectral Devices manufacture a range of spectroradiometers
      % many for field use. The FieldSpec 3 is a field instrument that is
      % used to measure reflectance and radiance. This function requires
      % a text file exported from ASD ViewSpec software. The data must
      % reflectance data exported with full headers.
      %
      % Usage :
      %  Alb = Mod5.ReadAlbFromASD(Filename);
      %    Or just ..
      %  Alb = Mod5.ReadAlbFromASD; % Get file/open dialog
      %
      % Where :
      %  Filename is the file from which to read the ASD text data.
      %    Filename can also be a cell array of strings giving multiple
      %    files. If Filename is missing or empty, a file/open dialog
      %    will be presented in which it is possible to select multiple
      %    files.
      %
      % Alb is a returned structure with the following fields:
      %
      %   Filename : The name of the file from which the ASD data was read.
      %     Header : The header data in the ASD file
      %      title : The title of the material or substance
      %         wv : The wavelengths at which the albedo is given in µm
      %       refl : The reflectance (albedo) of the material at the given wavelengths.      
      %
      % The title field will contain the filename suitably sanitised.
      %
      % See Also : ReadAlb, WriteAlb, PlotAlb, ReadAlbFromUSGS, AttachAlb
      %            MixAlb
      Alb = struct('Filename', {}, 'Header', {}, 'title', {}, 'wv', {}, 'refl', {});      
      % Get the data from the ASD files
      if exist('Filename', 'var') && ~isempty(Filename)
        SData = Mod5.ReadASDtxtMulti(Filename);
      else
        SData = Mod5.ReadASDtxtMulti;
      end
      % Unpack the ASD data into an Alb structure
      for iAlb = 1:numel(SData)
        Alb(iAlb).Filename = SData(iAlb).txtFilename;
        Alb(iAlb).Header = strvcat(SData(iAlb).HeaderTxt);
        [Pn, Fn] = fileparts(Alb(iAlb).Filename);
        Alb(iAlb).title = sprintf('   %i   %s', iAlb, genvarname(Fn)); % Sanitise the file name
        Alb(iAlb).wv = SData(iAlb).Wv/1000; % Convert to microns
        Alb(iAlb).refl = SData(iAlb).RadData;
      end
      Alb = Alb';
      
    end % ReadAlbFromASD
    function ASDData = ReadASDtxt(Filename)
      % ReadASDtxt : Read radiometric text data exported from ASD Viewspec
      %
      % ASD is Analytical Spectral Devices. This function was written for the
      % ASD FieldSpec 3 instrument. The data should be exported from ViewSpec
      % with complete headers, which means that there is a single spectrum per
      % file. The wavelengths must be exported rather than spectral bin numbers.
      %
      % Usage :
      %  >> ASDData = Mod5.ReadASDtxt(Filename)
      %
      % Where :
      %   Filename is the name of the text file from which to read the data. If
      %   this input is missing or empty, a File/Open dialog will be presented.
      %
      %   ASDData is a structure which may contain the following fields.
      %
      %                 HeaderTxt: The complete text of the file header in a cell
      %                            array of strings.
      %               txtFilename: The filename of the text file.
      %               ASDFilename: The filename of the ASD binary file from which
      %                            the text file was exported from ViewSpec.
      %                   Comment: A comment entered at the time of export.
      %               InstrNumber: The serial number of the ASD radiometer.
      %                  ProgVers: The version of ViewSpec which exported the
      %                            file.
      %                  FileVers: The version of the file format (presumably).
      %                   DateVec: Six element numeric date vector of time that
      %                            the spectrum was supposedly saved.
      %                  DateTime: Text version of the DateVec.
      %                SerialDate: Serial date of the DateVec.
      %               VNIRintTime: VNIR channel integration time.
      %               VNIRChan1Wv: Start wavelength of VNIR channel in nm.
      %             VNIRChan1Step: Step in VNIR wavelength in nm.
      %           SamplesPerValue: Number of spectra averaged for this spectrum.
      %                      xmin: Minimum wavelength.
      %                      xmax: Maximum wavelength.
      %                      ymin: Minimum y-value (radiance, irradiance or DN)
      %                      ymax: Maximim y-value
      %                  BitDepth: Bit depth of data digitized by the
      %                            radiometer.
      %                 SWIR1Gain: Gain in SWIR 1 channel.
      %               SWIR1Offset: Offset in SWIR 1 channel.
      %                 SWIR2Gain: Gain in SWIR2 channel.
      %               SWIR2Offset: Offset in SWIR 2 channel.
      %             VNIRjoinSWIR1: Switchover wavelength from VNIR to SWIR1.
      %            SWIR1joinSWIR2: Switchover wavelength from SWIR1 to SWIR2.
      %     VNIRDarkSigSubtracted: Flag indicating if VNIR dark signal was
      %                            subtracted from data.
      %               NumDarkMeas: Number of dark signal spectra averaged.
      %          DarkMeasDateTime: Date/Time at which dark signal was measured.
      %        DarkMeasSerialDate: Serial date at which dark signal was measured.
      %                    DCCVal: DCC value (?).
      %                WhiteRefed: Flag indicating if data is referenced to a
      %                            white reference or not.
      %                 ForeOptic: Description of foreoptic if any.
      %               FileContent: Description of file content.
      %                    GPSLat: GPS latitude in decimal degrees if available.
      %                   GPSLong: GPS longitude if available
      %                    GPSAlt: GPS altitude in metres if available.
      %                    GPSUTC: Universal Time from GPS.
      %                 GPSUTCVec: Universal Time in 3-element numeric vector.
      %                        Wv: Wavelengths of the measurement.
      %                   RadData: Radiometric data (radiance, irradiance or DN).
      %
      % Example :
      % >> ASDData = ReadASDtxt('refl00011.asd.txt');
      %
      % This example reads a single file exported from ViewSpec with headers.
      %
      % See Also : ReadASDtxtMulti, WriteASDspec_alb
      
      
      %% Copyright 2010, DPSS, CSIR and D J Griffith
      % All rights reserved.
      %
      % This file is subject to the conditions of the BSD Licence. For further
      % details, see the file BSDLicence.txt.
      persistent ASDPath
      % Create the structure
      ASDData = struct('HeaderTxt', {''}, 'txtFilename', '', 'ASDFilename', '', 'Comment', '', 'InstrNumber', [], 'ProgVers', '', 'FileVers', '', ...
        'DateVec', [], 'DateTime', '', 'SerialDate', [], 'VNIRintTime', [], 'VNIRChan1Wv', [], 'VNIRChan1Step', [], 'SamplesPerValue', [], ...
        'xmin', [], 'xmax', [], 'ymin', [], 'ymax', [], 'BitDepth', [], 'SWIR1Gain', [], 'SWIR1Offset', [], 'SWIR2Gain', [], ...
        'SWIR2Offset', [], 'VNIRjoinSWIR1', [], 'SWIR1joinSWIR2', [], 'VNIRDarkSigSubtracted', [], 'NumDarkMeas', [], 'DarkMeasDateTime', '', ...
        'DarkMeasSerialDate', [], 'NumWhiteMeas', [], 'WhiteMeasDateTime', '', 'WhiteMeasSerialDate', [], ...
        'DCCVal', [], 'WhiteRefed', [], 'ForeOptic','','FileContent', '','GPSLat', [], 'GPSLong', [], 'GPSAlt',[], 'GPSUTC', [], ...
        'GPSUTCVec', [], 'Wv', [], 'RadData', []);
      
      if ~exist('Filename', 'var') || isempty(Filename)
        if isempty(ASDPath)
          [Filename, Pathname] = uigetfile({'*.txt','Text Files (*.txt)';...
                                            '*.*', 'All Files (*.*)'}, 'Select the ASD Text File');
        else
          [Filename, Pathname] = uigetfile({'*.txt','Text Files (*.txt)';...
                                            '*.*', 'All Files (*.*)'}, 'Select the ASD Text File', ASDPath);          
        end
        if ~Filename
          return
        end
        ASDData = []; % User cancelled dialog
        Filename = [Pathname Filename];
      end
      [pathstr, name] = fileparts(Filename);
      ASDPath = pathstr;
      ASDData.txtFilename = Filename;
      %% Open and read the file
      ilin = 0;
      ASDFilename = '';
      if exist(Filename, 'file')
        fid = fopen(Filename);
        while ~feof(fid)
          lin = fgetl(fid); % Read line by line until header is all done
          ilin = ilin +  1;
          ASDData.HeaderTxt{ilin} = lin;
          [A,count] = sscanf(lin, 'Text conversion of header file %s');
          if count
            [ASDFilePath, ASDFilename] = fileparts(lin(32:end));
            ASDData.ASDFilename = lin(32:end);
          end
          [A,count] = sscanf(lin, 'Wavelength %s');
          if count % scan the rest of the file
            Data = textscan(fid, '%f %f');
            ASDData.Wv = Data{1};
            ASDData.RadData = Data{2};
          end
          if strcmp(strtrim(lin), ASDFilename)
            Data = textscan(fid, '%f');
            ASDData.RadData = Data{1};
          end
          [A,count] = sscanf(lin, 'The instrument number was %s');
          if count
            ASDData.InstrNumber = A;
          end
          % Versions
          [A,count] = sscanf(lin, 'New ASD spectrum file: Program version = %s file version = %s');
          if count
            if length(A) == 8
              ASDData.ProgVers = A(1:4);
              ASDData.FileVers = A(5:8);
            end
          end
          [A,count] = sscanf(lin, 'Spectrum saved: %s at %s');
          if count
            DateVector = datevec(A(1:10), 23);
            TimeVector = datevec(A(11:end), 13);
            ASDData.DateVec = DateVector+[0 0 0 TimeVector(4:6)];
            ASDData.SerialDate = datenum(ASDData.DateVec);
            ASDData.DateTime = datestr(ASDData.DateVec, 0);
          end
          % VNIR integration time
          [A,count] = sscanf(lin, 'VNIR integration time : %f');
          if count, ASDData.VNIRintTime = A; end;
          [A,count] = sscanf(lin, 'VNIR channel 1 wavelength = %f wavelength step = %f');
          if count == 2
            ASDData.VNIRChan1Wv = A(1);
            ASDData.VNIRChan1Step = A(2);
          end
          [A,count] = sscanf(lin,'There were %f samples per data value');
          if count, ASDData.SamplesPerValue = A(1); end;
          [A,count] = sscanf(lin, 'xmin = %f xmax= %f');
          if count==2, ASDData.xmin = A(1); ASDData.xmax = A(2); end;
          [A,count] = sscanf(lin, 'ymin = %f ymax= %f');
          if count==2, ASDData.ymin = A(1); ASDData.ymax = A(2); end;
          [A,count] = sscanf(lin, 'The instrument digitizes spectral values to %f bits');
          if count, ASDData.BitDepth = A(1); end;
          [A,count] = sscanf(lin,'SWIR1 gain was %f offset was %f');
          if count==2, ASDData.SWIR1Gain = A(1); ASDData.SWIR1Offset = A(2); end;
          [A,count] = sscanf(lin,'SWIR2 gain was %f offset was %f');
          if count==2, ASDData.SWIR2Gain = A(1); ASDData.SWIR2Offset = A(2); end;
          [A,count] = sscanf(lin, 'Join between VNIR and SWIR1 was %f nm');
          if count, ASDData.VNIRjoinSWIR1 = A(1); end;
          [A,count] = sscanf(lin, 'Join between SWIR1 and SWIR2 was %f nm');
          if count, ASDData.SWIR1joinSWIR2 = A(1); end;
          if strcmp(strtrim(lin), 'VNIR dark signal subtracted')
            ASDData.VNIRDarkSigSubtracted = 1;
          end
          if strcmp(strtrim(lin), 'VNIR dark signal not subtracted')
            ASDData.VNIRDarkSigSubtracted = 0;
          end
          [A,count] = sscanf(lin, '%f'); % Number of dark or white reference scans
          
          if count % Process dark or white reference scans
            [AA,countA] = sscanf(lin, '%*f %s');
            if countA && AA(1) == 'd' % dark measurements
              ASDData.NumDarkMeas = A(1);
              [A,count] = sscanf(lin, '%*f dark measurements taken %s %s %*s %*s %*s');
              A = char(A');
              TheWeekDay = A(1:3); TheMonth = A(4:6);
              [A,count] = sscanf(lin, '%*f dark measurements taken %*s %*s %f %f:%f:%f %f');
              DateFormat0 = sprintf('%02i-%3s-%4i %02i:%02i:%02i', A(1), TheMonth, A(5), A(2), A(3), A(4));
              ASDData.DarkMeasDateTime = DateFormat0;
              ASDData.DarkMeasSerialDate = datenum(DateFormat0, 0);
            elseif countA && AA(1) == 'w' % white reference measurements
              ASDData.NumWhiteMeas = A(1);
              [A,count] = sscanf(lin, '%*f white reference measurements taken %s %s %*s %*s %*s');
              A = char(A');
              TheWeekDay = A(1:3); TheMonth = A(4:6);
              [A,count] = sscanf(lin, '%*f white reference measurements taken %*s %*s %f %f:%f:%f %f');
              DateFormat0 = sprintf('%02i-%3s-%4i %02i:%02i:%02i', A(1), TheMonth, A(5), A(2), A(3), A(4));
              ASDData.WhiteMeasDateTime = DateFormat0;
              ASDData.WhiteMeasSerialDate = datenum(DateFormat0, 0);
            end
          end
          [A,count] = sscanf(lin, 'DCC value was %f');
          if count, ASDData.DCCVal = A(1); end;
          
          if strcmp(strtrim(lin), 'Data is not compared to a white reference')
            ASDData.WhiteRefed = 0;
          end
          if strcmp(strtrim(lin), 'Data is compared to a white reference:')
            ASDData.WhiteRefed = 1;
          end
          if length(lin) >= 11
            % Check for a comment
            if strcmp(lin(1:11), ' ----------')
              lin = fgetl(fid);
              ASDData.Comment = strtrim(lin);
            end
            if strcmp(lin(1:10), 'There was ')
              ASDData.ForeOptic = lin;
            end
            if strcmp(lin(1:11), 'Spectrum fi')
              ASDData.FileContent = lin;
            end
            
            [A,count] = sscanf(lin, 'GPS-Latitude is %s');
            if count && length(A) > 2
              [DegMin, count] = sscanf(A, '%*2c%2i%f');
              ASDData.GPSLat = DegMin(1)+DegMin(2)/60;
              if A(1)=='S'
                ASDData.GPSLat = -ASDData.GPSLat;
              end
            end
            [A,count] = sscanf(lin, 'GPS-Longitude is %s');
            if count && length(A) > 2
              [DegMin, count] = sscanf(A, '%*2c%2i%f');
              ASDData.GPSLong = DegMin(1)+DegMin(2)/60;
              if A(1)=='W'
                ASDData.GPSLong = -ASDData.GPSLong;
              end
              
            end
            [A,count] = sscanf(lin, 'GPS-Altitude is %s');
            if count && length(A) > 2
              ASDData.GPSAlt = str2double(A);
            end
            [A,count] = sscanf(lin, 'GPS-UTC is %s');
            if count && length(A) > 2
              ASDData.GPSUTC = A;
              ASDData.GPSUTCVec = [sscanf(A, '%f:%f:%f')]';
            end
            
          end
          
        end
      else
        error('Mod5:ReadASDtxt:FileDoesNotExist', 'Given File does not exist')
      end
      fclose(fid);
    end   % ReadASDtxt 
    function ASDData = ReadASDtxtMulti(Filename)
      % ReadMultiASDtxt : Read multiple ASD text files into a structure array
      %
      % Usage :
      %
      % ASDData = Mod5.ReadASDtxtMulti(Filename)
      %
      % Usage is nearly identical to use of ReadASDtxt, except that multiple files
      % can be selected, and a vector of ASDData structures is returned, with
      % one element per file. Filename can be a cell array of strings, one
      % element per file. If filename is missing or empty, a multiple file
      % selection dialog is presented.
      %
      % See Also : ReadASDtxt, WriteASDspec_alb
      
      %% Copyright 2002-2009, DPSS, CSIR
      % This file is subject to the terms and conditions of the BSD licence.
      % For further details, see the file BSDlicence.txt
      persistent ASDPath
      Pathname = '';
      %% Verify/process inputs
      if ~exist('Filename', 'var') || isempty(Filename)
        if isempty(ASDPath)
          [Filename, Pathname] = uigetfile({'*.txt','Text Files (*.txt)';...
                                            '*.*', 'All Files (*.*)'}, 'Select the ASD Text File', 'Multiselect', 'on');          
        else
          [Filename, Pathname] = uigetfile({'*.txt','Text Files (*.txt)';...
                                            '*.*', 'All Files (*.*)'}, 'Select the ASD Text File', ASDPath, 'Multiselect', 'on');                    
        end
        if iscellstr(Filename)
          for iFile = 1:numel(Filename)
            Filename{iFile} = [Pathname Filename{iFile}]; % Prepend the pathname to every selected file
          end
        else
          ASDData = [];
          if ~Filename
            return
          end
          Filename = [Pathname Filename];
        end
      else
        if ischar(Filename)
          assert(logical(exist(Filename, 'file')), 'Mod5:ReadASDtxtMulti:BadFilename', ...
            'Input Filename must be the name of an existing file. If not in the current directory, include the full path.')
        else
          assert(iscellstr(Filename), 'Mod5:ReadASDtxtMulti:BadFilename', ...
            'Input Filename must be a string or a cell array of strings.')
        end
      end
      ASDPath = Pathname;
      %% Read the ASD file(s)
      if iscellstr(Filename)
        for iFile = 1:numel(Filename)
          ASDData(iFile) = Mod5.ReadASDtxt(Filename{iFile});
        end
      else
        ASDData = Mod5.ReadASDtxt(Filename);
      end
      
    end % ReadASDtxtMulti
    function AlbOut = MixAlb(AlbIn, Weights, Title)
      % MixAlb : Compute weighted mean of several spectral albedo curves
      %
      % Usage :
      %
      %  AlbOut = Mod5.MixAlb(AlbIn, Weights, Title);
      %
      % Where :
      %   AlbIn is the input spectral albedo data, AlbIn is a structure
      %     array with the following fields:
      %
      %    Filename : The name of the file from which the data was originally read.
      %      Header : Header data and information pertaining to the albedo data
      %       title : The title of the material or substance, or material identifier
      %          wv : The wavelengths at which the albedo is given in µm
      %        refl : The reflectance (albedo) of the material at the given wavelengths.
      %
      %   AlbIn may have been read using ReadAlb, ReadAlbFromUSGS or ReadAlbFromASD.
      %
      %  Weights is a vector of numbers giving the weighting factors for the
      %    spectral mixture. The weighted mean is computed, meaning that the
      %    sum of the weights is normalised to 1. There cannot be more Weights
      %    given than what there are elements in the vector AlbIn.
      %
      % Title is a new title to give the mixed spectral albedo. Title must
      %    be a string that is also a valid Matlab variable name. If Title
      %    is not a valid variable name it will be converted to one using
      %    the function genvarname.
      %
      % AlbOut is an output structure with the same fields as AlbIn. There is a
      %    single element containing the weighted mean of the input spectra.
      %
      % The process used to compute the mixture is as follows:
      %   1) The wavelengths from all of the component spectra are merged
      %   2) All component spectra are resampled at the merged wavelengths
      %      Linear interpolation is used and extrapolation is not permitted.
      %      Extrapolated albedos yield NaN (not-a-number).
      %   3) The weighted sum of the components is computed at the merged wavelengths
      %   4) All NaN albedo points are removed from the weighted sum. Hence,
      %      the mixture albedo is defined only at wavelengths that are
      %      common to all of the input components.
      %   5) Header data is composed by putting all header data together,
      %      along with weight information.
      %
      % See Also : ReadAlb, WriteAlb, ReadAlbFromUSGS, ReadAlbFromASD,
      %            CreateAlb, AttachAlb, PlotAlb
      
      % Do a little input checking
      assert(isstruct(AlbIn) && all(isfield(AlbIn, {'Header','title','wv','refl'})), 'Mod5:MixAlb:BadAlbIn', ...
        'The input spectral albedo structure AlbIn must have the fields Header, title, wv, and refl.');
      assert(isnumeric(Weights) && isvector(Weights) && numel(Weights) <= numel(AlbIn) && all(Weights >= 0), 'Mod5:MixAlb:BadWeights', ...
        'Input Weights must be a positive, numeric vector of length less or equal to the number of elements in the input AlbIn.');
      assert(ischar(Title) && isvector(Title), 'Mod5:MixAlb:BadTitle', ...
        'Input Title must be a string (char array).');
      AlbOut = struct('Filename', {}, 'Header', {}, 'title', {}, 'wv', {}, 'refl', {}); 
      
      % Compile a list of all the wavelengths
      Wv = [];
      for iAlb = 1:numel(AlbIn)
        Wv = [Wv; reshape(AlbIn(iAlb).wv, numel(AlbIn(iAlb).wv), 1)]; % make dead sure a col vector
      end
      
      % Sort wavelengths and retain unique
      Wv = unique(Wv);
      Refl = zeros(numel(Wv), numel(Weights));
      % Interpolate albedo/reflectance data onto unique and sorted wavelength list
      AlbOut(1).Header = '=== Mixture of reflectance components, created with Mod5.MixAlb';
      for iAlb = 1:numel(Weights)
        Refl(:, iAlb) = interp1(AlbIn(iAlb).wv, AlbIn(iAlb).refl, Wv, 'linear');
        % Might as well accumulate the header data while in this loop
        AlbOut.Header = strvcat(AlbOut.Header, AlbIn(iAlb).Header, sprintf('=== Mixture Weight for Component "%s" = %g', ...
          strtrim(AlbIn(iAlb).title), Weights(iAlb)));
      end
      % Create the weights in a matrix
      WeightMat = repmat(reshape(Weights,1,numel(Weights)), numel(Wv), 1);
      % Compute the mixture
      Mixture = sum(Refl .* WeightMat, 2) ./ sum(Weights);
      iGood = ~isnan(Mixture) & Mixture >= 0; % Will chuck out NaN and negative reflectance data
      Wv = Wv(iGood);
      Mixture = Mixture(iGood);
      % Finally compose the output albedo structure
      AlbOut.wv = Wv;
      AlbOut.refl = Mixture;
      AlbOut.title = ['    1   ', genvarname(Title)];
    end % MixAlb
    function AlbOut = InterpAlb(Alb, WavelengthRange, NumberOfWavelengths, Optimize, varargin)
      % InterpAlb : Perform interpolation on spectral albedo curve
      %
      % MODTRAN will read a limited number of points in spectral albedo data
      %   (50 in an unmodified version). Spectral reflectance data such
      %   as data measured with an ASD spectroradiometer will have many
      %   more points than this. Use this function to interpolate the
      %   albedo onto a coarser wavelength grid. Ensure the the fit is 
      %   adequate before using the data in MODTRAN.
      %
      % Usage:
      %   AlbOut = Mod5.InterpAlb(Alb, WavelengthRange, NumberOfWavelengths);
      %     Or
      %   AlbOut = Mod5.InterpAlb(Alb, WavelengthRange, NumberOfWavelengths, Optimize);
      %     Or
      %   AlbOut = Mod5.InterpAlb(Alb, WavelengthRange, NumberOfWavelengths, Optimize, InterpParams...);
      %
      % Where:
      %   Alb is an input albedo structure having the following fields
      %
      %    Filename : The name of the file from which the data was originally read.
      %      Header : Header data and information pertaining to the albedo data
      %       title : The title of the material or substance, or material identifier
      %          wv : The wavelengths in µm at which the albedo is given
      %        refl : The reflectance (albedo) of the material at the given wavelengths.
      %
      % WavelengthRange is a two-element vector giving the minimum and maximum
      %   wavelengths (wavelength interval) in µm.
      %
      % NumberOfWavelengths is the number of wavelengths at which to give
      %   the reflectance (albedo) in the returned structure.
      %
      % If you have the spline toolbox, InterpAlb can be made to attempt
      %   optimization of the wavelength selection to better fit the
      %   albedo curve with few points. This is done using input Optimize.
      %   If Optimize is missing, empty or zero, the default behavior of
      %   InterpAlb is to interpolate the albedo at evenly spaced
      %   wavelengths. Optimize also provides some control over the
      %   optimization. If Optimize is not 1, it is used to compute the
      %   smoothing parameter for spline fitting. The smoothing parameter is
      %   computed as 1 - Optimize(1)/1e9, i.e. the amount in parts per
      %   billion (ppb) by which the smoothing parameter is less than 1. The
      %   default value is 500 ppb. Larger values give more smoothing.
      %   Smoothing mitigates the (serious) effect of noise in the albedo
      %   data on the optimization algorithm.
      %   Optimize can also have a second value that influences the
      %   optimization. This value relates to the weight given to regions
      %   of the curve with strong curvature. The default value is 1/3.
      %   Values of 0.2 to 0.5 can be experimented with.
      %   
      %
      % The returned structure AlbOut has the same fields as the input Alb,
      %   but with the requested number of wavelength points in the 
      %   requested wavelength range. 
      %
      % See Also : ReadAlb, WriteAlb, MixAlb, PlotAlb,
      %            ReadAlbFromASD, ReadAlbFromUSGS
      %
      
      % Do some input parameter checking      
      % The input Alb must have the Header, titles, wavelengths, reflectances

      assert(isstruct(Alb) && all(isfield(Alb, {'Header','title','wv','refl'})), 'Mod5:InterpAlb:BadAlb', ...
        'The input structure Alb must have the fields Header, title, wv, and refl.');
      assert(isnumeric(WavelengthRange) && numel(WavelengthRange) == 2 && all(WavelengthRange > 0), 'Mod5:InterpAlb:BadWvRange', ...
        'Input WavelengthRange must be a two-element numeric vector, giving the desired wavelength range in microns.');
      assert(isscalar(NumberOfWavelengths) && isnumeric(NumberOfWavelengths) && NumberOfWavelengths >= 3, 'Mod5:InterpAlb:BadNumberWv', ...
        'Input NumberOfWavelengths must be scalar, numeric and greater than 3.');
      WavelengthRange = sort(WavelengthRange);
      NumberOfWavelengths = round(NumberOfWavelengths);
      if exist('Optimize','var') && ~isempty(Optimize)
        assert(isnumeric(Optimize) && any(numel(Optimize)==[1 2]), 'Mod5:InterpAlb:BadOptimize', ...
          'Input Optimize must be numeric with one or two elements.');
        if Optimize(1) ~= 1
          SmoothingParameter = 1 - Optimize(1)./1e9;
        else
          SmoothingParameter = 1 - 500./1e9;
        end
        if numel(Optimize) == 2
          CurveWeight = Optimize(2);
        else
          CurveWeight = 1/3;
        end
      else
        Optimize = 0;
      end
      AlbOut = Alb;
      % Run through the elements of Alb and perform the fit
      for iAlb = 1:numel(Alb)
        % Check that the data in Alb spans the requested wavelength range
        if WavelengthRange(1) < Alb(iAlb).wv(1) || WavelengthRange(2) > Alb(iAlb).wv(end)
          if WavelengthRange(1) >= Alb(iAlb).wv(end) || WavelengthRange(2) <= Alb(iAlb).wv(1)
            warning('Mod5:InterpAlb:WvSpan', ...
              'The requested WavelengthRange does not overlap the data in input Alb(%i) at all. Skipped.', iAlb);
            continue;
          end
          warning('Mod5:InterpAlb:WvSpan', 'The requested WavelengthRange is not spanned by the data in input Alb(%i).', iAlb);          
        end
        Wv = Alb(iAlb).wv;
        Refl = Alb(iAlb).refl;
        if ~Optimize
          % Just use equally spaced wavelengths
          NewWv = linspace(WavelengthRange(1), WavelengthRange(2), NumberOfWavelengths);
        else
          if isempty(which('csaps')) % no spline toolbox presumably
            warning('Mod5:InterpAlb:NoSplines','The Spline Toolbox is required for wavelength optimisation. Optimize input ignored.');
            NewWv = linspace(WavelengthRange(1), WavelengthRange(2), NumberOfWavelengths);
            
          else
            % Select wavelengths in the requested range, plus some overlap if possible
            iRange = find((Wv >= WavelengthRange(1)) & (Wv <= WavelengthRange(2)));
            while iRange(1) >= 1 && Wv(iRange(1)) >= WavelengthRange(1)
              iRange = [iRange(1) - 1; iRange];
            end
            while iRange(end) <= numel(Wv) && Wv(iRange(end)) <= WavelengthRange(2)
              iRange = [iRange; iRange(end) + 1];
            end
            WvInRange = reshape(Wv(iRange), numel(iRange), 1); % Make sure it is a column vector
            ReflInRange = reshape(Refl(iRange), numel(iRange), 1);
            
            % Perform smoothing spline fit
            SpFit = csaps(WvInRange, ReflInRange, SmoothingParameter);
            dSpFit = fnder(SpFit); % First derivative
            ddSpFit = fnder(dSpFit); % Second Derivative
            
            % Compute curvature
            dRefl = fnval(dSpFit, WvInRange); % Evaluate derivative
            ddRefl = fnval(ddSpFit, WvInRange); % Evaluate second derivative
            Curv = (ddRefl.^2 ./ (1 + dRefl.^2)).^(CurveWeight); % Compute something related to curvature
            % Get rid of any zeroes in the curvature, generally at the ends
            Curv(Curv <= 0) = mean(Curv)/10000;
            % Integrate by cumulative sum
            SumCurv = cumsum(Curv);
            NewSumCurv = linspace(min(SumCurv), max(SumCurv), NumberOfWavelengths);
            % Resample back to a choice of wavelengths
            NewWv = interp1(SumCurv, WvInRange, NewSumCurv);
          end
        end
        % Perform the interpolation
        if isempty(varargin)
          NewRefl = interp1(Wv, Refl, NewWv, 'linear');
        else
          NewRefl = interp1(Wv, Refl, NewWv, varargin{:});
        end
        if any(isnan(NewRefl))
          warning('Mod5:InterpAlb:NaNsFound','NaNs were encountered interpolating Alb(%i). Skipped.', iAlb);
        end
        % Attempt an optimisation
        %options.MaxIter = 100;
        %NewWv = fminsearch(@(xNewWv) Mod5.GoodFit(xNewWv), NewWv, options);
        
        % And populate the output structure
        AlbOut(iAlb).wv = reshape(NewWv, numel(NewWv), 1);
        AlbOut(iAlb).refl = reshape(NewRefl, numel(NewRefl), 1);
      end
    end % InterpAlb
    function h = PlotAlb(Alb, AxisLimits)
      % PlotAlb : Plot spectral albedo (reflectance) data
      %
      % Usage :
      %
      %    plothandles = Mod5.PlotAlb(Alb, AxisLimits);
      %
      %     Or
      %
      %    plothandles = Mod5.PlotAlb(Alb);
      %
      % Where Alb is spectral reflectance (albedo) structure data read using
      %  ReadAlb, ReadAlbFromASD, ReadAlbFromUSGS or created using
      %  CreateAlb. Alb must have the following fields:
      %
      %     Header : Header data for the material reflectance
      %      title : The title of the material or substance
      %         wv : The wavelengths in µm at which the albedo is given
      %       refl : The reflectance (albedo) of the material at the given wavelengths.
      %
      % Where AxisLimits is a optional 4-element row vector containing the upper
      %   and lower limits of the plot as for the 'axis' function.
      %
      % If the Alb structure to be plotted is a column vector, all material reflectance
      % data is plotted on a single plot. If it is a row vector, each
      % material is plotted on a seperate plot.
      %
      % Legends are only plotted if there are 10 or fewer curves to be plotted
      % on each graph.
      %
      % A vector of plothandles is returned.
      %
      %
      % See Also : ReadAlb, WriteAlb, ReadAlbFromASD, ReadAlbFromUSGS, MixAlb,
      %            AttachAlb
      %
      
      % The input must have the titles, wavelengths, reflectances
      assert(isstruct(Alb) && all(isfield(Alb, {'title','wv','refl'})), 'Mod5:PlotAlb:BadAlb', ...
        'The input structure Alb must have the fields title, wv, and refl.');
      
      for iCol = 1:size(Alb, 2)
        h(iCol) = figure;
        TheLegends = {};
        hold all;
        for iRow = 1:size(Alb, 1)
          if isfield(Alb, 'stddev')
            errorbar(Alb(iRow, iCol).wv, Alb(iRow, iCol).refl, Alb(iRow, iCol).stddev);
          else
            plot(Alb(iRow, iCol).wv, Alb(iRow, iCol).refl);
          end
          TheLegends = [TheLegends strrep(Alb(iRow, iCol).title, '_', ' ')];
        end
        hold off;
        if exist('AxisLimits', 'var') && isnumeric(AxisLimits) && numel(AxisLimits) == 4
          axis(AxisLimits);
        end
        grid;
        title('Reflectance Data');
        if numel(TheLegends) <= 10
          legend(TheLegends, 'Location', 'best');
        end
        xlabel('Wavelength (\mum)');
        ylabel('Reflectance');
      end
    end % PlotAlb
    function Success = WriteAlb(Alb, Filename)
      % WriteAlb : Write spectral albedo (reflectance) data in the MODTRAN format
      %
      % Usage :
      %
      %  Success = Mod5.WriteAlb(Alb, Filename);
      %
      %    Or
      %
      %  Sucess = Mod5.WriteAlb(alb);
      %
      % Where Alb is a spectral albedo data structure read using
      %  ReadAlb, ReadAlbFromASD, ReadAlbFromUSGS or CreateAlb.
      %  The structure Alb must have the following fields:
      %
      %     Header : Header data for the material reflectance
      %      title : The title of the material or substance
      %         wv : The wavelengths in µm at which the albedo is given
      %       refl : The reflectance (albedo) of the material at the given wavelengths.
      %
      % Filename is the name of the file to which to write the albedo data. If
      %   the Filename is not given or empty, a file/save dialog will be 
      %   presented.
      %
      % A warning will be issued if there are duplicate title tags (numeric)
      %   or text).
      %
      % See Also : ReadAlb, WriteAlb, ReadAlbFromASD, ReadAlbFromUSGS,
      %            AttachAlb, MixAlb
      
      Success = 0;
      assert(isstruct(Alb) && all(isfield(Alb, {'Header','title','wv','refl'})), 'Mod5:WriteAlb:BadAlb', ...
        'The input structure Alb must have the fields Header, title, wv, and refl.');
      
      if ~exist('Filename', 'var') || isempty(Filename)
        MODTRANPath = '';
        % Check for default case directory
        Direc = fileparts(which('Mod5.m'));
        if exist([Direc '\MODTRANExe.mat'], 'file');
          load([Direc '\MODTRANExe.mat']);
        end
        
          % Use dialog
        if isempty(MODTRANPath)  
          [Filename, Pathname] = uiputfile({'*.alb', 'MODTRAN Spectral Albedo File (*.alb)'; ...
                                            '*.dat', 'MODTRAN Spectral Albedo File (*.dat)'; ...
                                            '*.*', 'All Files'},'Write MODTRAN Spectral Albedo File');
        else
          [Filename, Pathname] = uiputfile({'*.alb', 'MODTRAN Spectral Albedo File (*.alb)'; ...
                                            '*.dat', 'MODTRAN Spectral Albedo File (*.dat)';
                                            '*.*', 'All Files'},'Write MODTRAN Spectral Albedo File', MODTRANPath);          
        end
        if Filename
          Filename = [Pathname Filename];
        else
          Success = 0;
          return;
        end
      end
      % Collect the numeric and text tags of the albedo curves
      NumTags = zeros(1, numel(Alb));
      TextTags = {};
      for iAlb = 1:numel(Alb)
        [NumericTag, TextTag] = strtok(Alb(iAlb).title);
        NumTags(iAlb) = str2double(NumericTag);
        TextTags{iAlb} = strtrim(TextTag);
      end
      if numel(NumTags) ~= numel(unique(NumTags)) % There are duplicate numeric tags
        warning('Mod5:WriteAlb:DuplicateNumTags',...
          'There are duplicate numeric albedo curve tags. Check the Alb input structure. This does not matter if the text tags are used.');
      end
      % Also check the text tags
      if numel(TextTags) ~= numel(unique(TextTags)) % There are duplicate text tags
        warning('Mod5:WriteAlb:DuplicateTextTags',...
          'There are duplicate textual albedo curve tags. Check the Alb input structure. This does not matter if the numeric tags are used.');        
      end
      try % to write the albedo file
        fid = fopen(Filename, 'wt');
        % Run through each of the materials and write the stuff
        for iAlb = 1:numel(Alb)
          % Write the Header
          for iHead = 1:size(Alb(iAlb).Header, 1)
            fprintf(fid, '! %s\n', Alb(iAlb).Header(iHead, :));
          end
          % Write the title
          fprintf(fid, '%s\n', Alb(iAlb).title);
          % Write the data
          fprintf(fid, ' %10g %10g\n', [Alb(iAlb).wv'; Alb(iAlb).refl']);
        end
        fclose(fid);
        Success = 1;
      catch AlbWriteFailed
        fclose(fid);
        rethrow(AlbWriteFailed)
      end
    end % WriteAlb
    function Flt = ReadFlt(Filename)
      % ReadFlt : Read a .flt format spectral band filter definitions file
      %
      % For more information on filters and channels, see the MODTRAN
      % manual Card 1A3.
      %
      % Usage :
      %   Flt = Mod5.ReadFlt(Filename);
      %     Or
      %   Flt = Mod5.ReadFlt;   % Presents file/open dialog
      %
      % Where Filename is the name of the .flt format file from which to read
      % the data. Filename must have the full path as well if not present in
      % the current directory. If Filename is omitted or empty, a file/open
      % dialog will be presented.
      %
      % The returned variable Flt is a structure with the following fields:
      %
      %   UnitsHeader : 'W' for wavenumber in cm^-1, 'N' for wavelength
      %                 in nm, and 'M' for wavelength in microns.
      %        Units  : a string containing 'cm^1', 'nm' or 'µm' as 
      %                 appropriate for the value in UnitsHeader.
      %   FileHeader  : The entire first header (UNITS_HEADER) line,
      %                 being the first line in the .flt file.
      %  FilterHeaders: A cell array of strings, with one string entry
      %                 for each filter found in the file. The number of
      %                 cells is therefore also the number of filters
      %                 found in the file. These are referred to as
      %                 HEADER(i) in the MODTRAN manual.
      %     Filters   : A cell array with each cell containing a two
      %                 column matrix of numbers. The first column is
      %                 the wavenumber or wavelength in the Units given
      %                 above, and the second column is the transmittance
      %                 of the filter at the given wavelength/number.
      %                 There may also be a third column containing
      %                 the wavenumber or wavelength corresponding to
      %                 the wavelength or wavenumber respectively in
      %                 the first column (see AVIRIS.flt).
      %
      % See Also: WriteFlt, AttachFlt, CreateFlt, ReadFltFromSensorML
      %
      
      Flt = [];
      %%  Verify Filename input or open dialog as appropriate
      if ~exist('Filename', 'var') || isempty(Filename)
        MODTRANPath = '';
        % Check for default case directory
        Direc = fileparts(which('Mod5.m'));
        if exist([Direc '\MODTRANExe.mat'], 'file');
          load([Direc '\MODTRANExe.mat']);
        end
        
        % Use dialog
        if isempty(MODTRANPath)
          [Filename, Pathname] = uigetfile({'*.flt', ...
            'MODTRAN Spectral Filter Files (*.flt)'; '*.*', 'All Files'}, 'Select MODTRAN Spectral Filter File');
        else
          [Filename, Pathname] = uigetfile({'*.flt', ...
            'MODTRAN Spectral Filter Files (*.chn)'; '*.*', 'All Files'}, 'Select MODTRAN Spectral Filter File', MODTRANPath);
        end
        if Filename
          Filename = [Pathname Filename];
        else
          return;
        end
      else % Filename is not empty, meaning that an explicit filename was given
        assert(ischar(Filename), 'Mod5:ReadFlt:FilenameNotString', 'Input Filename must be a string.');
        if ~exist(Filename, 'file')
          error('Mod5:ReadFlt:FileDoesNotExist', ...
            'The file %s does not seem to exist. Provide full path if not in current directory.', Filename);
        end
      end
      %% Open the file and try to read it
      try % to read the .flt file
        fid = fopen(Filename, 'rt');
        Flt.FileHeader = fgetl(fid);
        UHeader = strtrim(Flt.FileHeader);
        if ~isempty(UHeader) && any(UHeader(1) == 'WNM')
          Flt.UnitsHeader = UHeader(1);
        else
          error('Mod5:ReadFlt:BadHeader', ...
            'The file %s has an invalid first header character (W, M or N) for a .flt file.', Filename);
        end
        % set the Units field
        switch UHeader(1)
          case 'W'
            Flt.Units = 'cm^-1';
          case 'N'
            Flt.Units = 'nm';
          case 'M'
            Flt.Units = [char(181) 'm'];
        end
        % Attempt to read the filter data
        iFilter = 1;
        while ~feof(fid)
          TheFilterHeader = fgetl(fid); % read the filter header (HEADER(i))
          if isempty(strtrim(TheFilterHeader))
            break; % No filter ?
          else
            Flt.FilterHeaders{iFilter} = TheFilterHeader;
          end
          % sample the data and determine the number of lines
          FilePos = ftell(fid); % remember file position
          DataLine = [' ' fgetl(fid) ' '];
          if ~isempty(DataLine)
            StepUp = regexp(DataLine, '\s\S'); % Find transitions from space to non-space
            TheFormat = repmat('%f ', 1, length(StepUp));
            % Back up to the start of the data block
            fseek(fid, FilePos, 'bof');
            % And textscan the filter data with the given format
            FilterData = textscan(fid, TheFormat);
            Flt.Filters{iFilter} = cell2mat(FilterData);
          else
            error('Mod5:ReadFlt:BadFilterData', ...
              'There seems to be missing filter data in the file %s.flt', Filename);
          end
          iFilter = iFilter + 1;
        end
        fclose(fid);
      catch ReadFltFailed
        fclose(fid);
        rethrow(ReadFltFailed)
      end
      
    end % ReadFlt
    function Flt = CreateFlt(Name, FilterDescr, Centre, FWHM, ...
                        Shape, nSamples, EdgeVal, FlatTopWidth, PeakTrans)
      % CreateFlt : Create a spectral band (channel) filter or filter set
      %
      % CreateFlt is used to generate MODTRAN band (channel) filters for
      % computation of band radiance, band irradiance or attenuation.
      %
      % Usage :
      %   Flt = Mod5.CreateFlt(Name, FilterDescr, Centre, FWHM, ...
      %              Shape, nSamples, EdgeVal, FlatTopWidth, PeakTrans)
      %
      % This function can generate a set of filters having different shapes
      % widths and centre wavelengths. The resulting filter structure can
      % be attached to a Mod5, written to file using
      % Mod5.WriteFlt or plotted using Mod5.PlotFlt.
      %
      % The shapes of the filters are generated using Jason Brazile's 
      % srf_generate function.
      %
      % Where :
      %   Name is the overall description of the filter or filter set to be
      %     created. The first character of the Name must be a upper case
      %     W if the Centre and full-width-at-half-maximum (FWHM) are given
      %     in wavenumbers (cm^-1), N if given in nanometres and M if given
      %     in microns. Name must be a string and is a mandatory input.
      %   FilterDescr is a cell array of strings giving the descriptions of
      %     each of the filters. Filter must have the same number of entries
      %     as Centre. FilterDescr is a mandatory input.
      %   Centre is the centre wavenumber/length of the filter in nm, microns
      %     or cm^-1, depending on the first character in the Name. Centre
      %     can be a vector, but then all subsequent input parameters must
      %     either be scalar or have the same number of elements as Centre.
      %     Centre is a mandatory input. The number of elements in Centre
      %     defines the number of filters in the set.
      %   FWHM is the full-width-at-half-maximum in the same units as Centre.
      %     FWHM must either be scalar or have the same number of elements
      %     as the Centre input. If FWHM is scalar (and Centre is not), then
      %     the same FWHM is used for all filters in the set. FWHM is a
      %     mandatory input.
      %   Shape is a cell array of strings, giving the shapes of each of the
      %     Filters. Shape must be scalar or have the same number of entries
      %     as Centre. If scalar, the same shape is used for all filters
      %     in the set. Valid Shape parameters are 'gauss', 'bartlett', 
      %     'welch' and 'cosine'. If Shape is missing or empty, the
      %     default shape is 'gauss'.
      %   nSamples is the number of wavenumber/wavelength samples to
      %     generate in the filter. nSamples must be scalar or have the
      %     same number of elements at the Centre input. If scalar, the
      %     same number of samples will be generated for all filters in the
      %     set.
      %   EdgeVal is the value to which the filter must decline at the
      %     extreme wavenumber/wavelengths. The default value for EdgeVal
      %     is 0.001. EdgeVal must be a scalar or have the same number of
      %     elements as Centre. If scalar, the same EdgeVal will be applied
      %     to all filters in the set.
      %   FlatTopWidth, if specified, will give the filter a flat top of
      %     the given width in cm^-1, nm or microns (depending on the
      %     first character of the Name input). FlatTopWidth defaults to
      %     to 0. If non-zero, the filter is opened up in the Centre and
      %     a flat top is inserted. For gaussian filters, this means that
      %     the edges of the filter still have a gaussian shape. This
      %     input must be scalar or have the same number of elements as
      %     Centre. If scalar, the same FlatTopWidth is applied to all
      %     filters. The overall width of the filter (full-width-at-half-
      %     maximum) will be FWHM + FlatTopWidth.
      %   PeakTrans, if specified is the peak transmittance for the filter.
      %     PeakTrans must be greater than zero and less than or equal to 1.
      %     This input must be scalar or have the same number of elements
      %     as the Centre input. If scalar, the same PeakTrans value
      %     is applied to all filters in the set.
      %
      % The returned structure contains the following fields:
      %
      %        FileHeader: The input Name (filter set description)
      %       UnitsHeader: The first character of the Name (determines 
      %                    spectral units)
      %             Units: The spectral units ('nm', 'µm' or 'cm^-1' )
      %     FilterHeaders: The FilterDescr filter descriptions, one cell each
      %           Filters: The filter data, one cell per filter
      %
      % Example :
      % Define a blue and a green filter in wavelength (nm) domain.
      %   MyFlt = Mod5.CreateFlt('N Synthetic Spectral Filters', ...
      %           {'Blue Filter', 'Green Filter'}, ... % Filter descriptions
      %           [450            550          ], ... % Centre wavelengths (nm)
      %           [40             50           ], ... % FWHMs
      %           {'gauss'}                     , ... % Both gaussian shape
      %           [], ... % Default number of samples (nSamples)
      %           [], ... % Default edge value (EdgeVal)
      %           [30             20]);  % FlatTopWidth of 30 and 20 respec.
      %           
      %
      % See Also : (Mod5.) ReadFlt, WriteFlt, AttachFlt, PlotFlt, ReadFltFromSensorML
      %
      Flt = [];
      %% Verify inputs
      % Verify the "Name" input
      assert(exist('Name', 'var') && ischar(Name) && any(Name(1) == 'WNM'), 'Mod5:CreateFlt:BadName', ...
        'Input Name (mandatory) must be a string starting with W (for wavenumber), N (for nanometres) or M (for microns).');
      % Verify the "Centre" wavelength/number input
      assert(exist('Centre', 'var') && ~isempty(Centre) && isnumeric(Centre) && min(Centre(:)) > 0, 'Mod5:CreateFlt:BadCentre', ...
        'Input Centre (mandatory) must be positive, numeric centre wavelength or wavenumber.');
      nFilters = numel(Centre); % This is the number of filters in the set.
      % Verify the "FilterDescr" input
      assert(exist('FilterDescr','var') && ~isempty(FilterDescr) && iscellstr(FilterDescr) && ...
             (isscalar(FilterDescr) || numel(FilterDescr) == nFilters), ...
        'Mod5:CreateFlt:BadFilterDescr','Input FilterDescr (mandatory) must be a cell array of strings describing filters.');
      if numel(FilterDescr) ~= nFilters
        FilterDescr = repmat(FilterDescr, 1, nFilters);
      end
      % Verify the "FWHM" input
      assert(exist('FWHM', 'var') && isnumeric(FWHM) && (isscalar(FWHM) || numel(FWHM) == nFilters) && min(FWHM(:)) > 0, ...
        'Mod5:CreateFlt:BadFWHM','Input FWHM (mandatory) must be positive numeric and have the same number of elements as Centre.');
      if numel(FWHM) ~= nFilters
        FWHM = repmat(FWHM(1), 1, nFilters);
      end
      % Verify the "Shape" input
      if exist('Shape', 'var')
        assert(iscellstr(Shape) && any(numel(Shape) == [1 nFilters]), 'Mod5:CreateFlt:BadShape', ...
          'Input Shape must be a cell array of strings with a single entry or the same number of entries as Centre');
        Shape = lower(Shape);
        ShapeMatch = sort([strmatch('gauss',Shape,'exact') strmatch('bartlett',Shape,'exact') ...
                           strmatch('welch',Shape,'exact') strmatch('cosine',  Shape,'exact')]);
        if ~all(ShapeMatch(:) == 1:numel(ShapeMatch))
          error('Mod5:CreateFlt:BadShape', ...
                'Input Shape must be a cell array of strings limited to ''gauss'' ''bartlett'' ''welch'' and ''cosine''');
        end
      else
        Shape = {'gauss'};
      end
      if numel(Shape) ~= nFilters
        Shape = repmat(Shape, 1, nFilters);
      end
      % Verify the nSamples input
      if exist('nSamples', 'var') && ~isempty(nSamples)
        assert(isnumeric(nSamples) && all(round(nSamples) == nSamples) && any(numel(nSamples) == [1 nFilters]) && all(nSamples >= 5), ...
          'Mod5:CreateFlt:BadnSamples', ...
          'Input nSamples must be integer > 5 and either scalar or have the same number of elements at input Centre.');
      else
        nSamples = 64;
      end
      if numel(nSamples) ~= nFilters
        nSamples = repmat(nSamples(1),1,nFilters);
      end
      % Verify EdgeVal input
      if exist('EdgeVal', 'var') && ~isempty(EdgeVal)
        assert(isnumeric(EdgeVal) && all(EdgeVal > 0) && all(EdgeVal < 0.1) && any(numel(EdgeVal) == [1 nFilters]), ...
          'Mod5:CreateFlt:BadEdgeVal', ...
          'Input EdgeVal must be positive, < 0.1, and either be scalar or have the same number of elements as input Centre.');
      else
        EdgeVal = 0.001;
      end
      if numel(EdgeVal) ~= nFilters
        EdgeVal = repmat(EdgeVal, 1, nFilters);
      end
      % Verify FlatTopWidth
      if exist('FlatTopWidth', 'var') && ~isempty(FlatTopWidth)
        assert(isnumeric(FlatTopWidth) && all(FlatTopWidth >= 0) && any(numel(FlatTopWidth) == [1 nFilters]), ...
          'Mod5:CreateFlt:BadFlatTopWidth',...
          'Input FlatTopWidth must be >= 0 and be scalar or have the same number of elements as input Centre.');
        if numel(FlatTopWidth) ~= nFilters
          FlatTopWidth = repmat(FlatTopWidth, 1, nFilters);
        end
        
      else
        FlatTopWidth = [];
      end
      % Verify PeakTrans
      if exist('PeakTrans', 'var') && ~isempty(PeakTrans)
        assert(isnumeric(PeakTrans) && all(PeakTrans > 0) && all(PeakTrans <= 1) && any(numel(PeakTrans) == [1 nFilters]), ...
          'Mod5:CreateFlt:BadPeakTrans',...
          'Input PeakTrans must be > 0, <= 1 and be scalar or have the same number of elements as input Centre.'); 
      else
        PeakTrans = 1;
      end
      if numel(PeakTrans) ~= nFilters
        PeakTrans = repmat(PeakTrans, 1, nFilters);
      end
      %% Compute the filters one by one, using srf_generate
      % First put in the file header (Name) and Units
      Flt.FileHeader = Name;
      Flt.UnitsHeader = Name(1);
      switch Flt.UnitsHeader
        case 'W'
          Flt.Units = 'cm^-1';
        case 'N'
          Flt.Units = 'nm';
        case 'M'
          Flt.Units = 'µm';
      end
      for iFilter = 1:nFilters
        Flt.FilterHeaders{iFilter} = FilterDescr{iFilter};
        
        [FilterX, FilterY, FilterW] = Mod5.srf_generate(Centre(iFilter), FWHM(iFilter), Shape{iFilter}, ...
                                                               nSamples(iFilter), EdgeVal(iFilter));
        % Scale to PeakTrans
        FilterY = FilterY .* PeakTrans(iFilter);
        FilterW = FilterW .* PeakTrans(iFilter);
        % Now if a flat top was requested, this must be inserted
        if ~isempty(FlatTopWidth) && FlatTopWidth(iFilter) > 0
          iLowerHalf = FilterX <= Centre(iFilter);
          iUpperHalf = FilterX >= Centre(iFilter);
          FilterX = [FilterX(iLowerHalf) - FlatTopWidth(iFilter)/2; FilterX(iUpperHalf) + FlatTopWidth(iFilter)/2];
          FilterY = [FilterY(iLowerHalf); FilterY(iUpperHalf)];
          FilterW = 1e7 ./ FilterX;
        end
        Flt.Filters{iFilter} = [FilterX FilterY FilterW];
      end
    end % CreateFlt
    function Flt = ReadFltFromSensorML(Filename)
      % ReadFltFromSensorML : Obtain a filter set from a satellite SensorML description file
      %
      % SensorML descriptions of various satellite sensors can be obtained from the
      % CalVal portal. Amongst many other parameters, these .xml files contain
      % the spectral band (channel) response filter shapes. This function extracts
      % the band filters from the SensorML file. 
      %
      % The CalVal portal is at http://calvalportal.ceos.org
      %
      % Usage :
      %
      %   Flt = ReadFltFromSensorML(Filename);
      %
      % Where :
      %   Filename is the name of the SensorML (.xml) file from which to import the
      %   filter definitions. This must be full path and filename if not
      %   in your current directory. If Filename is not given or is empty,
      %   a file/open dialog will be presented.
      %
      % The returned variable Flt is a structure with the following fields:
      %
      %   UnitsHeader : 'W' for wavenumber in cm^-1, 'N' for wavelength
      %                 in nm, and 'M' for wavelength in microns.
      %        Units  : a string containing 'cm^1', 'nm' or 'µm' as 
      %                 appropriate for the value in UnitsHeader.
      %   FileHeader  : The entire first header (UNITS_HEADER) line,
      %                 being the first line in the .flt file.
      %  FilterHeaders: A cell array of strings, with one string entry
      %                 for each filter found in the file. The number of
      %                 cells is therefore also the number of filters
      %                 found in the file. These are referred to as
      %                 HEADER(i) in the MODTRAN manual.
      %     Filters   : A cell array with each cell containing a two
      %                 column matrix of numbers. The first column is
      %                 the wavenumber or wavelength in the Units given
      %                 above, and the second column is the transmittance
      %                 of the filter at the given wavelength/number.
      %                 There may also be a third column containing
      %                 the wavenumber or wavelength corresponding to
      %                 the wavelength or wavenumber respectively in
      %                 the first column (see AVIRIS.flt).
      %
      % See Also : CreateFlt, ReadFlt, AttachFlt, PlotFlt
      %
      % Note : Negative values are not permitted by MODTRAN in spectral
      %        channel response data.
      %
      Flt = [];
      %%  Verify Filename input or open dialog as appropriate
      if ~exist('Filename', 'var') || isempty(Filename)
        MODTRANPath = '';
        % Check for default case directory
        Direc = fileparts(which('Mod5.m'));
        if exist([Direc '\MODTRANExe.mat'], 'file');
          load([Direc '\MODTRANExe.mat']);
        end
        
        % Use dialog
        if isempty(MODTRANPath)
          [Filename, Pathname] = uigetfile({'*.xml', ...
            'SensorML Instrument Descriptions (*.xml)'; '*.*', 'All Files'}, 'Select SensorML Instrument File');
        else
          [Filename, Pathname] = uigetfile({'*.xml', ...
            'SensorML Instrument Descriptions (*.xml)'; '*.*', 'All Files'}, 'Select SensorML Instrument File', MODTRANPath);
        end
        if Filename
          Filename = [Pathname Filename];
        else
          return;
        end
      else % Filename is not empty, meaning that an explicit filename was given
        assert(ischar(Filename), 'Mod5:ReadFltFromSensorML:FilenameNotString', 'Input Filename must be a string.');
        if ~exist(Filename, 'file')
          error('Mod5:ReadFltFromSensorML:FileDoesNotExist', ...
            'The file %s does not seem to exist. Provide full path if not in current directory.', Filename);
        end
      end
      ML = xmlread(Filename); % Read in the SensorML description
      % Now process the file
      % Find the sml:component tags, a NodeList is returned
      CompList = ML.getElementsByTagName('sml:component');
      nComps = CompList.getLength;
      if nComps == 0
        error('Mod5:ReadFltFromSensorML', ...
          'No components nodes found. This .xml file may not be SensorML, or may not have the requisite information.');
      end
      Flt.UnitsHeader = 'N'; % ASSUMING nm data - should really check the uom in the SensorML file
      Flt.Units = 'nm';
      [Path, FName] = fileparts(Filename);
      Flt.FileHeader = ['N ' strrep(FName, '_', ' ')];
      for iComp = 1:nComps
        Flt.FilterHeaders{iComp} = '';
        % The items are indexed from 0
        CompNode = CompList.item(iComp - 1);
        % Scan the component for identifier nodes
        Idents = CompNode.getElementsByTagName('sml:identifier');
        if Idents.getLength == 2
          Name = Idents.item(1).getAttribute('name');
          if strcmpi(Name, 'Long Name')
            if Idents.item(1).hasChildNodes
              Term = Idents.item(1).getChildNodes;
              if Term.item(1).hasChildNodes
                Value = Term.getChildNodes;
                Flt.FilterHeaders{iComp} = strtrim(char(Value.item(1).getTextContent));;
              end
            end
          end
        end
        % Now get the spectral response curve node
        Curve = CompNode.getElementsByTagName('swe:Curve');
        if Curve.getLength
          Values = Curve.item(0).getElementsByTagName('swe:values');
          RespData = char(Values.item(0).getTextContent); % Why the devil do I get decimal COMMAS - a dinosaur crawled in
          RespData = strrep(RespData, ',', '.'); % Kill dinosaur
          % Scan the data in
          RespData = sscanf(RespData, '%f');
          Wv = RespData(1:2:end);
          if any(Wv < 100)
            warning('Mod5:ReadFltFromSensorML:WavelengthsSuspect',...
              'Wavelength data in SensorML file assumed units of nanometres, but values less than 100 were encountered. Check SensorML file.');
            Wv = Wv*1000; % Presume conversion to nm
          end
          Response = RespData(2:2:end);
          Flt.Filters{iComp} = [Wv Response];
        end        
      end
      if ~isfield(Flt, 'Filters')
          warning('Mod5:ReadFltFromSensorML:NoSpectralResponse', ...
            'This SensorML file does not seem to contain any spectral response curves.')
      end        
    end % ReadFltFromSensorML
    function [wl, y, wn] = srf_generate(center, fwhm, shape, n, yedge)
      % SRF_GENERATE Generate a MODTRAN-compatible spectral response function
      %
      % [wl, y, wn] = Mod5.srf_generate(center, fwhm, shape, n, yedge)
      %
      % Inputs:
      %   center    center wavelength
      %     fwhm    desired full width half max
      %    shape    'gauss', 'bartlett', 'welch', 'cosine' (default: 'gauss')
      %        n    number of samples                      (default: 65)
      %    yedge    edge values                            (default: 0.001)
      %
      % Outputs:
      %       wl    vector of wavelengths (nm)
      %        y    vector of values
      %       wn    vector of wavenumbers (cm^-1)
      %
      % Example:
      %
      %    [wl, y, wn] = Mod5.srf_generate(380.10, 9.9);
      %    plot(wl, y);
      %    plot(wn, y);
      %
      % Copyright (c) 2009, Jason Brazile
      % All rights reserved.
      %
      % This function is subject to the terms and conditions of the BSD Licence.
      % For further details see the file BSDLicence.txt.
      %
      % The latest version of srf_generate should be available via:
      % wget \
      % http://apex-esa.cvs.sourceforge.net/viewvc/*checkout*/apex-esa/tools/srf_generate.m
      %
      % inspired by Armin Günter's freely distributable gauss.m
      % http://ftp.physik.uni-greifswald.de/~guenter/matlab/signalproc/gauss.m
      % and http://mathworld.wolfram.com/FullWidthatHalfMaximum.html
      %
      if nargin < 5 yedge = 0.001;   end
      if nargin < 4     n = 65;      end
      if nargin < 3 shape = 'gauss'; end
      if nargin < 2 error('Give at least band center and fwhm.'); end
      
      if n < 3 error('Need at least 3 samples'); end
      
      n2 = floor((n-1)/2); 			% mid point
      x = [-n2:n2+mod(n-1,2)]';			% calculate sample indexes
      
      switch lower(shape)
        case 'gauss'
          sigma = sqrt(-n2.^2/2/log(yedge));	% calculate sigma
          nfwhm = 2 * sqrt(2 * log(2)) * sigma;	% normlized fwhm
          y = exp(-x.^2/2/sigma^2);		% gaussian
        case 'bartlett'
          fudge = n2 * (1+yedge+(yedge/100));
          nfwhm = n2 + (yedge * fudge);		% normlized fwhm
          y = 1 - (abs(x) / nfwhm);		% bartlett
          y(y<0)=realmin;			% in case of odd samples
        case 'welch'
          fudge = n2 * (.5+(yedge*.378));
          alph = n2 + (yedge * fudge);		% calculate alpha
          nfwhm = sqrt(2) * alph;			% normalized fwhm
          y = 1 - ((x .^ 2) / (alph ^ 2));	% welch
          y(y<0)=realmin;			% in case of odd samples
        case 'cosine'
          fudge = n2 * (.6365+(yedge*.5));
          alph = n2 + (yedge * fudge);		% calculate alpha
          nfwhm = (4/3) * alph;			% normalized fwhm
          y = cos((pi .* x) / (2 * alph));	% cos
          y(y<0)=realmin;			% in case of odd samples
        case 'box'
          y = ones(size(x));
          y(1) = realmin;
          y(2*n2+1:end) = realmin;
          nfwhm = trapz(y);
        otherwise
          error('Mod5:srf_generate:UnknownFilterShape', ...
            'Input "shape" must be one of: gauss, bartlett, welch or cosine.');
      end
      
      delta = fwhm / nfwhm;			% determine sample delta
      
      wl = (ones(n, 1) .* center) + (delta .* x);	% wavelengths (nm)
      wn = 1e7 ./ wl;				% wavenumbers (cm^-1)
    end % srf_generate
    function Success = WriteFlt(Flt, Filename)
      % WriteFlt: Write a filter definition to a .flt file
      %
      % Usage :
      %
      %  Success = Mod5.WriteFlt(Flt, Filename);
      %
      % Where Flt is a structure defining a filter set having the
      % following fields:
      %   UnitsHeader : 'W' for wavenumber in cm^-1, 'N' for wavelength
      %                 in nm, and 'M' for wavelength in microns.
      %        Units  : a string containing 'cm^1', 'nm' or 'µm' as 
      %                 appropriate for the value in UnitsHeader.
      %   FileHeader  : The entire first header (UNITS_HEADER) line,
      %                 being the first line in the .flt file.
      %  FilterHeaders: A cell array of strings, with one string entry
      %                 for each filter found in the file. The number of
      %                 cells is therefore also the number of filters
      %                 found in the file. These are referred to as
      %                 HEADER(i) in the MODTRAN manual.
      %     Filters   : A cell array with each cell containing a two
      %                 column matrix of numbers. The first column is
      %                 the wavenumber or wavelength in the Units given
      %                 above, and the second column is the transmittance
      %                 of the filter at the given wavelength/number.
      %                 There may also be a third column containing
      %                 the wavenumber or wavelength corresponding to
      %                 the wavelength or wavenumber respectively in
      %                 the first column (see AVIRIS.flt).
      %
      % The Flt filter structure can be read from an existing .flt file,
      % or created using Mod5.CreateFlt.
      %
      % Filename is the name of the file to which the filter definition must
      % be written. The format is as for a MODTRAN .flt file. See the
      % MODTRAN manual for details of the .flt file format (see input
      % parameter FILTNM on card 1A3). If the filename is missing or
      % empty, a file/save dialog will be presented.
      %
      % See Also: ReadFlt, AttachFlt, CreateFlt
      
      Success = 0;
      %% Perform some input parameter checking
      assert(isstruct(Flt), 'Mod5:WriteFlt:FltNotStruct', ...
        'Input Flt must be structure with fields FileHeader, UnitsHeader, Units, FilterHeader and Filters.');
      assert(isscalar(Flt),'Mod5:WriteFlt:MustBeScalar','Input Flt to WriteFlt must be scalar.');      
      if ~all(isfield(Flt, {'FileHeader','UnitsHeader', 'Units', 'FilterHeaders', 'Filters'}))
        error('Mod5:WriteFlt:BadFlt', ...
          'The Flt structure input does not have all the correct fields. ')
      end
      % Check the units thingy
      if ~any(Flt.UnitsHeader == 'WNM')
        error('Mod5:WriteFlt:BadUnitsHeader', ...
          'The UnitsHeader field in input structure Flt must be one of ''W'', ''N'' or ''M''.')
      end
      UHeader = strtrim(Flt.FileHeader);
      if ~any(UHeader(1) == 'WNM')
        error('Mod5:WriteFlt:BadFileHeader', ...
          'The first character in the FileHeader of Flt must be one of ''W'', ''N'' or ''M''.')        
      end
      if UHeader(1) ~= Flt.UnitsHeader
        error('Mod5:WriteFlt:UnitsInconsistent', ...
          'The first character of the FileHeader must be the same as the UnitsHeader in input Flt.')                
      end
      if ~exist('Filename', 'var') || isempty(Filename)
        MODTRANPath = '';
        % Check for default case directory
        Direc = fileparts(which('Mod5.m'));
        if exist([Direc '\MODTRANExe.mat'], 'file');
          load([Direc '\MODTRANExe.mat']);
        end
        
          % Use dialog
        if isempty(MODTRANPath)  
          [Filename, Pathname] = uiputfile({'*.flt', 'MODTRAN Filter File (*.flt)'},'Write MODTRAN Spectral Filter File');
        else
          [Filename, Pathname] = uiputfile({'*.flt', 'MODTRAN Filter File (*.flt)'},'Write MODTRAN Spectral Filter File', MODTRANPath);          
        end
        if Filename
          Filename = [Pathname Filename];
        else
          Success = 0;
          return;
        end
      end
      assert(ischar(Filename), 'Mod5:WritePlt:FilenameNotString', 'Input Filename must be a string.');
      try % to write the file
        % First determine the format with which to write the file
        switch Flt.UnitsHeader
          case 'W'
            TheFormat = '%9.2f %9.7f';
          case 'N'
            TheFormat = '%10.4f %9.7f';
          case 'M'
            TheFormat = '%11.7f %9.7f';
        end
        fid = fopen(Filename, 'wt');
        fprintf(fid, '%s\n', Flt.FileHeader); % Write the file header
        for iFilter = 1:numel(Flt.Filters)
          % Write the filter header
          fprintf(fid, '%s\n', Flt.FilterHeaders{iFilter});
          NumCols = size(Flt.Filters{iFilter},2); % How many columns of data
          switch NumCols
            case 2
              % Add the data for the third column
              switch Flt.UnitsHeader
                case 'W' % Assume third column is nm
                  Flt.Filters{iFilter} = [Flt.Filters{iFilter} 1e9./(100*Flt.Filters{iFilter}(:,1))]; % Convert cm^-1 to nm
                  FinalFormat = [TheFormat ' %10.4f\n'];
                case 'N' % Assume third column is cm^-1
                  Flt.Filters{iFilter} = [Flt.Filters{iFilter} 1e-2./(1e-9*Flt.Filters{iFilter}(:,1))]; % Convert nm to cm^-1                    
                  FinalFormat = [TheFormat ' %9.2f\n'];
                case 'M' % Assume third column is cm^-1
                  Flt.Filters{iFilter} = [Flt.Filters{iFilter} 1e-2./(1e-6*Flt.Filters{iFilter}(:,1))]; % Convert microns to cm^-1                                        
                  FinalFormat = [TheFormat ' %9.2f\n'];
              end
            case 3
              % Must add a third format
              switch Flt.UnitsHeader
                case 'W' % Assume third column is nm
                  FinalFormat = [TheFormat ' %10.4f\n'];
                case 'N' % Assume third column is cm^-1
                  FinalFormat = [TheFormat ' %9.2f\n'];
                case 'M' % Assume third column is cm^-1
                  FinalFormat = [TheFormat ' %9.2f\n'];
              end
            otherwise
              error('Mod5:WriteFlt:BadFilterData', ...
                'Filter transmittance data with other than 2 or 3 columns was encountered.');
          end
          fprintf(fid, FinalFormat, Flt.Filters{iFilter}');
        end
        fclose(fid);
        Success = 1;
      catch WriteFltFailed
        fclose(fid);
        Success = 0;
        rethrow(WriteFltFailed);
      end
    end % WriteFlt
    function plothandle = PlotFlt(Flt, iFilters)
      % PlotFlt : Plot one or more filters in the filter structure
      %
      % Usage:
      %
      %  plothandle = Mod5.PlotFlt(Flt);
      %    Or
      %  plothandle = Mod5.PlotFlt(Flt, iFilters)
      % 
      % Where Flt is a filter structure as returned by Mod5.ReadFlt.
      % iFilters is a vector list of filter numbers to include in the plot
      % If iFilters is missing or empty, all filters are plotted.
      %
      % If 8 or fewer filters are plotted, the filter descriptions are
      % shown as legends.
      %
      % See Also: ReadFlt, WriteFlt, AttachFlt, ReadFltFromSensorML
      % 
      plothandle = [];
      if isempty(Flt)
        return; % silly person - nothing to chow
      end
      % Little bit of input checking
      assert(isstruct(Flt), 'Mod5:PlotFlt:FltNotStruct', ...
        'Input Flt must be structure with fields FileHeader, UnitsHeader, Units, FilterHeader and Filters.');      
      assert(isscalar(Flt),'Mod5:PlotFlt:MustBeScalar','Input Flt to PlotFlt must be scalar.');
      if ~all(isfield(Flt, {'FileHeader','UnitsHeader', 'Units', 'FilterHeaders', 'Filters'}))
        error('Mod5:PlotFlt:BadFlt', ...
          'The Flt structure input does not have all the correct fields. ')
      end
      if ~exist('iFilters', 'var')
        iFilters = 1:length(Flt.Filters);
      else
        assert(isnumeric(iFilters) && isvector(iFilters) && all(round(iFilters) == iFilters) && ...
          min(iFilters) >= 1 && max(iFilters) <=  length(Flt.Filters), 'Mod5:PlotFlt:BadiFilters', ...
          'Input iFilters to PlotFlt must be numeric, integer vector limited to number of filters in input Flt');
      end
      % There will only be a single figure
      plothandle = figure();
      hold all;
      for iFilt = iFilters
        plot(Flt.Filters{iFilt}(:,1), Flt.Filters{iFilt}(:,2));
      end
      grid;
      title(Flt.FileHeader);
      switch Flt.UnitsHeader
        case 'W'
          xlabel('Wavenumber (cm^{-1})');
        case 'N'
          xlabel('Wavelength (nm)');
        case 'M'
          xlabel(['Wavelength (' char(181) 'm)']);
        otherwise
          warning('Mod5:PlotFlt:BadUnitsHeader','An invalid UnitsHeader was encountered in the Flt input');
          xlabel('Unknown')
      end
      ylabel('Filter Transmittance');
      % If there are less than 6 filters plotted, include the filter description
      if length(iFilters) < 9
        legend(Flt.FilterHeaders{iFilters}, 'Location', 'best')
      end
      hold off;
      
    end % PlotFlt
    function [Data, Heads] = Read7(Filename)
      % Read7 : Read MODTRAN Tape 7 format outputs
      %
      %  Usage :
      %    [Data, Heads] = Mod5.Read7(Filename);
      % 
      % Reads a multiblock MODTRAN output file in the .tp7 or .7sc file
      % formats. MODTRAN writes one block of data for each sub-case in
      % the case file.
      %
      % The input Filename is the name of the tape7 (or .tp7 or .7sc) file
      % written by MODTRAN. These are the main tranmission or radiance
      % results.
      %
      % Both outputs (Data and Heads) are cell arrays.
      %
      % The Data for each of the blocks is returned in a cell array
      % for each of the outputs. For example, the Data in the first block
      % and first column is referenced as Data{1,1}. The data for the
      % second column in the first block is Data{1,2} etc. Freq is a cell
      % column vector, giving the frequencies in cm^-1 for each of the
      % data blocks in the file. 
      % Heads is a cell array of headers (strings) for each of the columns
      % and blocks. The header for the 3rd column in the first block would
      % be Head{1}(3). The headers are not identical to the column headers
      % in the tape7 file in all cases. Note that indexing of Head is 
      % different to indexing of the Data cell array.
      %
      % Mod5.Read7 is somewhat similar to the older ReadMODTRANfl7.m
      % except that all data is returned and it is not possible to select
      % particular columns. Like ReadMODTRANfl7, this function returns
      % unsanitised headers. The calling function must sanitise the 
      % headers if required. The function to do this is called
      %  Mod5.FixHeaders. This function removes blanks, non alphabetic
      %  characters and provides translation to a more consistent set of
      %  headers. Look at the source code of FixHeaders to see what 
      %  translations are performed.
      %
      % Bugs:
      %  Some column headers in tape7 files are poorly aligned to the data
      %  and this causes the headers to be identified incorrectly. This is
      %  so particularly for tape7 files output from runs in the direct
      %  solar/lunar irradiance mode (IEMSCT = 3). The current version
      %  of Mod5.FixHeaders corrects some of these problems.
      %
      
      % The strategy is similar to ReadMODTRANfl7.m, except that the numeric
      % data is tokenised, then the starting and ending column numbers of the 
      % data is determined. The headers are then established by finding the
      % text above each of the numeric columns. This is necessary because in
      % some .7sc files, headers are present without data in the column below.
      %
      % A further improvement is that a combination of ftell and fseek is used
      % to position back to the start of the data block after sampling the
      % data.
      %
      % In direct solar irradiance mode, tape7 can have a column of data
      % without a header (see CaseM04) ! This column appears to be optical
      % depth data, and is decribed as such.
      
      % If the filename is not present, open a dialog and get a filename.
      %% Check input filename and open
      if ~exist('Filename', 'var') || isempty(Filename)
        MODTRANPath = '';
        % Check for default case directory
        Direc = fileparts(which('Mod5.m'));
        if exist([Direc '\MODTRANExe.mat'], 'file');
          load([Direc '\MODTRANExe.mat']);
        end
        
        % Use dialog
        if isempty(MODTRANPath)
        [Filename, Pathname] = uigetfile({'*.tp7;*.7sc;tape7;tape7.scn', ...
          'MODTRAN Tape7 Output Files (*.tp7, *.7sc)'; '*.*', 'All Files'}, 'Select MODTRAN Tape7 Output File');
        else
        [Filename, Pathname] = uigetfile({'*.tp7;*.7sc;tape7;tape7.scn', ...
          'MODTRAN Tape7 Output Files (*.tp7, *.7sc)'; '*.*', 'All Files'}, 'Select MODTRAN Tape7 Output File', MODTRANPath);
        end
        if Filename
          Filename = [Pathname Filename];
        else
          return;
        end
      else % Filename is not empty, meaning that an explicit filename was given
        assert(ischar(Filename), 'Mod5:Read7:FilenameNotString', 'Input Filename must be a string.');
        if ~exist(Filename, 'file')
          error('Mod5:Read7:FileDoesNotExist', ...
            'The file %s does not seem to exist. Provide full path if not in current directory.', Filename);
        end
      end
      %% Open the MODTRAN tape 7 output file and start reading
      Heads = {''};
      Data = {[]};
      try % to read the tape 7 file      
      fid = fopen(Filename, 'rt');
      dblock = 0; % Count the datablocks in the file - should correspond to the number runs of MODTRAN in the case if all went well.
      %lin = [' ' fgetl(fid) ' ']; % Always ensure that possible header lines start and end with blanks
      while ~feof(fid)
        lin = [' ' fgetl(fid) ' ']; % pad front and rear with a blank        
        tok = strtok(lin, ' ');
        if numel(tok) >= 4 && (strcmpi(tok(1:4), 'FREQ') || strcmpi(tok(1:4), 'WAVL'))% Found a header line
          dblock = dblock + 1;
          headers = {}; % Empty the headers cell array
          headlin1 = lin; % This will be the first header line 
          % Remember this position in the file
          EndHeaderLine1 = ftell(fid);
          headlin2 = [' ' fgetl(fid) ' ']; % Get what is possibly another header line and pad front and back with blanks
          EndHeaderLine2 = ftell(fid);
          % Check to see if this is data
          tok2 = strtok(headlin2, ' ');
          if isletter(tok2(1)) % The headers comprise 2 lines
            % Compose the headers from 2 lines
            % First read a line of data
            lin = [' ' fgetl(fid) ' ']; % make sure it starts and ends with a blank
            % Find the blanks between the data column
            start = regexp(lin, '\s\S') + 1; % rising edge
            stop = regexp(lin, '\S\s'); % falling edge
            start(1) = 1; % Force start of first header at start of line 
            beststarth1 = start;
            beststarth1(beststarth1 > length(headlin1)) = length(headlin1); % constrain to maximum of headlin1 
            beststoph1 = stop;
            beststoph1(beststoph1 > length(headlin1)) = length(headlin1);
            %beststoph1(end) = length(headlin1);
            % Attempt to expand the headers
            [beststarth1, beststoph1] = Mod5.DilateHeaders(beststarth1, beststoph1, headlin1);
            % Do the same for the second header line
            beststarth2 = start;
            beststarth2(beststarth2 > length(headlin2)) = length(headlin2); % constrain to maximum of headlin2 
            beststoph2 = stop;
            beststoph2(beststoph2 > length(headlin2)) = length(headlin2);
            %beststoph2(end) = length(headlin2);
            [beststarth2, beststoph2] = Mod5.DilateHeaders(beststarth2, beststoph2, headlin2);
            
            % Split up the first header line
            for iii = 1:(length(start))
                headers{iii} = headlin1(beststarth1(iii):beststoph1(iii));
                % Deblank
                headers{iii} = strtrim(headers{iii});
                % Header continues on next line (headlin2)
                headers2{iii} = headlin2(beststarth2(iii):beststoph2(iii));
                headers2{iii} = strtrim(headers2{iii});
                % Merge
                headers{iii} = [headers{iii} ' ' headers2{iii}];
            end
            % headers
            % Seek back to the end of header line 2
            SeekStatus = fseek(fid, EndHeaderLine2, 'bof');
            if SeekStatus
                error('Mod5_Read7:SeekError','Error seeking to start of tape7 data block.')
            end
            
          else % The headers were on one line e.g. caseM18
            % Find the blanks between the data column
            start = regexp(headlin2, '\s\S') + 1;
            start(1) = 1; % Force start of first header at start of line 
            stop = regexp(headlin2, '\S\s');
            beststarth1 = start;
            beststarth1(beststarth1 > length(headlin1)) = length(headlin1); % constrain to maximum of headlin1 
            beststoph1 = stop;
            beststoph1(beststoph1 > length(headlin1)) = length(headlin1);
            %beststoph1(end) = length(headlin1);
            % Attempt to expand the headers
            [beststarth1, beststoph1] = Mod5.DilateHeaders(beststarth1, beststoph1, headlin1);
            
            % Split up the first header line
            for iii = 1:(length(start))
                headers{iii} = headlin1(beststarth1(iii):beststoph1(iii));
                % Deblank
                headers{iii} = strtrim(headers{iii});
            end
            %headers
            % Seek back to the end of header line 1
            SeekStatus = fseek(fid, EndHeaderLine1, 'bof');
            if SeekStatus
                error('Mod5:Read7:SeekError','Error seeking to start of tape7 data block.')
            end
          end
          Heads{dblock,1} = headers;  % Put the headers for this block into the output cell array
          % Read the entire data block
          Format = repmat('%f', 1, length(start));
          blockdata = textscan(fid, Format);
          ValidRows = blockdata{1} ~= -9999; % This is to remove lines with -9999. in the FREQ column 
          for iCol = 1:length(start)
            Data{dblock, iCol} = blockdata{iCol}(ValidRows);
          end
          
          % Also add in empty blocks according to the number of -9999. lines
          % If there is only one -9999, then nothing needs be done, but for
          % each additional occurrance of -9999, an empty block is inserted.
          for iEmtyBlock = 1:(sum(~ValidRows)-1)
            dblock = dblock+1;
            Heads{dblock,1} = {};
            Data{dblock,1} = [];
          end
        elseif str2double(tok) == -9999 % Deal with occurrances of -9999 that do not follow after data
          dblock = dblock+1;
          Heads{dblock,1} = {};
          Data{dblock,1} = [];
        end % strncmp(tok, 'FREQ') % found a header
      end % while ~feof(fid)
      fclose(fid);
      catch ReadFailed
        fclose(fid)
        rethrow(ReadFailed);
      end
      
    end % Read7
    function Flx = ReadFlx(Filename, Label)
        % ReadFlx : Read fluxes (irradiances) from .flx file
        %
        % Usage :
        %   Flx = ReadFlx;   % Presents file/open dialog
        %   
        %   Flx = ReadFlx(Filename);
        %
        %   Flx = ReadFlx(Filename, Label);
        %
        % Reads MODTRAN spectral fluxes (irradiances) from the given
        % Filename. If Filename is missing or empty, a file/open dialog
        % will be presented.
        %
        % Fluxes are the same as horizontal irradiances in MODTRAN
        % terminology.
        %
        % It is more conventional to use the term "irradiance" in the
        % radiometry world, while "flux" normally means optical power
        % rather than optical power per unit area. The term "irradiance" is
        % favoured below. Three components of spectral (and total)
        % irradiance are produced, viz. upward (upwelling) diffuse,
        % downward (downwelling) diffuse and (downwelling) direct solar
        % irradiance. These irradiances are on a horizontal plane. The
        % spectral irradiances will have a number of rows equal to the number
        % of spectral points, and a number of columns equal to the number
        % of altitude (atmospheric layer) boundaries.
        %
        % The returned output Flx is a structure with the following fields.
        %        Spectral : The values of the spectral quantity
        %                   (wavelengths or wavenumbers)
        %   SpectralUnits : Units of the spectral quantity, cm^-1, nm or µm
        %   SpectralLabel : Label for plotting, either 'Wavelength' or
        %                   'Wavenumber'.
        %      IrradUnits : Units of irradiance. Usually 'W/cm^2/cm^-1
        %          UpDiff : Upwelling diffuse irradiance at each of 
        %                   the layer boundaries.
        %        DownDiff : Downwelling diffuse irradiance at each of
        %                   the layer boundaries.
        %       DirectSol : Downwelling direct solar irradiance at
        %                   each of the layer boundaries.
        %      nAltitudes : The number of altitudes for the layer
        %                   boundaries.
        %       Altitudes : The altitudes of the layour boundaries in km.
        %   AltitudeUnits : Currently always 'km'
        %       SlitShape : Shape of the spectral convolution slit function
        %        SlitFWHM : Full-Width-at-Half-Maximum of the slit
        %                   convolution function.
        %   SlitFWHMUnits : Units of the SlitFWHM. Could be nm,µm, cm^-1 or
        %                   percent (%).
        %         UpTotal : Total upwelling diffuse irradiance integrated over wavelength at
        %                   each of the altitude layer boundaries.
        %       DownTotal : Total downwelling diffuse irradiance at each of
        %                   the altitude layer boundaries.
        %  DirectSolTotal : Total direct solar irradiance at each of the
        %                   layer boundaries.
        % TotalIrradUnits : The units of total irradiance. Normally W/cm^2.
        %        Filename : Filename from which the irradiance data was
        %                   read.
        %           Label : An optional label that will be included in
        %                   plot titles to help identify the plot.
        %
        % Flx will have one element per block, as there could be multiple
        % blocks from a series of MODTRAN runs.
        %
        % Note : To get Global Horizontal (spectral) Irradiance (GHI), sum 
        %       the DownDiff and DirectSol components.  
        %
        % Limitations : This function is fragile with respect to small
        %               changes in the MODTRAN flux output table.
        %               This function has been tested with flux table
        %               output from MODTRAN 4 and MODTRAN 5 only. Binary
        %               output from MODTRAN 5 cannot be read using this
        %               function. Use the BN2ASC utility to convert binary
        %               files to ascii.
        %
        % See Also : Mod5.PlotFlx, Mod5.PlotFlxImg
        
        Flx = struct('Spectral', [], 'SpectralUnits', '', 'SpectralLabel', '', 'IrradUnits', '', 'UpDiff', [], 'DownDiff', [], ...
                     'DirectSol', [], 'nAltitudes', [], 'Altitudes', [], 'AltitudeUnits', 'km', 'SlitShape', '', ...
                     'SlitFWHM', [], 'SlitFWHMUnits', '', 'UpTotal', [], 'DownTotal', [], ...
                     'DirectSolTotal', [], 'TotalIrradUnits', '', 'Filename', '', 'Label', '');
       if exist('Label', 'var') && ~isempty(Label) && ischar(Label)
           Flx.Label = Label;
       else
           Label = '';
       end
      %% Check input filename and open
      if ~exist('Filename', 'var') || isempty(Filename)
        MODTRANPath = '';
        % Check for default case directory
        Direc = fileparts(which('Mod5.m'));
        if exist([Direc '\MODTRANExe.mat'], 'file');
          load([Direc '\MODTRANExe.mat']);
        end
        
        % Use dialog
        if isempty(MODTRANPath)
        [Filename, Pathname] = uigetfile({'*.flx;specflux', ...
          'MODTRAN Flux Output Files (*.flx, specflux)'; '*.*', 'All Files'}, 'Select MODTRAN Flux Output File');
        else
        [Filename, Pathname] = uigetfile({'*.flx;specflux', ...
          'MODTRAN Flux Output Files (*.flx, specflux)'; '*.*', 'All Files'}, 'Select MODTRAN Flux Output File', MODTRANPath);
        end
        if Filename
          Filename = [Pathname Filename];
        else
          return;
        end
      else % Filename is not empty, meaning that an explicit filename was given
        assert(ischar(Filename), 'Mod5:ReadFlx:FilenameNotString', 'Input Filename must be a string.');
        if ~exist(Filename, 'file')
          error('Mod5:ReadFlx:FileDoesNotExist', ...
            'The file %s does not seem to exist. Provide full path if not in current directory.', Filename);
        end
      end
      TabCols = 0;
      try
          fid = fopen(Filename, 'rt');
          ib = 0; % This is the block counter
          lin = fgetl(fid);
          while ~feof(fid)
              % Scan for signatures
              if ~isempty(lin)
                  A = textscan(lin, ' SPECTRAL VERTICAL FLUX TABLE (%s %s / %s)', 1);
                  if ~isempty(A{3})
                      ib = ib + 1;
                      if ~isempty(Label), Flx(ib).Label = Label; end;
                      Flx(ib).Filename = Filename;
                      switch A{3}{1}
                          case 'CM-1)'   , Flx(ib).SpectralUnits = 'cm^-1';
                                           Flx(ib).SpectralLabel = 'Wavenumber';
                          case 'NM)'     , Flx(ib).SpectralUnits = 'nm';
                                           Flx(ib).SpectralLabel = 'Wavelength';
                          case 'MICRON)' , Flx(ib).SpectralUnits = 'µm';
                                           Flx(ib).SpectralLabel = 'Wavelength';
                          otherwise Flx(ib).SpectralUnits = '?';
                      end
                      FluxUnits = A{1}{1};
                      switch A{2}{1}
                          case 'CM-2', FluxUnits = [FluxUnits '/cm^2'];
                          otherwise, FluxUnits = [FluxUnits '/?'];
                      end
                      Flx(ib).IrradUnits = [FluxUnits '/' Flx(ib).SpectralUnits];
                      
                  end
                  [A, count] = sscanf(lin, ' %f LAYER BOUNDARIES (%f TABLE COLUMNS)');
                  if count == 2
                      Flx(ib).nAltitudes = A(1);
                      TabCols = A(2);
                  end
                  [A, count] = sscanf(lin, ' %f LEVELS (%f TABLE COLUMNS)');
                  if count == 2
                      Flx(ib).nAltitudes = A(1);
                      TabCols = A(2);
                  end
                  A = textscan(lin,' %s SLIT FULL-WIDTH-AT-HALF-MAXIMUM: %f %s');
                  if ~isempty(A{3})
                      Flx(ib).SlitShape = A{1}{1};
                      Flx(ib).SlitFWHM = A{2}(1);
                      switch A{3}{1}
                          case 'NANOMETERS.', Flx(ib).SlitFWHMUnits = 'nm';
                          case 'MICRONS.', Flx(ib).SlitFWHMUnits = 'µm';
                          case 'CM-1.', Flx(ib).SlitFWHMUnits = 'cm^-1';
                          case 'PERCENT.', Flx(ib).SlitFWHMUnits = '%';
                      end
                  end
                  if strcmp(strtok(lin), 'ALTITUDES:')
                      [~, lin] = strtok(lin); % Get rid of the ALTITUDES: label
                      Altit1 = textscan(lin, ' %f KM ');
                      if Flx(ib).nAltitudes > numel(Altit1{1})
                        Altit2 = textscan(fid, ' %f KM ', Flx(ib).nAltitudes-numel(Altit1{1}));
                        Flx(ib).Altitudes = [Altit1{1}; Altit2{1}]';
                      else
                        Flx(ib).Altitudes = [Altit1{1}]';
                      end
                      Flx(ib).AltitudeUnits = 'km';
                  end
                  % Look for start of spectral irradiance data
                  if strcmp(strtok(lin), '-------') % crude and fragile ?
                      if TabCols == 0
                          error('Mod5:ReadFlx:NoTabCols', 'Flux table read has failed. Check file header.')
                      end
                      % Read all the spectral flux data
                      FlxData = textscan(fid, ' %f', 'WhiteSpace', ' \b\t\r\n');
                      FlxData = FlxData{1};
                      iSpectral = numel(FlxData) / TabCols; % number of spectral points
                      if iSpectral ~= round(iSpectral);
                          error('Mod5:ReadFlx:DataMissing','Flux data misalignment or partial file encountered. Check flux file.')
                      end
                      FlxData = reshape(FlxData, TabCols, iSpectral)';
                      % Put flux data into output structure
                      Flx(ib).Spectral = FlxData(:,1);
                      
                      if Flx(ib).Spectral(1) > Flx(ib).Spectral(end) % Spectral quantity in reverse order
                          Flx(ib).Spectral = flipud(FlxData(:,1));
                          Flx(ib).UpDiff = flipud(FlxData(:, 2:3:end));
                          Flx(ib).DownDiff = flipud(FlxData(:, 3:3:end));
                          Flx(ib).DirectSol = flipud(FlxData(:, 4:3:end));
                      else
                          Flx(ib).Spectral = FlxData(:,1);
                          Flx(ib).UpDiff = FlxData(:, 2:3:end);
                          Flx(ib).DownDiff = FlxData(:, 3:3:end);
                          Flx(ib).DirectSol = FlxData(:, 4:3:end);
                      end
                  end
                  % Look for start of total irradiance data
                  if strcmp(strtok(lin), '=======')
                      TotalFluxUnits = textscan(fid, ' %s %s', 1);
                      FluxUnits = TotalFluxUnits{1}{1};
                      AreaUnits = TotalFluxUnits{2}{1};
                      switch AreaUnits
                          case 'CM-2:', AreaUnits = 'cm^2';
                          otherwise, AreaUnits = '?';
                      end
                      Flx(ib).TotalIrradUnits = [FluxUnits '/' AreaUnits];
                      % Read in the total irradiance data
                      FlxData = textscan(fid, ' %f', 'WhiteSpace', ' \b\t\r\n');
                      FlxData = FlxData{1};
                      Flx(ib).UpTotal = FlxData(1:3:end)';
                      Flx(ib).DownTotal = FlxData(2:3:end)';
                      Flx(ib).DirectSolTotal = FlxData(3:3:end)';
                      
                  end
              end
              lin = fgetl(fid);
          end
          fclose(fid);
      catch FlxReadError
          fclose(fid);
          rethrow(FlxReadError);
      end
        
    end % ReadFlx
    function plothandle = PlotFlx(Flx, iAltitudes)
        % PlotFlx : Plot MODTRAN fluxes (horizontal irradiances)
        %
        % Usage :
        %   plothandle = Mod5.PlotFlx(Flx)
        %      or
        %   plothandle = Mod5.PlotFlx(Flx, iAltitudes)        
        %
        % The input structure Flx must be produced by the function ReadFlx.
        %
        % Plots four graphs for each element of the input structure Flx.
        % The first three are plots of upward diffuse, downward diffuse and
        % direct solar irradiance versus the spectral variable (wavelength
        % or wavenumber). The last plot is a plot of total irradiance
        % versus altitude with all of the three components.
        %
        % If the optional altitude boundary index vector iAltitudes is
        % given, only the specified altitudes will be plotted. Note these
        % are not the altitudes themselves, but the indices pointing into
        % the Flx.Altitudes field. If there are less than 6 layour
        % boundaries, then a legend is plotted of the boundary altitudes.
        %
        % The output plothandle is a vector of figure handles.
        %
        % See Also : ReadFlx, PlotFlx, PlotFlxImg
        
        % Check input structure
        TheFields = {'Spectral', 'SpectralUnits', 'SpectralLabel', 'IrradUnits', 'UpDiff', 'DownDiff', ...
                     'DirectSol', 'nAltitudes', 'Altitudes', 'AltitudeUnits',  'SlitShape', ...
                     'SlitFWHM', 'SlitFWHMUnits', 'UpTotal', 'DownTotal', ...
                     'DirectSolTotal', 'TotalIrradUnits', 'Filename', 'Label'};
        assert(all(isfield(Flx, TheFields)), 'Mod5:PlotFlx:MissingFields', ...
            'The input Flx does not have the required fields. It must be read using Mod5.ReadFlx.');
        
        iPlot = 0;
        plothandle = [];
        for iFlx = 1:numel(Flx)
            if exist('iAltitudes', 'var') && ~isempty(iAltitudes) && isnumeric(iAltitudes)
              assert(all(iAltitudes) <= Flx(iFlx).nAltitudes, 'Mod5:PlotFlx:BadiAltitudes', ...
                  'Elements of iAltitudes must all be less than the number of elements in Flx.Altitudes.');
            else
                iAltitudes = 1:Flx(iFlx).nAltitudes;
            end
            Flx(iFlx).SpectralUnits = strrep(Flx(iFlx).SpectralUnits, 'cm^-1', 'cm^{-1}'); % TeXify
            Flx(iFlx).IrradUnits = strrep(Flx(iFlx).IrradUnits, 'cm^-1', 'cm^{-1}'); % TeXify
            TheLegends = {};
            if numel(iAltitudes) <=5 % will add legends in those plots
                for iLdg = 1:numel(iAltitudes)
                  TheLegends = [TheLegends, ...
                    [num2str(Flx(iFlx).Altitudes(iAltitudes(iLdg))) ' ' Flx(iFlx).AltitudeUnits]];
                end
                TheLegends = [TheLegends, 'location', 'best'];
            end
            if ~isempty(Flx(iFlx).Spectral) % presumably there is something to plot
                iPlot = iPlot + 1; plothandle(iPlot) = figure;
                % Plot upward diffuse
                plot(Flx(iFlx).Spectral, Flx(iFlx).UpDiff(:, iAltitudes));
                grid;
                xlabel([Flx(iFlx).SpectralLabel ' (' Flx(iFlx).SpectralUnits ')']);
                ylabel(['Upward Diffuse Irradiance (' Flx(iFlx).IrradUnits ')']);
                title(['Upward Diffuse Spectral Irradiance - ' Flx(iFlx).Label]);
                if ~isempty(TheLegends)
                    legend(TheLegends{:});
                end
                
                iPlot = iPlot + 1; plothandle(iPlot) = figure;
                % Plot downward diffuse
                plot(Flx(iFlx).Spectral, Flx(iFlx).DownDiff(:, iAltitudes));
                grid;
                xlabel([Flx(iFlx).SpectralLabel ' (' Flx(iFlx).SpectralUnits ')']);
                ylabel(['Downward Diffuse Irradiance (' Flx(iFlx).IrradUnits ')']);
                title(['Downward Diffuse Spectral Irradiance - ' Flx(iFlx).Label]);
                if ~isempty(TheLegends)
                    legend(TheLegends{:});
                end
                
                
                iPlot = iPlot + 1; plothandle(iPlot) = figure;
                % Plot (downward) direct solar
                plot(Flx(iFlx).Spectral, Flx(iFlx).DirectSol(:, iAltitudes));
                grid;
                xlabel([Flx(iFlx).SpectralLabel ' (' Flx(iFlx).SpectralUnits ')']);
                ylabel(['Direct Solar Irradiance (' Flx(iFlx).IrradUnits ')']);
                title(['Direct Solar Spectral Irradiance - ' Flx(iFlx).Label]);
                if ~isempty(TheLegends)
                    legend(TheLegends{:});
                end
                
                
                iPlot = iPlot + 1; plothandle(iPlot) = figure;
                % Plot total versus altitude
                plot(Flx(iFlx).UpTotal, Flx(iFlx).Altitudes, Flx(iFlx).DownTotal, Flx(iFlx).Altitudes, ...
                     Flx(iFlx).DirectSolTotal, Flx(iFlx).Altitudes);
                grid;
                xlabel(['Total Irradiance (' Flx(iFlx).TotalIrradUnits ')']);
                ylabel(['Altitude (' Flx(iFlx).AltitudeUnits ')']);
                title(['Total Spectral Irradiance - ' Flx(iFlx).Label]);
                legend('Upward Diffuse','Downward Diffuse','Direct Solar', 'Location', 'best');
                
            end
        end
    end % PlotFlx
    function plothandle = PlotFlxImg(Flx, Altitudes, InterpMethod, TheColorMap)
        % PlotFlxImg : Plot a coloured image of spectral fluxes over height
        %
        % Usage :
        %    plothandle = PlotFlxImg(Flx);
        %
        %      Or
        %    plothandle = PlotFlxImg(Flx, Altitudes);
        %
        %      Or
        %    plothandle = PlotFlxImg(Flx, Altitudes, InterpMethod);
        %
        %    plothandle = PlotFlxImg(Flx, Altitudes, InterpMethod, TheColorMap);
        %
        % Input Flx must be a structure read using the function ReadFlx
        %
        % Plots colored images of the spectral fluxes (horizontal
        % irradiance) with the spectral variable on the horizontal axis and
        % altitude on the vertical axis. Three images are plotted, one for
        % the upward diffuse irradiance, one for downward diffuse and one
        % for direct solar irradiance. If the optional input Altitudes is
        % given (numeric vector), the fluxes are interpolated onto these
        % Altitudes, using the interpolation method specified in the
        % optional additional input InterpMethod. InterpMethods are as for
        % the function interp1. The default altitudes in MODTRAN are not 
        % evenly spaced, so it is highly recommended that the input
        % Altitudes be given with regular spacing of at least 1 km,
        % otherwise the vertical (altitude) scale will be incorrect or
        % misleading.
        % 
        % The color bar scale on the right of the
        % plot can be given as the input TheColorMap. Suitable inputs are
        % anything that is valid for the colormap function. If any of the
        % optional inputs is missing or empty, they will default as follows:
        %    Altitudes : defaults to the Altitudes field in the input Flx
        % InterpMethod : defaults to 'linear'
        %  TheColorMap : defaults to jet (not 'jet'), jet is a
        %                Matlab-defined function that generates the jet colormap.
        %                Other colormaps can be found by getting help on
        %                the colormap function.
        %
        % Example :
        %    Irrad = Mod5.ReadFlx('ExampleA.flx'); % read the fluxes
        %    Mod5.PlotFlxImg(Irrad, 1:1:100, 'pchip', bone(256));
        %
        % The above example reads the irradiances from the specified file
        % and plots interpolated fluxes on the altitude grid 0 to 100 km in
        % steps of 1 km, using the 'pchip' interpolation method. The
        % colormap used is bone (see colormap function), with 256 color levels.
        %
        % See Also : ReadFlx, PlotFlx, interp1, colormap
        TheFields = {'Spectral', 'SpectralUnits', 'SpectralLabel', 'IrradUnits', 'UpDiff', 'DownDiff', ...
                     'DirectSol', 'nAltitudes', 'Altitudes', 'AltitudeUnits',  'SlitShape', ...
                     'SlitFWHM', 'SlitFWHMUnits', 'UpTotal', 'DownTotal', ...
                     'DirectSolTotal', 'TotalIrradUnits', 'Filename', 'Label'};
        assert(all(isfield(Flx, TheFields)), 'Mod5:PlotFlxImg:MissingFields', ...
            'The input Flx does not have the required fields. It must be read using Mod5.ReadFlx.');
        % Check and default the Altitudes input
        if exist('Altitudes', 'var') && ~isempty(Altitudes)
            assert(isnumeric(Altitudes) && isvector(Altitudes) && all(Altitudes >= 0) && all(Altitudes <= 100), ...
                'Mod5:PlotFlxImg:BadAltitudes', ...
                'Input Altitudes to PlotFluxImg must be a numeric vector with values >= 0 and <= 100 km.');
        else
            warning('Mod5:PlotFlxImg:AltIrreg', 'Recommended to provide Altitudes input on a regular spacing.');
            Altitudes = [];
        end
        % Check and default the InterpMethod input
        if exist('InterpMethod', 'var') && ~isempty(InterpMethod)
            assert(ischar(InterpMethod), 'Mod5:PlotFlxImg:BadBadInterpMethod', ...
                'Input InterpMethod to PlotFlxImg must be char, and valid as for interp1.');
        else
            InterpMethod = 'linear';
        end
        % Check and default the colormap
        if exist('TheColorMap', 'var') && ~isempty(TheColorMap)
            assert(isnumeric(TheColorMap) && size(TheColorMap, 2) == 3, 'Mod5:PlotFlxImg:BadColorMap', ...
                'Input TheColorMap must be a three column numeric matrix or other valid input to colormap function.');
        else
            TheColorMap = jet(256); % Use 256 colours in the palette 
        end
        
        iPlot = 0;
        plothandle = [];
        for iFlx = 1:numel(Flx)
            if ~isempty(Flx(iFlx).Spectral) % Presumably there is something to plot
              Flx(iFlx).SpectralUnits = strrep(Flx(iFlx).SpectralUnits, 'cm^-1', 'cm^{-1}'); % TeXify
              Flx(iFlx).IrradUnits = strrep(Flx(iFlx).IrradUnits, 'cm^-1', 'cm^{-1}'); % TeXify
               Label = Flx(iFlx).Label; 
               iPlot = iPlot + 1;               
               if ~isempty(Altitudes) % Interpolate onto new altitudes
                   Irrad = interp1(Flx(iFlx).Altitudes, Flx(iFlx).UpDiff', Altitudes, InterpMethod);
                   Irrad = Irrad';
                   TheAltitudes = Altitudes;
               else
                   TheAltitudes = Flx(iFlx).Altitudes;
                   Irrad = Flx(iFlx).UpDiff;
               end
               imagesc(Flx(iFlx).Spectral, -TheAltitudes, Irrad');
               colorbar;
               colormap(TheColorMap);
               ylabel(['Altitude (' Flx(iFlx).AltitudeUnits ')']);
               xlabel([Flx(iFlx).SpectralLabel ' (' Flx(iFlx).SpectralUnits ')']);
               title(['Upward Diffuse Irradiance vs Altitude - ' Label ' (' Flx(iFlx).IrradUnits ')']);
               plothandle(iPlot) = gcf;
               

               % Downwelling irradiances
               iPlot = iPlot + 1;               
               if ~isempty(Altitudes) % Interpolate onto new altitudes
                   Irrad = interp1(Flx(iFlx).Altitudes, Flx(iFlx).DownDiff', Altitudes, InterpMethod);
                   Irrad = Irrad';
                   TheAltitudes = Altitudes;
               else
                   TheAltitudes = Flx(iFlx).Altitudes;
                   Irrad = Flx(iFlx).DownDiff;
               end
               plothandle(iPlot) = figure;
               imagesc(Flx(iFlx).Spectral, -TheAltitudes, Irrad');
               colorbar;
               colormap(TheColorMap);
               ylabel(['Altitude (' Flx(iFlx).AltitudeUnits ')']);
               xlabel([Flx(iFlx).SpectralLabel ' (' Flx(iFlx).SpectralUnits ')']);
               title(['Downward Diffuse Irradiance vs Altitude - ' Label ' (' Flx(iFlx).IrradUnits ')']);
               
               % Direct solar irradiances
               iPlot = iPlot + 1;              
               if ~isempty(Altitudes) % Interpolate onto new altitudes
                   Irrad = interp1(Flx(iFlx).Altitudes, Flx(iFlx).DirectSol', Altitudes, InterpMethod);
                   Irrad = Irrad';
                   TheAltitudes = Altitudes;
               else
                   TheAltitudes = Flx(iFlx).Altitudes;
                   Irrad = Flx(iFlx).DirectSol;
               end
               plothandle(iPlot) = figure;
               imagesc(Flx(iFlx).Spectral, -TheAltitudes, Irrad');
               colorbar;
               colormap(TheColorMap);
               ylabel(['Altitude (' Flx(iFlx).AltitudeUnits ')']);
               xlabel([Flx(iFlx).SpectralLabel ' (' Flx(iFlx).SpectralUnits ')']);
               title(['Direct Solar Irradiance vs Altitude - ' Label ' (' Flx(iFlx).IrradUnits ')']);
               
            end

        end
    end % PlotFlxImg
    function [Data, FiltDescr, ColHeads] = ReadChn(Filename)
      % ReadChn : Read data from a .chn spectral channel output from MODTRAN
      %
      % Usage
      %
      %   [Data, FiltDescr] = Mod5.ReadChn(Filename)
      %
      % If the filename is not given or is empty, a file open dialog will
      % be presented.
      %
      % The returned data will be be returned in a cell array, in
      % a series of blocks. Output of the .chn file is expected if a .flt
      % band filter file is specified for a run (see MODTRAN inputs 
      % LFLTNM and FILTNM).
      % 
      % Output Data is a cell array, with one cell for each block
      % of channel outputs (i.e one block per case written in the .chn file)
      % Output FiltDescr is a one line filter description for each channel
      % output.
      %
      % ColHeads is a cell array of strings, one for each channel block
      % as well.
      %
      
      Data = {};
      FiltDescr = {};
      ColHeads = {};
      ThisColHeads = '';
      %% Check input filename and open
      if ~exist('Filename', 'var') || isempty(Filename)
        MODTRANPath = '';
        % Check for default case directory
        Direc = fileparts(which('Mod5.m'));
        if exist([Direc '\MODTRANExe.mat'], 'file');
          load([Direc '\MODTRANExe.mat']);
        end
        
        % Use dialog
        if isempty(MODTRANPath)
          [Filename, Pathname] = uigetfile({'*.chn;channels.out', ...
            'MODTRAN Channel Output Files (*.chn)'; '*.*', 'All Files'}, 'Select MODTRAN Channels Output File');
        else
          [Filename, Pathname] = uigetfile({'*.chn;channels.out', ...
            'MODTRAN Channel Output Files (*.chn)'; '*.*', 'All Files'}, 'Select MODTRAN Channels Output File', MODTRANPath);
        end
        if Filename
          Filename = [Pathname Filename];
        else
          return;
        end
      else % Filename is not empty, meaning that an explicit filename was given
        assert(ischar(Filename), 'Mod5:ReadChn:FilenameNotString', 'Input Filename must be a string.');
        if ~exist(Filename, 'file')
          error('Mod5:ReadChn:FileDoesNotExist', ...
            'The file %s does not seem to exist. Provide full path if not in current directory.', Filename);
        end
      end
      try % to read the file
        fid = fopen(Filename, 'rt');
        % Processing of this file is conducted line by line at first
        iBlock = 0;
        while ~feof(fid)
          lin = fgetl(fid);
          % Check if line starts with ----
          if ischar(lin) && strncmp(strtrim(lin), '----', 4);
            % Determine the number and position of columns using this line
            ColStart = regexp(lin, '\s\S') + 1; % transitions from space to non-space
            % All but the last column is numeric data
            TheFormat = repmat('%f ', 1, length(ColStart) - 1);
            % Read in the block of data
            % First Increment the block counter
            iBlock = iBlock + 1;
            % Assign the ColHeads
            ColHeads{iBlock} = ThisColHeads;
            ThisColHeads = '';
            iChan = 0; % Filter channel counter
            while ~feof(fid)
              lin = fgetl(fid);
              [A,count] = sscanf(lin, TheFormat);
              if count ~= length(ColStart)-1
                break; % out of the while loop reading the current block
              end
              iChan = iChan + 1;
              % Put the data into the block
              Data{iBlock}(iChan,:) = A';
              % Put the comment into the FiltDescr output
              if length(ColStart) > 1
                FiltDescr{iChan, iBlock} = lin(ColStart(end):end); % From last rising edge 
              else
                FiltDescr{iChan, iBlock} = '';
              end
            end
          elseif ischar(lin) && ~isempty(strtrim(lin))
            % Process header data
            ThisColHeads = strvcat(ThisColHeads, lin); 
          end
        end
        fclose(fid);
      catch FileReadFailed
        fclose(fid);
        rethrow(FileReadFailed);
      end
    end % ReadChn
    function [PlotData, SepLin] = ReadPlt(Filename)
      % ReadPlt : Read MODTRAN plot data (.plt, .psc, plotout, plotout.scn)
      %
      % Usage :
      %   [PlotData, SepLin] = Mod5.ReadPlt(Filename);
      % 
      % Filename is the .plt, .psc, plotout or plotout.scn file output
      % by MODTRAN. If the Filename parameter is empty or omitted, a
      % file/open dialog is presented.
      %
      % PlotData is a cell array of output data blocks. The first
      % row and column, PlotData{1,1} is the x data for the first plot.
      % PlotData{1,2} is the y data for the first plot. PlotData{2,1} is
      % the x data for the second plot and so on.
      % If seperator lines are found between the plot data blocks, these
      % are returned in the cell array SepLin.
      %
      % The data is returned with the x quantity in increasing order, even
      % if the x quantity is in decreasing order in the file.
      %
      % Bugs :
      %  If the MODTRAN case that generated the plot data being read does
      %  not specify a plot seperator (MODTRAN parameter DLIMIT), then
      %  it is possible that the block boundaries will not be correctly
      %  identified. This can be avoided by always specifying a non-
      %  numeric value for DLIMIT before running the case. DLIMIT occurs
      %  on Card 4.
      %
      
      %% Check inputs to ReadPlt
      PlotData = {};
      if ~exist('Filename', 'var') || isempty(Filename)
        [Filename, Pathname] = uigetfile({'*.plt;*.psc;pltout;pltout.scn', ...
          'MODTRAN Plot Output Files (*.plt, *.psc)'; '*.*', 'All Files'}, 'Select MODTRAN Plot Output File');
        if ~Filename
          return
        end
        Filename = [Pathname Filename];
      else
        assert(ischar(Filename), 'Mod5:ReadPlt:BadFilename','Input Filename must be a string.');
      end
      [pathstr, name] = fileparts(Filename);
      
      if ~exist(Filename, 'file')
        error('Mod5:ReadPlt:FileDoesNotExist',...
          ['The file ' Filename ' does not seem to exist. Give full pathname if not in current directory.'])
      end
      SepLin = {}; % Seperator lines may not be present
      %% Open the data file and process
      try
        fid = fopen(Filename, 'rt');
        % Read using textscan, either the entire file or up to a delimiter
        dblock = 0;
        while ~feof(fid)
          dblock = dblock + 1;
          Data = textscan(fid, '%f %f'); % Plot files always 2 columns
          xQ = Data{1}; % The x quantity
          yQ = Data{2}; % The y quantity
          if length(xQ) < 2
            dblock = max(0, dblock - 1);
            Garbage = fgetl(fid); % Toss out a line of the file
            continue; % Give up, go round again, hopefully not infinite loop
          end
          % Check the data and look for discontinuities in x
          % In general, between blocks the spectral quantity will have a discontinuity
          % Determine the difference between the first and second elements in the spectral data
          DeltaxQ = xQ(2) - xQ(1);
          % Next look for changes in freq that exceed that by a factor of 2
          iStep = find(abs(diff(xQ)) > 2 * abs(DeltaxQ), 1); % Find the first unusual step in the x quantity
          while ~isempty(iStep) % Part off everything up to the first step
            if DeltaxQ > 0
              PlotData{dblock, 1} = xQ(1:iStep);
              PlotData{dblock, 2} = yQ(1:iStep);
            else % Flip the data so that it is in increasing order of the x quantity
              PlotData{dblock, 1} = flipud(xQ(1:iStep));
              PlotData{dblock, 2} = flipud(yQ(1:iStep));
            end
            xQ(1:iStep) = []; % Delete those elements
            yQ(1:iStep) = [];
            SepLin{dblock} = ''; % Return blank seperators for these blocks
            dblock = dblock + 1;
            DeltaxQ = xQ(2) - xQ(1);
            iStep = find(abs(diff(xQ)) > 2 * abs(DeltaxQ), 1); % Find the first unusual step in the x quantity
          end
          % Assign the remainder of the data to the last block
          PlotData{dblock, 1} = xQ;
          PlotData{dblock, 2} = yQ;
          if ~feof(fid)
            SepLin{dblock} = fgetl(fid); % Should probably return the seperator lines as well
          end
        end
        fclose(fid);
      catch pltFileReadFail
        fclose(fid);
        rethrow(pltFileReadFail);
      end
    end % ReadPlt
  end % Public static Methods
  methods (Access = private, Static)
    function [start, stop] = DilateHeaders(start, stop, headlin)
        % Attempt to expand the headers in a .7sc type file
        % Move the header start positions to the left while the adjacent
        % character to the left is non-blank
        for istart = 2:numel(start)
            while headlin(start(istart)-1) ~= ' ' && (start(istart)-1) > stop(istart - 1)  
                start(istart) = start(istart) - 1;
            end
        end
        % Move the header stop positions to the right while the
        % adjacent character to the right is non-blank
        for istop = 1:(numel(stop)-1)
            while headlin(stop(istop)+1) ~= ' ' && (stop(istop)+1) < start(istop + 1)
                stop(istop) = stop(istop) + 1;
            end
        end
    end % Dilate      
    function Goodness = GoodFit(NewWv)
      % GoodFit : Experiment, leave well alone
      global OldRefl OldWv NewRefl
      NewRefl = interp1(OldWv, OldRefl, NewWv, 'linear');
      % Reinterpolate back to the old wavelengths
      BackToOldRefl = interp1(NewWv, NewRefl, OldWv, 'linear');
      Difference = OldRefl - BackToOldRefl;
      Difference = Difference(~isnan(Difference));
      % Make an effort to keep NewWv in order
      Orderly = sum(diff(NewWv) <= 0);
      Goodness = sqrt(sum(Difference.^2)) + Orderly;
    end % GoodFit            
    function [Data, Heads] = Read7a(Filename)
      % Deprecated - this is a somewhat broken version of Read7
      % Mod5.Read7 : Read MODTRAN Tape 7 format outputs
      % 
      % Reads a multiblock MODTRAN output file in the .tp7 or .7sc file
      % formats. MODTRAN writes one block of data for each sub-case in
      % the case file.
      %
      % The input Filename is the name of the tape7 (or .tp7 or .7sc) file
      % written by MODTRAN. These are the main tranmission or radiance
      % results.
      %
      % Both outputs are cell arrays.
      %
      % The Data for each of the blocks is returned in a cell array
      % for each of the outputs. For example, the Data in the first block
      % and first column is referenced as Data{1,1}. The data for the
      % second column in the first block is Data{1,2} etc. Freq is a cell
      % column vector, giving the frequencies in cm^-1 for each of the
      % data blocks in the file. 
      % Heads is a cell array of headers (strings) for each of the columns
      % and blocks. The header for the 3rd column in the first block would
      % be Head{1}(3). The headers are not identical to the column headers
      % in the tape7 file in all cases. Note that indexing of Head is 
      % different to indexing of the Data cell array.
      %
      % Mod5.Read7 is somewhat similar to the older ReadMODTRANfl7.m
      % except that all data is returned and it is not possible to select
      % particular columns. Like ReadMODTRANfl7, this function returns
      % unsanitised headers. The calling function must sanitise the 
      % headers if required. The function to do this is called
      %  Mod5.FixHeaders. This function removes blanks, non alphabetic
      %  characters and provides translation to a more consistent set of
      %  headers. Look at the source code of FixHeaders to see what 
      %  translations are performed.
      %
      % Bugs:
      %  Some column headers in tape7 files are poorly aligned to the data
      %  and this causes the headers to be identified incorrectly. This is
      %  so particularly for tape7 files output from runs in the direct
      %  solar/lunar irradiance mode (IEMSCT = 3). The current version
      %  of Mod5.FixHeaders corrects some of these problems.
      
      % The strategy is similar to ReadMODTRANfl7.m, except that the numeric
      % data is tokenised, then the starting and ending column numbers of the 
      % data is determined. The headers are then established by finding the
      % text above each of the numeric columns. This is necessary because in
      % some .7sc files, headers are present without data in the column below.
      % The headers are determined by finding the space in the header line
      % that is closest to the starting and ending columns of the numeric
      % data.
      %
      % A further improvement is that a combination of ftell and fseek is used
      % to position back to the start of the data block after sampling the
      % data.
      %
      % In direct solar irradiance mode, tape7 can have a column of data
      % without a header (see CaseM04) ! 
      
      
      
      % If the filename is not present, open a dialog and get a filename.
      %% Check inputs to Read7
      if ~exist('Filename', 'var') || isempty(Filename)
        [Filename, Pathname] = uigetfile({'*.tp7;*.7sc;tape7;tape7.scn', ...
          'MODTRAN Tape7 Output Files (*.tp7, *.7sc)'; '*.*', 'All Files'}, 'Select MODTRAN Tape7 Output File');
        if ~Filename
          return
        end
        Filename = [Pathname Filename];
      else
        assert(ischar(Filename), 'Mod5_Read7:BadFilename','Input Filename must be a string.');
      end
      [pathstr, name] = fileparts(Filename);
      
      if ~exist(Filename, 'file')
        error('Mod5_Read7:FileDoesNotExist',...
          ['The file ' Filename ' does not seem to exist. Give full pathname if not in current directory.'])
      end
      
      %% Open the MODTRAN tape 7 output file and start reading
      Heads = {''};
      Data = {[]};
      try % to read the tape 7 file      
      fid = fopen(Filename, 'rt');
      dblock = 0; % Count the datablocks in the file - should correspond to the number runs of MODTRAN in the case if all went well.
      %lin = [' ' fgetl(fid) ' ']; % Always ensure that possible header lines start and end with blanks
      while ~feof(fid)
        lin = [' ' fgetl(fid) ' ']; % pad front and rear with a blank        
        tok = strtok(lin, ' ');
        if strcmpi(tok, 'FREQ') % Found a header line
          dblock = dblock + 1;
          headers = {}; % Empty the headers cell array
          headlin1 = lin; % This will be the first header line 
          % Remember this position in the file
          EndHeaderLine1 = ftell(fid);
          headlin2 = [' ' fgetl(fid) ' ']; % Get what is possibly another header line and pad front and back with blanks
          EndHeaderLine2 = ftell(fid);
          % Check to see if this is data
          tok2 = strtok(headlin2, ' ');
          if isletter(tok2(1)) % The headers comprise 2 lines
            % Compose the headers from 2 lines
            % First read a line of data
            lin = [' ' fgetl(fid) ' ']; % make sure it starts and ends with a blank
            % Find the blanks between the data column
            start = regexp(lin, '\s\S') + 1; % rising edge
            stop = regexp(lin, '\S\s'); % falling edge
            start(1) = 1; % Force start of first header at start of line 
            % Next find the spaces in the header line
            starth1 = regexp(headlin1, '\s\S'); % rising edge
            stoph1 = regexp(headlin1, '\S\s'); % falling edge
            starth1(1) = 1; % Force to start of line
            % For each start/stop position in the data, find the nearest start/stop position in the header
            beststarth1 = zeros(size(start));
            beststoph1 = zeros(size(start));
            for ist = 1:length(start)
              %abs(starth1 - start(istart))
              [m,im] = min(abs(starth1 - start(ist)));
              beststarth1(ist) = starth1(im);
              [m,im] = min(abs(stoph1 - stop(ist)));
              beststoph1(ist) = stoph1(im);
            end
            
            % Do the same for the second header line
            starth2 = regexp(headlin2, '\s\S'); 
            stoph2 = regexp(headlin2, '\S\s');
            starth2(1) = 1;
            beststarth2 = zeros(size(start));
            beststoph2 = zeros(size(start));            
            for ist = 1:length(start)
              %abs(starth1 - start(istart))
              [m,im] = min(abs(starth2 - start(ist)));
              beststarth2(ist) = starth2(im);
              [m,im] = min(abs(stoph2 - stop(ist)));
              beststoph2(ist) = stoph2(im);
            end
            % Split up the first header line
            for iii = 1:(length(start))
                headers{iii} = headlin1(beststarth1(iii):beststoph1(iii));
                % Deblank
                headers{iii} = strtrim(headers{iii});
                % Header continues on next line (headlin2)
                headers2{iii} = headlin2(beststarth2(iii):beststoph2(iii));
                headers2{iii} = strtrim(headers2{iii});
                % Merge
                headers{iii} = [headers{iii} ' ' headers2{iii}];
            end
            % headers
            % Seek back to the end of header line 2
            SeekStatus = fseek(fid, EndHeaderLine2, 'bof');
            if SeekStatus
                error('Mod5_Read7:SeekError','Error seeking to start of tape7 data block.')
            end
            
          else % The headers were on one line e.g. caseM18
            % Find the blanks between the data column
            start = regexp(headlin2, '\s\S');
            start(1) = 1; % Force start of first header at start of line 
            stop = regexp(headlin2, '\S\s');
            % Next find the spaces in the header line
            starth1 = regexp(headlin1, '\s\S');
            starth1(1) = 1; % Force to start of line
            stoph1 = regexp(headlin1, '\S\s');
            % For each start position in the data, find the nearest start position in the header
            beststarth1 = zeros(size(start));
            beststoph1 = zeros(size(start));
            for ist = 1:length(start)
              %abs(starth1 - start(istart))
              [m,im] = min(abs(starth1 - start(ist)));
              beststarth1(ist) = starth1(im);
              [m,im] = min(abs(stoph1 - stop(ist)));
              beststoph1(ist) = stoph1(im);
            end
            % Do the same for the second header line
            % Split up the first header line
            for iii = 1:(length(start))
                headers{iii} = headlin1(beststarth1(iii):beststoph1(iii));
                % Deblank
                headers{iii} = strtrim(headers{iii});
            end
            %headers
            % Seek back to the end of header line 1
            SeekStatus = fseek(fid, EndHeaderLine1, 'bof');
            if SeekStatus
                error('Mod5_Read7:SeekError','Error seeking to start of tape7 data block.')
            end
          end
          Heads{dblock,1} = headers;  % Put the headers for this block into the output cell array
          % Read the entire data block
          Format = repmat('%f', 1, length(start));
          blockdata = textscan(fid, Format);
          ValidRows = blockdata{1} ~= -9999; % This is to remove lines with -9999. in the FREQ column 
          for iCol = 1:length(start)
            Data{dblock, iCol} = blockdata{iCol}(ValidRows);
          end
          
          % Also add in empty blocks according to the number of -9999. lines
          % If there is only one -9999, then nothing needs be done, but for
          % each additional occurrance of -9999, an empty block is inserted.
          for iEmtyBlock = 1:(sum(~ValidRows)-1)
            dblock = dblock+1;
            Heads{dblock,1} = {};
            Data{dblock,1} = [];
          end
        elseif str2double(tok) == -9999 % Deal with occurrances of -9999 that do not follow after data
          dblock = dblock+1;
          Heads{dblock,1} = {};
          Data{dblock,1} = [];
        end % strncmp(tok, 'FREQ') % found a header
      end % while ~feof(fid)
      fclose(fid);
      catch ReadFailed
        fclose(fid)
        rethrow(ReadFailed);
      end
      
    end % Read7a - deprecated
    function lin = fgetl80(fid)
      % fgetl80 : Read a line from fid and pad to 80 characters with blanks
      if feof(fid)
        % Issue warning if attempt was made to read past the end of the file
        warning('fgetl80:EOF', 'Attempted to read past end of file.');
      end
      lin = fgetl(fid);
      if length(lin) < 80
        lin = [lin blanks(80 - length(lin))];
      elseif length(lin) > 80
        lin = lin(1:80);
      end
    end % fgetl80 
    function lin = fgetlN(fid, N)
        %fgetlN : Get a line and pad with blanks to N characters
      if feof(fid)
        % Issue warning if attempt was made to read past the end of the file
        warning('fgetlN:EOF', 'Attempted to read past end of file.');
      end
      lin = fgetl(fid);
      if N > 0
          if length(lin) < N
              lin = [lin blanks(N - length(lin))];
          elseif length(lin) > N
              lin = lin(1:N);
          end
      end
    end % fgetlN
    function Pass = ScalarNumPos(varargin)
      % ScalarNumPos : Verify that all input arguments are scalar, numeric and positive
      Pass = 1;
      for iArg = 1:numel(varargin)
        Pass = Pass && isscalar(varargin{iArg}) && isnumeric(varargin{iArg}) && varargin{iArg} >= 0;
      end
    end % ScalarNumPos
    function [AlbName, AlbNum] = AlbedoName(Title)
      % AlbedoName : Obtain name of albedo surface from albedo title
      [AlbNum, AlbName] = strtok(Title);
      AlbNum = str2double(AlbNum);
      % Strip off any comment at the end
      CommStart = strfind(AlbName, '!');
      if ~isempty(CommStart)
        AlbName = AlbName(1:CommStart(1)-1);
      end
      AlbName = strtrim(AlbName); % Trim any white space
    end % AlbedoName        
  end % Private static methods
  methods (Access = public)  
    function MC = Mod5(Filename, DebugFlag)
      % Mod5 Constructor - reads a .ltn or .tp5 case into the class instance
      %
      % Usage :
      %   MC = Mod5(Filename) % Read MODTRAN case from .ltn file
      %      Or
      %   MC = Mod5(Filename, DebugFlag)   % Read .ltn file and display
      %                                           % debug information.
      %      Or
      %   MC = Mod5    % Obtain empty instance
      %
      % Where :
      %   Filename is the full filename of the MODTRAN case (.ltn) to read.
      %   If Filename is the empty string '', a file open dialog is presented.
      %   The default directory for this dialog can be set using the static
      %   method Mod5.SetCasePath. 
      %
      

      %% Check input filename and open
      if ~exist('Filename', 'var')
        return;
      else
        assert(ischar(Filename), 'Mod5:FilenameNotString', 'Input Filename must be a string.');
        if isempty(Filename)
          CaseDirectory = '';
          % Check for default case directory
          Direc = fileparts(which('Mod5.m'));
          if exist([Direc '\Mod5Dir.mat'], 'file');
            load([Direc '\Mod5Dir.mat']);
          end
          
          % Use dialog
          if isempty(CaseDirectory)
            [Filename, Pathname] = uigetfile({'*.tp5;*.ltn;tape5', ...
            'MODTRAN .ltn or .tp5 Input Files (*.tp5, *.ltn)'; '*.*', 'All Files'}, 'Select MODTRAN Tape5 Input File');
          else
            [Filename, Pathname] = uigetfile({'*.tp5;*.ltn;tape5', ...
            'MODTRAN .ltn or .tp5 Input Files (*.tp5, *.ltn)'; '*.*', 'All Files'}, 'Select MODTRAN Tape5 Input File', CaseDirectory);            
          end
          if Filename
            Filename = [Pathname Filename];
          else
            return;
          end
        end
      end
      if exist('DebugFlag','var')
        assert(isnumeric(DebugFlag), 'Mod5:DebugFlagNumeric','Input DebugFlag must be numeric flag.')
      else
        DebugFlag = 0;
      end
      assert(logical(exist(Filename, 'file')), 'Mod5:FileNotFound','The file %s does not appear to exist.', Filename);
      [p, theCaseName] = fileparts(Filename);
      fid = fopen(Filename, 'rt');
      iCase = 1; % Count the cases in the file
      FileFinished = 0; % This flag is set when IRPT of blank or zero is encountered
      try % to read the .ltn file
       while ~FileFinished && ~feof(fid) % Read any number of cases from a single file 
        MC(iCase).OriginFile = Filename;
        MC(iCase).DebugFlag = DebugFlag;
        % Set the case name from the filename and the CaseIndex
        MC(iCase).CaseName = theCaseName;
        MC(iCase).CaseIndex = iCase;
        %% Cards 1 and 1A - Main Radiative Transport Driver
        MC(iCase) = MC(iCase).ReadCard1(fid);
        MC(iCase) = MC(iCase).ReadCard1A(fid);
        %% Cards 1A1, 1A2 and 1A3 - Spectral Data and Sensor Response Function Files
        if strcmpi(MC(iCase).LSUNFL, 'T') % Read card 1A1
          MC(iCase) = MC(iCase).ReadCard1A1(fid);
        end
        if any(MC(iCase).LBMNAM == 'Tt42') % Read card 1A2
          MC(iCase) = MC(iCase).ReadCard1A2(fid);  % The whole line
        end
        if strcmpi(MC(iCase).LFLTNM, 'T') % Read card 1A3
          MC(iCase) = MC(iCase).ReadCard1A3(fid);  % The whole line
        end
        % Card 1A4 - the data directory
        if strcmpi(MC(iCase).CDTDIR, 'T') % Read card 1A4
          MC(iCase) = MC(iCase).ReadCard1A4(fid);  % The whole line
        end
        
        %% Card 2 - Main Aerosol and Cloud Options
        MC(iCase) = MC(iCase).ReadCard2(fid);
        if strcmp(MC(iCase).APLUS, 'A+') % Read card 2A+ Flexible aerosol Model
          MC(iCase) = MC(iCase).ReadCard2APlus(fid);
        end
        if MC(iCase).ICLD == 18 || MC(iCase).ICLD == 19 % Read card 2A
          MC(iCase) = MC(iCase).ReadCard2A(fid);
        end
        if any(MC(iCase).ICLD == 1:10)  % Read Alternate 2A (extended)
          MC(iCase) = MC(iCase).ReadCardAlt2A(fid);
        end
        if MC(iCase).IVSA == 1  % Read Card 2B
          MC(iCase) = MC(iCase).ReadCard2B(fid);
        end
        if any(MC(iCase).MODEL == [0 7 8]) && MC(iCase).I_RD2C == 1 % Read Card 2C
          MC(iCase) = MC(iCase).ReadCard2C(fid); 
          for iML = 1:MC(iCase).ML % Read CARDs 2C1 through 2C3 (as required) repeated ML times.
            MC(iCase) = MC(iCase).ReadCard2C1(fid, iML);
            if MC(iCase).IRD1 == 1
              MC(iCase) = MC(iCase).ReadCard2C2(fid, iML);
            end
            if MC(iCase).MDEF == 2 && MC(iCase).IRD1 == 1
              MC(iCase) = MC(iCase).ReadCard2C2X(fid, iML);
            end
            if MC(iCase).IRD2 == 1
              MC(iCase) = MC(iCase).ReadCard2C3(fid, iML);
            end
          end
        end % End dealing with cards 2C, 2C1, 2C2, 2C2X and 2C3 
        if MC(iCase).IHAZE == 7 || MC(iCase).ICLD == 11 || strncmpi(MC(iCase).ARUSS, 'USS', 3) % Read card 2D, 2D1 and 2D2
          MC(iCase) = MC(iCase).ReadCard2D(fid);
          for iNREG = 1:4 % Run through the aerosol regions
            if MC(iCase).IREG(iNREG) ~= 0 % Only read data for a region if IREG non-zero
              MC(iCase) = MC(iCase).ReadCard2D1(fid, iNREG);
              if strncmpi(MC(iCase).ARUSS, 'USS', 3) && (MC(iCase).IREG(iNREG) > 1)   % Read one format for Card 2D2 
                                                                            % See Appendix A, user-supplied aerosol parameters
                MC(iCase) = MC(iCase).ReadCard2D2(fid, iNREG, MC(iCase).IREG(iNREG)); % Read IREG(N) sets of 4 numbers
              else % Read another format for Card 2D2 - Regular format
                MC(iCase) = MC(iCase).ReadCard2D2(fid, iNREG, 47);  % Read 47 sets of 4 numbers
              end
            end
          end
        end
        if any(MC(iCase).ICLD == 1:10) && MC(iCase).NCRALT >= 3 % Read Card 2E1 NCRALT times
          for iNCRALT = 1:MC(iCase).NCRALT  % Read a copy of card 2E1 for each altitude
            MC(iCase) = MC(iCase).ReadCard2E1(fid, iNCRALT);
          end
        end
        if any(MC(iCase).ICLD == 1:10) && MC(iCase).NCRSPC >= 2 % Read Card 2E2 NCRSPC times
          for iNCRSPC = MC(iCase).NCRSPC
            MC(iCase) = MC(iCase).ReadCard2E2(fid, iNCRSPC);
          end
        end
        %% Card 3 - Line of Sight Geometry 
        MC(iCase) = MC(iCase).ReadCard3Series(fid);
        %% Spectral Range and Resolution
        MC(iCase) = MC(iCase).ReadCard4(fid); % Card 4 is compulsory
        MC(iCase) = MC(iCase).ReadCard4Ato4L2(fid); % Read subsidiary 4 series cards as required
        %% More cases in the file or terminate MODTRAN
        MC(iCase) = MC(iCase).ReadCard5(fid); % Card 5 is also compulsory
        % if IRPT is blank or empty, MODTRAN will terminate
        FileFinished = (isempty(MC(iCase).IRPT) || MC(iCase).IRPT == 0);
        while ~FileFinished
          iCase = iCase + 1;
          switch abs(MC(iCase - 1).IRPT)
            case 1 % Read complete new set of cards
              break; % Read from Card 1 again (entirely new case)
            case 3 % Copy previous case and read subset of cards
              MC(iCase) = MC(iCase - 1);
              MC(iCase).CaseName = theCaseName;
              MC(iCase).CaseIndex = iCase;
              % Read full 3 series, subsidiary 4-series
              MC(iCase) = MC(iCase).ReadCard3Series(fid);
              MC(iCase) = MC(iCase).ReadCard4Ato4L2(fid);
            case 4 % Copy previous case and read subset of cards
              MC(iCase) = MC(iCase - 1);
              MC(iCase).CaseName = theCaseName;
              MC(iCase).CaseIndex = iCase;
              % Read full 4-series as required
              MC(iCase) = MC(iCase).ReadCard4(fid); % Read card 4 as well
              MC(iCase) = MC(iCase).ReadCard4Ato4L2(fid);
            otherwise
            error('Mod5:BadIRPT','Invalid value of IRPT encountered at end of case. File read format is probably out of alignment.')
          end
          MC(iCase) = MC(iCase).ReadCard5(fid); % Read Card 5 again
          FileFinished = (isempty(MC(iCase).IRPT) || MC(iCase).IRPT == 0);          
        end
       end
       % If it is STILL not end of file, read the remainder of the file into the case long description for all existing sub-cases
       LongDescription = '';
       while ~feof(fid)
         lin = fgets(fid);
         LongDescription = [LongDescription lin];
       end
       for iCase = 1:numel(MC)
         MC(iCase).LongDescr = LongDescription;
       end
       fclose(fid);
      catch FileReadFailed
         fclose(fid);
         rethrow(FileReadFailed);
      end

    end % function Mod5 (Constructor)
    function Success = Write(MC, Filename)
    % Write : Writes a MODTRAN case to a .ltn or .tp5 case file
    %
    % Usage :
    %   Success = MyMod5.Write(Filename)
    %
    %   The case MyMod5 is written to the file Filename. If the
    %   parameter Filename is omitted or empty, a file/save dialog is
    %   presented.
    %
    % Success is a flag that is returned as 1 if the file was written
    % successfuly.
    %
    % See Also : Mod5 (constructor function to read .tp5 or .ltn)
    %
    
      %% Check output filename and open
      if ~exist('Filename', 'var') || isempty(Filename)
          MODTRANPath = '';
          % Check for default case directory
          Direc = fileparts(which('Mod5.m'));
          if exist([Direc '\MODTRANExe.mat'], 'file');
            load([Direc '\MODTRANExe.mat']);
          end
        
          % Use dialog
          if isempty(MODTRANPath)
            [Filename, Pathname] = uiputfile({'*.ltn', 'MODTRAN Case File (*.ltn)';...
                                              '*.tp5', 'MODTRAN Case File (*.tp5)'},'Write MODTRAN Case File');
          else
            [Filename, Pathname] = uiputfile({'*.ltn', 'MODTRAN Case File (*.ltn)';...
                                              '*.tp5', 'MODTRAN Case File (*.tp5)'},'Write MODTRAN Case File', MODTRANPath);
            
          end
          if Filename
            Filename = [Pathname Filename];
          else
            Success = 0;
            return;
          end  
      end
     assert(ischar(Filename), 'Mod5:FilenameNotString', 'Input Filename must be a string.');
     fid = fopen(Filename, 'wt');
     % Write the cards in batches, very much as they were read. The logic
     % for reading is essentially the same as for writing, except the WriteCard ...
     % functions are called instead.
      Success = 0;
      iCase = 1; % Count the cases in the file
      FileFinished = 0;
      try % to write the .ltn file
       while ~FileFinished  % Write any number of cases from a single file 
        MC(iCase).OriginFile = Filename;
        %% Cards 1 and 1A - Main Radiative Transport Driver
        MC(iCase) = MC(iCase).WriteCard1(fid); 
        MC(iCase) = MC(iCase).WriteCard1A(fid);
        %% Cards 1A1, 1A2 and 1A3 - Spectral Data and Sensor Response Function Files
        if strcmpi(MC(iCase).LSUNFL, 'T') % Write card 1A1
          MC(iCase) = MC(iCase).WriteCard1A1(fid);
        end
        if any(MC(iCase).LBMNAM == 'Tt42') % Write card 1A2
          MC(iCase) = MC(iCase).WriteCard1A2(fid);  % The whole line
        end
        if strcmpi(MC(iCase).LFLTNM, 'T') % Write card 1A3
          MC(iCase) = MC(iCase).WriteCard1A3(fid);  % The whole line
        end
        % Card 1A4 - the data directory
        if strcmpi(MC(iCase).CDTDIR, 'T') % Write card 1A4
          MC(iCase) = MC(iCase).WriteCard1A4(fid);  % The whole line
        end
        
        %% Card 2 - Main Aerosol and Cloud Options
        MC(iCase) = MC(iCase).WriteCard2(fid);
        if strcmp(MC(iCase).APLUS, 'A+') % Write card 2A+ Flexible aerosol Model
          MC(iCase) = MC(iCase).WriteCard2APlus(fid);
        end
        if MC(iCase).ICLD == 18 || MC(iCase).ICLD == 19 % Write card 2A
          MC(iCase) = MC(iCase).WriteCard2A(fid);
        end
        if any(MC(iCase).ICLD == 1:10)  % Write Alternate 2A (extended)
          MC(iCase) = MC(iCase).WriteCardAlt2A(fid);
        end
        if MC(iCase).IVSA == 1  % Write Card 2B
          MC(iCase) = MC(iCase).WriteCard2B(fid);
        end
        if any(MC(iCase).MODEL == [0 7 8]) && MC(iCase).I_RD2C == 1 % Write Card 2C
          MC(iCase) = MC(iCase).WriteCard2C(fid); 
          for iML = 1:MC(iCase).ML % Write CARDs 2C1 through 2C3 (as required) repeated ML times.
            MC(iCase) = MC(iCase).WriteCard2C1(fid, iML);
            if MC(iCase).IRD1 == 1
              MC(iCase) = MC(iCase).WriteCard2C2(fid, iML);
            end
            if MC(iCase).MDEF == 2 && MC(iCase).IRD1 == 1
              MC(iCase) = MC(iCase).WriteCard2C2X(fid, iML);
            end
            if MC(iCase).IRD2 == 1
              MC(iCase) = MC(iCase).WriteCard2C3(fid, iML);
            end
          end
        end % End dealing with cards 2C, 2C1, 2C2, 2C2X and 2C3 
        
        if MC(iCase).IHAZE == 7 || MC(iCase).ICLD == 11 || strncmpi(MC(iCase).ARUSS, 'USS', 3) % Write card 2D, 2D1 and 2D2
          MC(iCase) = MC(iCase).WriteCard2D(fid);
          for iNREG = 1:4 % Run through the aerosol regions
            if MC(iCase).IREG(iNREG) ~= 0 % Only read data for a region if IREG non-zero
              MC(iCase) = MC(iCase).WriteCard2D1(fid, iNREG);
              if strncmpi(MC(iCase).ARUSS, 'USS', 3) && (MC(iCase).IREG(iNREG) > 1)   % Write one format for Card 2D2 
                                                                            % See Appendix A, user-supplied aerosol parameters
                MC(iCase) = MC(iCase).WriteCard2D2(fid, iNREG, MC(iCase).IREG(iNREG)); % Write IREG(N) sets of 4 numbers
              else % Write another format for Card 2D2 - Regular format
                MC(iCase) = MC(iCase).WriteCard2D2(fid, iNREG, 47);  % Write 47 sets of 4 numbers
              end
            end
          end
        end
        
        if any(MC(iCase).ICLD == 1:10) && MC(iCase).NCRALT >= 3 % Write Card 2E1 NCRALT times
          for iNCRALT = 1:MC(iCase).NCRALT  % Write a copy of card 2E1 for each altitude
            MC(iCase) = MC(iCase).WriteCard2E1(fid, iNCRALT);
          end
        end
        if any(MC(iCase).ICLD == 1:10) && MC(iCase).NCRSPC >= 2 % Write Card 2E2 NCRSPC times
          for iNCRSPC = MC(iCase).NCRSPC
            MC(iCase) = MC(iCase).WriteCard2E2(fid, iNCRSPC);
          end
        end
        
        %% Card 3 - Line of Sight Geometry 
        MC(iCase) = MC(iCase).WriteCard3Series(fid);
        
        %% Spectral Range and Resolution
        MC(iCase) = MC(iCase).WriteCard4(fid); % Card 4 is compulsory
        MC(iCase) = MC(iCase).WriteCard4Ato4L2(fid); % Write subsidiary 4 series cards as required
        %% More cases in the file or terminate MODTRAN
        MC(iCase) = MC(iCase).WriteCard5(fid); % Card 5 is also compulsory
        % if IRPT is blank or empty, MODTRAN will terminate
        FileFinished = (isempty(MC(iCase).IRPT) || MC(iCase).IRPT == 0);
        while ~FileFinished
          iCase = iCase + 1;
          switch abs(MC(iCase - 1).IRPT)
            case 1 % Write complete new set of cards
              break; % Write from Card 1 again (entirely new case)
            case 3 % Write subset of cards
              % Write full 3 series, subsidiary 4-series
              MC(iCase) = MC(iCase).WriteCard3Series(fid);
              MC(iCase) = MC(iCase).WriteCard4Ato4L2(fid);
            case 4 % Write subset of cards
              % Write full 4-series as required
              MC(iCase) = MC(iCase).WriteCard4(fid); % Write card 4 as well
              MC(iCase) = MC(iCase).WriteCard4Ato4L2(fid);
            otherwise
            error('Mod5:BadIRPT','Invalid value of IRPT encountered at end of case. File read format is probably out of alignment.')
          end
          MC(iCase) = MC(iCase).WriteCard5(fid); % WRITE Card 5 again
          FileFinished = (isempty(MC(iCase).IRPT) || MC(iCase).IRPT == 0);
        end
       end

       fclose(fid);
       Success = 1;
     catch ltnFileWriteFailed
       fclose(fid);
       Success = 0;
       rethrow(ltnFileWriteFailed);
     end
    
    end % Write MODTRAN Case
    function Success = Describe(MC, Filename)
      % Describe : Produce a description of the Mod5 for various purposes
      %
      % This function is not yet completed and requires much work.
      % It does not work on multiple cases. For now, pass in a
      % scalar Mod5.
      %
      %  Usage :
      %   MC = MC.Describe(Filename);
      %
      % Where Filename is the file to which to write the script. If File
      % is missing or empty, a file/save dialog will be presented. If
      % Filename is the number 1, the script will be written in plain
      % text to the screen (standard output).
      % 
      % For a crude, but more complete script describing a case see
      %   the method Script. Script can handle multiple sub-case
      %   instances.
      %
      
      %% Input Checking
      Success = 0;
      assert(isscalar(MC), 'Mod5:Describe:OnlyScalarMod5',...
        'The Describe function (method) currently only works with scalar Mod5''s ');
      % Check output filename and open
      if ~exist('Filename', 'var') || isempty(Filename)
          MODTRANPath = '';
          % Check for default case directory
          Direc = fileparts(which('Mod5.m'));
          if exist([Direc '\MODTRANExe.mat'], 'file');
            load([Direc '\MODTRANExe.mat']);
          end
        
          % Use dialog
          if isempty(MODTRANPath)
            [Filename, Pathname] = uiputfile({'*.m', 'MODTRAN Case Description Script (*.m)'; ...
                                 '*.txt', 'MODTRAN Case Description (*.txt)'},'Write MODTRAN Case Description');
          else
            [Filename, Pathname] = uiputfile({'*.m', 'MODTRAN Case Description Script (*.m)'; ...
                                 '*.txt', 'MODTRAN Case Description (*.txt)'},'Write MODTRAN Case Description', MODTRANPath);
          end
          if Filename
            Filename = [Pathname Filename];
          else
            Success = 0;
            return;
          end  
      end
     if isnumeric(Filename) && Filename == 1
       fid = 1;
       OFormat = 'm';
     else
       assert(ischar(Filename), 'Mod5:Describe:FilenameNotString', 'Input Filename must be a string.');
       fid = fopen(Filename, 'wt');
       [pathstr, name, Ext] = fileparts(Filename);
       switch Ext
         case {'.htm','.html'}
           OFormat = 'htm';
         case '.tex'
           OFormat = 'tex';
         case '.txt'
           OFormat = 'txt';
         case '.m'
           OFormat = 'm';
         otherwise
           error('Mod5:Describe:BadFormat', 'Unknown format %s was specified. Known formats are .m .txt .htm .html and .tex.', Ext);
       end
     end
      
      Success = 0;
      iCase = 1; % Count the cases in the file
      FileFinished = 0;

      try % to perform the Describe processing
       while ~FileFinished  % Describe any number of cases from a single file
        if iCase > numel(MC) % Have overrun the case count somehow (probably bad value of IRPT)
          break;
        end
        % Print the preamble to the case description
        MC(iCase).printPreCase(fid, OFormat);
        
        %% Cards 1 and 1A - Main Radiative Transport Driver
        MC(iCase) = MC(iCase).DescribeCard1(fid, OFormat); 
        MC(iCase) = MC(iCase).DescribeCard1A(fid, OFormat);
        %% Cards 1A1, 1A2 and 1A3 - Spectral Data and Sensor Response Function Files
        if strcmpi(MC(iCase).LSUNFL, 'T') % Describe card 1A1
          MC(iCase) = MC(iCase).DescribeCard1A1(fid, OFormat);
        end
        if any(MC(iCase).LBMNAM == 'Tt42') % Describe card 1A2
          MC(iCase) = MC(iCase).DescribeCard1A2(fid, OFormat);  % The whole line
        end
        if strcmpi(MC(iCase).LFLTNM, 'T') % Describe card 1A3
          MC(iCase) = MC(iCase).DescribeCard1A3(fid, OFormat);  % The whole line
        end
        % Card 1A4 - the data directory
        if strcmpi(MC(iCase).CDTDIR, 'T') % Describe card 1A4
          MC(iCase) = MC(iCase).DescribeCard1A4(fid, OFormat);  % The whole line
        end
        
        %% Card 2 - Main Aerosol and Cloud Options
        % MC(iCase) = MC(iCase).DescribeCard2(fid);
        if strcmp(MC(iCase).APLUS, 'A+') % Describe card 2A+ Flexible aerosol Model
          % MC(iCase) = MC(iCase).DescribeCard2APlus(fid);
        end
        if MC(iCase).ICLD == 18 || MC(iCase).ICLD == 19 % Describe card 2A
          % MC(iCase) = MC(iCase).DescribeCard2A(fid);
        end
        if any(MC(iCase).ICLD == 1:10)  % Describe Alternate 2A (extended)
          % MC(iCase) = MC(iCase).DescribeCardAlt2A(fid);
        end
        if MC(iCase).IVSA == 1  % Describe Card 2B
          % MC(iCase) = MC(iCase).DescribeCard2B(fid);
        end
        if any(MC(iCase).MODEL == [0 7 8]) && MC(iCase).I_RD2C == 1 % Describe Card 2C
          % MC(iCase) = MC(iCase).DescribeCard2C(fid); 
          for iML = 1:MC(iCase).ML % Describe CARDs 2C1 through 2C3 (as required) repeated ML times.
            % MC(iCase) = MC(iCase).DescribeCard2C1(fid, iML);
            if MC(iCase).IRD1 == 1
              % MC(iCase) = MC(iCase).DescribeCard2C2(fid, iML);
            end
            if MC(iCase).MDEF == 2 && MC(iCase).IRD1 == 1
              % MC(iCase) = MC(iCase).DescribeCard2C2X(fid, iML);
            end
            if MC(iCase).IRD2 == 1
              % MC(iCase) = MC(iCase).DescribeCard2C3(fid, iML);
            end
          end
        end % End dealing with cards 2C, 2C1, 2C2, 2C2X and 2C3 
        
        if MC(iCase).IHAZE == 7 || MC(iCase).ICLD == 11 || strncmpi(MC(iCase).ARUSS, 'USS', 3) % Describe card 2D, 2D1 and 2D2
          % MC(iCase) = MC(iCase).DescribeCard2D(fid);
          for iNREG = 1:4 % Run through the aerosol regions
            if MC(iCase).IREG(iNREG) ~= 0 % Only read data for a region if IREG non-zero
              % MC(iCase) = MC(iCase).DescribeCard2D1(fid, iNREG);
              if strncmpi(MC(iCase).ARUSS, 'USS', 3) && (MC(iCase).IREG(iNREG) > 1)   % Describe one format for Card 2D2 
                                                                            % See Appendix A, user-supplied aerosol parameters
                % MC(iCase) = MC(iCase).DescribeCard2D2(fid, iNREG, MC(iCase).IREG(iNREG)); % Describe IREG(N) sets of 4 numbers
              else % Describe another format for Card 2D2 - Regular format
                % MC(iCase) = MC(iCase).DescribeCard2D2(fid, iNREG, 47);  % Describe 47 sets of 4 numbers
              end
            end
          end
        end
        
        if any(MC(iCase).ICLD == 1:10) && MC(iCase).NCRALT >= 3 % Describe Card 2E1 NCRALT times
          for iNCRALT = 1:MC(iCase).NCRALT  % Describe a copy of card 2E1 for each altitude
            % MC(iCase) = MC(iCase).DescribeCard2E1(fid, iNCRALT);
          end
        end
        if any(MC(iCase).ICLD == 1:10) && MC(iCase).NCRSPC >= 2 % Describe Card 2E2 NCRSPC times
          for iNCRSPC = MC(iCase).NCRSPC
            % MC(iCase) = MC(iCase).DescribeCard2E2(fid, iNCRSPC);
          end
        end
        
        %% Card 3 - Line of Sight Geometry 
        MC(iCase) = MC(iCase).DescribeCard3Series(fid, OFormat);
        
        %% Spectral Range and Resolution
        MC(iCase) = MC(iCase).DescribeCard4(fid, OFormat); % Card 4 is compulsory
        % MC(iCase) = MC(iCase).DescribeCard4Ato4L2(fid); % Describe subsidiary 4 series cards as required
        %% More cases in the file or terminate MODTRAN
        MC(iCase) = MC(iCase).DescribeCard5(fid, OFormat); % Card 5 is also compulsory
        % if IRPT is blank or empty, MODTRAN will terminate
        FileFinished = (isempty(MC(iCase).IRPT) || MC(iCase).IRPT == 0);
        while ~FileFinished
          iCase = iCase + 1;
          switch abs(MC(iCase - 1).IRPT)
            case 1 % Describe complete new set of cards
              break; % Describe from Card 1 again (entirely new case)
            case 3 % Copy previous case and read subset of cards
              MC(iCase) = MC(iCase - 1);
              % Describe full 3 series, subsidiary 4-series
              % MC(iCase) = MC(iCase).DescribeCard3Series(fid);
              % MC(iCase) = MC(iCase).DescribeCard4Ato4L2(fid);
            case 4 % Copy previous case and read subset of cards
              MC(iCase) = MC(iCase - 1);
              % Describe full 4-series as required
              % MC(iCase) = MC(iCase).DescribeCard4(fid); % Describe card 4 as well
              % MC(iCase) = MC(iCase).DescribeCard4Ato4L2(fid);
              
            otherwise
            error('Mod5:BadIRPT','Invalid value of IRPT encountered at end of case. File read format is probably out of alignment.')
          end
          % MC(iCase) = MC(iCase).DescribeCard5(fid); % WRITE Card 5 again  
        end
       end
       if fid ~= 1
        fclose(fid);
       end
       % Wrap up the Do
       Success = 1;
     catch DescribeFailed
       if fid ~= 1
         fclose(fid);
       end
       % Clean up the Do
       Success = 0;
       rethrow(DescribeFailed);
     end
    
    end % Describe
    function Success = Script(MC, Filename, PrintEmpty)
      % Script : Create a crude script describing a Mod5
      %
      % This function generates a very crude .m file containing
      % a Mod5 definition in Matlab script format.
      %
      % Usage :
      %
      %  Success = MC.Script;   % File/save dialog is presented
      %   Or
      %  Success = MC.Script(Filename);  % Save script to given file
      %   Or
      %  Success = MC.Script(Filename, PrintEmpty)
      %
      % Where
      %  Filename is the name of the file to which to write the
      %  script. If input Filename is missing or empty, a file
      %  open dialog is presented. If Filename is specified as the
      %  number 1, output is sent to standard output (screen).
      %
      %  If the parameter PrintEmpty is given and is non-zero, then all empty
      %  MODTRAN fields are printed as well.
      %
      %  Ultimately, the method Describe should do a better job of
      %  this.
      %
      % Bugs:
      %  MODTRAN parameters having more than 2 dimensions (e.g.
      %    the user-defined aerosol phase function F) will
      %    not be correctly handled by this function.
      
      %% Check output filename and open
      if ~exist('Filename', 'var') || isempty(Filename)
          MODTRANPath = '';
          % Check for default case directory
          Direc = fileparts(which('Mod5.m'));
          if exist([Direc '\MODTRANExe.mat'], 'file');
            load([Direc '\MODTRANExe.mat']);
          end
        
          % Use dialog
          if isempty(MODTRANPath)
            [Filename, Pathname] = uiputfile({'*.m', 'MODTRAN Case Description Script (*.m)'; ...
                                 '*.txt', 'MODTRAN Case Description (*.txt)'},'Write MODTRAN Case Description');
          else
            [Filename, Pathname] = uiputfile({'*.m', 'MODTRAN Case Description Script (*.m)'; ...
                                 '*.txt', 'MODTRAN Case Description (*.txt)'},'Write MODTRAN Case Description', MODTRANPath);
          end
          if Filename
            Filename = [Pathname Filename];
          else
            Success = 0;
            return;
          end  
      end
     if isnumeric(Filename) && Filename == 1
       fid = 1;
     else
       assert(ischar(Filename), 'Mod5:Script:FilenameNotString', 'Input Filename must be a string.');
       fid = fopen(Filename, 'wt');
     end
     if ~exist('PrintEmpty', 'var')
       PrintEmpty = 0;
     else
       assert(isscalar(PrintEmpty) && isnumeric(PrintEmpty), 'Mod5:Script:BadPrintEmpty', ...
         'Input PrintEmpty must be a scalar logical (numeric).');
     end
     try
       for iC = 1:numel(MC)
         MC(iC).printPreCase(fid, 'm'); % Put in some header stuff
         % Get an empty Mod5
         fprintf(fid, '%s(%d) = Mod5;\n', genvarname(MC(iC).CaseName), iC);
         fprintf(fid, '%s(%d).CaseName = ''%s'';\n', genvarname(MC(iC).CaseName), iC, MC(iC).CaseName);
         fprintf(fid, '%s(%d).CaseIndex = %i;\n', genvarname(MC(iC).CaseName), iC, iC);
         % Obtain a display text version of the case
         Distex = evalc('disp(MC(iC))');
         % Perform processing on Distex
         % For now, tokenise at linefeeds and look for colons
         [tok, rem] = strtok(Distex, char(10));
         while ~isempty(tok)
           if ~isempty(strfind(tok, ':'))
             [lhs, rhs] = strtok(tok, ':');
             lhs = strtrim(lhs);
             if strcmp(lhs, upper(lhs)) % Isolate MODTRAN parameters, which are upper case
               rhs = strtrim(rhs(2:end)); % get the rhs of the equation
               % scan the rhs for the copout format
               coptok = regexp(rhs,'^\[(\d+)x(\d+)\s(\w+)\]$','tokens');
               if isempty(coptok)
                 if ~strcmp(rhs,'[]') || PrintEmpty
                   fprintf(fid, '%s(%d).%s = %s;\n', genvarname(MC(iC).CaseName), iC, lhs, rhs);
                 end
               else % copout format [ROWSxCOLS class] was encountered
                 nRows = str2double(coptok{1}{1});
                 nCols = str2double(coptok{1}{2});
                 TheClass = coptok{1}{3};
                 fprintf(fid, '%s(%d).%s = [ ...\n', MC(iC).CaseName, iC, lhs);
                 switch TheClass % Handle only doubles and chars
                   case 'double'
                     for iRow = 1:nRows
                       for iCol = 1:nCols
                         fprintf(fid, ' %g', MC(iC).(lhs)(iRow, iCol));
                       end
                       fprintf(fid, '; ...\n');
                     end
                   case 'char'
                     for iRow = 1:nRows
                       fprintf(fid, ' ''%s''; ...\n', MC(iC).(lhs)(iRow, :));
                     end
                 end
                 fprintf(fid, ']; %% End data for parameter %s\n', lhs);
               end
             end
           end
           [tok, rem] = strtok(rem, char(10));
         end
       end
       if fid ~= 1
         fclose(fid);
       end
       Success = 1;
     catch ScriptingFailed
       if fid ~= 1
         fclose(fid);
       end
       rethrow(ScriptingFailed);
     end
      
    end % Script (produce Matlab script)
    function MODCase = Run(MODCase, PlotFlag)
      % Run : Run MODTRAN Cases and retrieve results immediately
      %
      % Usage :
      %
      %   MyCase = MyCase.Run;
      %
      %      Or
      %
      %   MyCase = MyCase.Run(PlotFlag)
      %
      % Where :
      %   MODCase is the class instance read from a .ltn file using the
      %   Mod5 constructor (or created from scratch).
      %
      %   MODTRAN can be made to write plot data to .plt and .psc files
      %   by setting YFLAG and XFLAG on Card 4. See the MODTRAN manual
      %   for details. This is not necessary to obtain plots. Plotting
      %   is possible of all outputs after the run has been completed.
      %   See methods such as Mod5.Plot and Mod5.PlotChn.
      %
      %   PlotFlag determines whether or not the plot data for the run is
      %   plotted. If PlotFlag is set to zero, no plot data is read. If
      %   PlotFlag is set to 1, plot data is read, but not plotted. If
      %   PlotFlag is set to 2, plot data is read and the convolved plot
      %   data (.psc) data is plotted. 
      %   If PlotFlag is set to 3, only the unconvolved data is plotted (.plt).
      %   If PlotFlag is set to 4, both convolved and unconvolved data are
      %   plotted.
      %   One plot is produced for each relevant subcase. 
      %   The subcase description is used as the plot title if not empty, 
      %   otherwise the sub-case name is used for the title.
      %
      %   Executing the method Run on a Mod5 writes out a .tp5 case
      %   to the directory containing the MODTRAN executable (see method
      %   SetMODTRANExe) and runs MODTRAN. Once MODTRAN terminates, several
      %   of the MODTRAN output files are processed, and the results
      %   incorporated into the case instance. The fields in the Mod5
      %   that are populated include the following:
      %       .tp7 - These are fields read from the .tp7 (tape7) file.
      %       .sc7 - These are fields read from the .7sc (tape7.scn) file.
      %       .plt - If PlotFlag is non-zero, these results are read from
      %              the .plt (plotout) file (unconvolved plot data).
      %       .psc - If PlotFlag is non-zero, these results are read from
      %              the .psc (plotout.scn) file. (convolved plot data).
      %       .chn - Spectral channel outputs. MODTRAN produces a .chn file
      %              if a set of spectral channel filters are specified in
      %              the parameter FILTNM (and flagged as present in the
      %              logical input LFLTNM).
      %
      %
      % Note:
      %  If the input instance is not scalar, the multiple cases will not
      %  all be run by MODTRAN, unless the IRPT flag is correctly set at
      %  the end of the previous case. If any case has IRPT set to blank
      %  or zero, subsequent cases will not be run.
      %
      %  Results from the file7 output will be distributed to the cases in
      %  the same order as in the class instance. If the Mod5 is a
      %  matrix, the sub-cases are run in columnwise order.
      %
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
      
      if exist('PlotFlag', 'var')
        assert((isnumeric(PlotFlag) && isscalar(PlotFlag) && any(PlotFlag == [0 1 2 3 4])), ...
          'Mod5:Run:BadPlotFlag','Input PlotFlag must be 0, 1 or 2.');
      else
        PlotFlag = 1; % Plot data is read but not plotted
      end
      %% Setup and run the case
      % First write the file mod5root.in in the MODTRANPath
      
      modrootfid = fopen([MODTRANPath 'mod5root.in'], 'wt');
      try
        fprintf(modrootfid, '%s\n', MODCase(1).CaseName);
        fclose(modrootfid);
      catch modrootFailed
        fclose(modrootfid);
        rethrow(modrootFailed);
      end
      try % to delete all output files associated with this run
        delete([MODTRANPath MODCase(1).CaseName '.*']);
      catch
        warning('Mod5:Run:PurgeFailed', ...
          'Unable to purge all MODTRAN output files (%s.*) associated with this case. Check status of these files.', ...
          [MODTRANPath MODCase(1).CaseName]);
      end
      % Write the case to the file modroot.tp5
      Success = MODCase.Write([MODTRANPath MODCase(1).CaseName '.tp5']);
      if Success
        % Go ahead and run MODTRAN
        CurrentDir = pwd;
        try
          cd(MODTRANPath);
          % Look at sub-cases and write the filter file if attached
          for iCase = 1:numel(MODCase)
            if ~isempty(MODCase(iCase).flt)
              Success = Mod5.WriteFlt(MODCase(iCase).flt, MODCase(iCase).FILTNM);
              if ~Success % Issue a warning that the filter write operation might have failed
                warning('Mod5:Run:WriteFltFailed', ...
                  'Writing of channel filter file %s seems to have failed.', MODCase(iCase).FILTNM);
              end
            end
          end
          % Look at sub-cases and write the albedo file if there is albedo data
          for iCase = 1:numel(MODCase)
            if ~isempty(MODCase(iCase).alb)
              Success = Mod5.WriteAlb(MODCase(iCase).alb, MODCase(iCase).SALBFL);
              if ~Success % Issue a warning that the albedo write operation might have failed
                warning('Mod5:Run:WriteAlbFailed', ...
                  'Writing of albedo data to file %s seems to have failed.', MODCase(iCase).SALBFL);
              end
            end
          end
          % Submit job to MODTRAN
          MODCase(1).RunStartSerTime = now;  % Record start date/time of run
          StartTime = tic;
          [tMODStatus, tMODSays] = system(MODTRANExe);
          MODCase(1).RunDuration = toc(StartTime);
          MODCase(1).RunEndSerTime = now;
          MODCase(1).RunStartTime = datestr(MODCase(1).RunStartSerTime);
          MODCase(1).RunEndTime = datestr(MODCase(1).RunEndSerTime);
          % Check result string - there should be the characters '100.0 %' in the last few
          if ~isempty(tMODSays) && isempty(strfind(tMODSays(end-25:end), 'Completed:'))
            warning('Mod5:Run:MODTRANTerminationSuspect', 'MODTRAN may have terminated abnormally.\n%s', tMODSays);
          end
          % Presumably all cases completed, not sure how to verify this besides analysing tape6
          for iCase = 1:numel(MODCase) % This needs rethinking - what really is the status of the individual cases
            MODCase(iCase).MODStatus = tMODStatus;
            if iCase == 1
              MODCase(iCase).MODSays = tMODSays;
            else
              MODCase(iCase).MODSays = 'See Sub-case 1.'; % Save some memory
            end
            MODCase(iCase).tp6 = [];     % Clear all the outputs
            MODCase(iCase).tp7 = [];     % tape7 or .tp7 file outputs for this sub-case, full spectral resolution
            MODCase(iCase).sc7 = [];     % tape7.scn or .7sc output for this sub-case (filtered to reduced spectral resolution)
            MODCase(iCase).plt = [];     % Plot file, full spectral resolution, rather use data taken from tp7 or sc7
            MODCase(iCase).psc = [];     % Plot file, filtered to reduced spectral resolution
            MODCase(iCase).tp8 = [];     % Tape 8 outputs            
            MODCase(iCase).chn = [];     % Spectral channel computations for computing band radiance
            MODCase(iCase).flx = [];     % Spectral flux calculations (big - don't specify this for nothing)
            MODCase(iCase).clr = [];     % Cooling rates.
            if iCase > 1 % Make run times for those cases the same ?
              MODCase(iCase).RunStartSerTime = MODCase(1).RunStartSerTime;
              MODCase(iCase).RunDuration = MODCase(1).RunDuration;
              MODCase(iCase).RunEndSerTime = MODCase(1).RunEndSerTime;
              MODCase(iCase).RunStartTime = MODCase(1).RunStartTime;
              MODCase(iCase).RunEndTime = MODCase(1).RunEndTime;
            end
          end
          % Move the file mod5root.in because it has a devastating effect on PcModWin if that is installed
          % PcModWin RUNS THE WRONG CASE if mod5root.in exists, because PCModWin writes to tape5, but MODTRAN
          % ignores that and uses the file root in mod5root.in instead.
          [MoveSuccess, MoveMessage, MoveMessageID] = movefile([MODTRANPath 'mod5root.in'],[MODTRANPath 'Lastmod5root.in'],'f');
          if ~MoveSuccess && exist([MODTRANPath 'mod5root.in'], 'file')
            warning('Mod5_Run:mod5rootFileExists', ...
              'The file %smod5root.in exists and this will cause PcModWin (if in use) to run the wrong case.', MODTRANPath);
          end
          %% Read MODTRAN results
          % An effort should be made to check that MODTRAN terminated normally
          % and that the files generated correspond to the time the run was executed
          % as recorded above. It seems that tape7 or .tp7 is always produced, and
          % these results will be fetched first.
          MODCase = MODCase.ProcessTp7;
          %% Next deal with .7sc the convolved tp7 outputs
          MODCase = MODCase.Process7sc;
          %% Next deal with convolved fluxes in the .flx file if present
          MODCase = MODCase.ProcessFlx;
          %% Next read in and plot the plot data .plt (not convolved) and .psc (convolved)
          % Plot data is a simple 2 column format
          % The selection of radiance or transmittance is determined by the YFLAG
          % The spectral units are determined by the XFLAG
          if PlotFlag % Read in the plot data
            MODCase = MODCase.ProcessPlt;
            MODCase = MODCase.ProcessPsc;
          end
          if PlotFlag > 1
            h = MODCase.Plot(PlotFlag);
          end
          % Process any .chn (spectral channel output) data
          MODCase = MODCase.ProcessChn;
          cd(CurrentDir);
        catch MODTRANError
          cd(CurrentDir); % Change back to current directory prior to run
          rethrow(MODTRANError);
        end
      else
        error('Mod5:Run:CaseFileProblem','Unable to write the case file. Check .tp5 status and permissions.');
      end
    end % function Mod5.Run
    function MC = SetCaseName(MC, NewCaseName)
      % SetCaseName : Set the name of a Mod5, or rename a Mod5
      %
      % Usage :
      %
      %  MC = MC.SetCaseName(NewCaseName);
      %
      % The NewCaseName must be a valid filename. An error will be returned
      %   if it is not a valid filename. For rules concerning valid Windows
      %   filenames, consult the source code for the function
      %   isValidFilename or Google.
      %
      % See Also : ReIndex
      
      for iC = 1:numel(MC)
        if MC(iC).CaseIndex ~= iC
          warning('Mod5:SetCaseName:IndexError', ...
            'The CaseIndex property is out of sync with the element index. You may be attempting to rename a sub-case or the super-case may need ReIndex.');
        end
        MC(iC).CaseName = NewCaseName;
      end
      
    end % SetCaseName
    function MCOut = Extract(MC, iSubCases, NewCaseName)
      % Extract: Extract selected subcases from a Mod5
      %
      % Usage :
      %
      % MySubCaseChoice = MyOldCase(iSubCases); % Select specific sub-cases
      %   Or
      % MySubCaseChoice = MyOldCase(iSubCases, NewCaseName); % Select and rename
      %
      % Example :
      %  MyNewCase = MyMultiCase.Extract(2); % Extracts second sub-case
      %
      %
      
      % Check input
      assert(isnumeric(iSubCases) && all(iSubCases == round(iSubCases)) && all(iSubCases >=1 & iSubCases <= numel(MC)), ...
        'Mod5:Extract:BadIndex','Input indices iSubCases must be numeric, positive, integer and within the number of sub-cases.'); 
      % First extract the sub-cases
      iOut = 1;
      for iC = iSubCases 
       MCOut(iOut) = MC(iC);
       iOut = iOut + 1;
      end
      if exist('NewCaseName', 'var')
        MCOut = MCOut.ReIndex(NewCaseName);
      else
        MCOut = MCOut.ReIndex;
      end
    end % Extract
    function MC = Merge(MC1, MC2, NewCaseName)
      % Merge : Merge two MODTRAN cases into a super-case
      %
      % Merging cases allows then to be run in a single MODTRAN execution.
      %
      % Usage:
      %  SuperCase = Case1.Merge(Case2);
      %   Or
      %  SuperCase = Case1.Merge(Case2, NewCaseName);
      %
      %  Case1 and Case2 are the cases to be merged and SuperCase is 
      %  the result. Merge always returns a row vector, regardless
      %  of the shape of the inputs.
      %
      %  A new case name can be specified using the optional input NewCaseName,
      %   which must be a valid Windows filename and less than 75 characters
      %   in length.
      %
      
      MC = [MC1(:)' MC2(:)']; % Put em all in a row vector
      if exist('NewCaseName', 'var') && ~isempty(NewCaseName)
        MC = MC.ReIndex(NewCaseName);
      else
        MC = MC.ReIndex;
      end
    end % Merge
    function MC = Replicate(MC, TheSize, NewCaseName)
      % Replicate : Replicate a scalar Mod5 to a vector or matrix of sub-cases
      %
      % Usage :
      %   MCReplicated = MC.Replicate(TheSize);
      %     Or
      %   MCReplicated = MC.Replicate(TheSize, NewCaseName);
      %
      % Where the input MC is a Mod5.
      % TheSize is a vector of integers giving the total size of the matrix
      %   of sub-cases to create. The total number of sub-cases that result
      %   will be prod(TheSize).
      %
      % A new case case name can be given by also specifying the input NewCaseName.
      %  The new case name must be less than 75 characters in length and must
      %  also be a valid Windows filename.
      %
      % Warning : Use Replicate rather than repmat on Mod5 instances.
      %   Replicate does some housekeeping that is not done by repmat. The
      %   housekeeping required is to re-index the replicated case, and to
      %   set the IRPT property correctly. Note also that, as with repmat
      %   MC.Replicate(5) produces a 5 by 5 matrix. To get a vector of
      %   5 elements use MC.Replicate([5 1]);
      %
      % Example :
      %   MyScalarCase = Mod5;  % Get an empty case
      %   % Set up the case by setting the properties of the case
      %   % See Mod5Examples for how to do this.
      %   % Then replicate to a 4 by 4 matrix of sub-cases.
      %   MyReplicatedCase = MyScalarCase.Replicate([4 4]);
      % 
      % See Also : ReIndex
      
      %% Do some input checking
      assert(isnumeric(TheSize) && isvector(TheSize) && all(round(TheSize) == TheSize) && all(TheSize) >= 1, 'Mod5:Replicate:BadSize', ...
        'Input TheSize must be a positive integer or vector of positive integers.');
      
      % Seems OK, now do the replication - don't want to 
      MC = repmat(MC, TheSize);
      % Re-index the Mod5
      if exist('NewCaseName', 'var') && ~isempty(NewCaseName)
        MC = MC.ReIndex(NewCaseName);      
      else
        MC = MC.ReIndex; % ReIndex sets IRPT as well
      end
      
    end % Replicate
    function MC = ReIndex(MC, NewCaseName, IRPTFlag)
      % ReIndex : Re-index or rename a Mod5 and set up IRPT property
      %
      % Usage :
      %  MC = MC.ReIndex;
      %
      %   Or
      %
      %  MC = MC.ReIndex(NewCaseName); % Re-index and re-name
      %
      %   Or
      %
      %  MC = MC.ReIndex(NewCaseName, IRPTFlag); % Re-Index, re-name and set IRPT 
      %
      % ReIndex does the following:
      %
      % The CaseIndex property is set to reflect the actual index of
      %   the sub-cases. The IRPT property is set to 1 for all sub-cases,
      %   except the last case, where IRPT is set to zero (stop MODTRAN).
      %
      % If NewCaseName is given, it must be a valid filename, otherwise
      %   an error will be issued. The CaseName property of all sub-cases
      %   is set to the NewCaseName, otherwise the CaseName property of
      %   all sub-cases is set to the CaseName of sub-case 1. Rules for
      %   valid Windows filenames can be discovered by consulting
      %   the source code for the function Mod5.isValidFilename or
      %   by Google.      
      %
      % If the input IRPTFlag is given, the IRPT property of all sub-
      %   cases is set to IRPTFlag, except for the last sub-case, which
      %   is set to 0. Valid IRPTFlag values are ±1, ±2 or ±3. If missing
      %   or empty, IRPTFlag defaults to 1.
      %
      %
      % Warning : Do not rename a case after AttachFlt or AttachAlb has
      %  been used on the Mod5.
      %
      % See Also : Replicate, isValidFilename
      
      
      if exist('IRPTFlag', 'var') && ~isempty(IRPTFlag)
        assert(isnumeric(IRPTFlag) && isscalar (IRPTFlag) && any(abs(IRPTFlag) == [1 2 3]), 'Mod5:ReIndex:BadIRPTFlag',...
          'Input IRPTFlag must be a scalar integer of value -3, -2, -1, 1, 2 or 3.');
      else
        IRPTFlag = 1;
      end
      if exist('NewCaseName', 'var') && ~isempty(NewCaseName)
        assert(ischar(NewCaseName) && numel(NewCaseName) < 75 && Mod5.isValidFilename(NewCaseName), 'Mod5:ReIndex:BadCaseName', ...
          'Input NewCaseName must be a string of less than 75 characters, that is also a valid filename.')
      else
        NewCaseName = MC(1).CaseName;
      end
      for iC = 1:numel(MC)
        MC(iC).CaseIndex = iC;
        MC(iC).IRPT = IRPTFlag;
      end
      MC = MC.SetCaseName(NewCaseName);      
      MC(end).IRPT = 0;
    end % ReIndex
    function Success = Save(MC, Directory)
      % Save : Save MODTRAN run files and Mod5 instance
      %
      % MODTRAN input and output files are written (when the Run method
      %  is executed) to the same directory in which the MODTRAN
      %  executable is located. The Save method described here can
      %  be used to move all the files to another directory.
      %
      % Save will also save a .mat file containing the Mod5
      %  instance. The saved Mod5 will always have the name 'MC'.
      % 
      % Usage :
      %
      %  Success = MyCase.Save(Directory); % Save results to given directory
      %     Or
      %  Success = MyCase.Save; % Save to directory set using SetCasePath
      %     Or
      %  Success = MyCase.Save(''); % Get directory selection dialog
      %
      % Example :
      %   Success = MyCase.Save(pwd) % Save to current working directory
      %
      % See Also : Purge
      
      persistent CaseDirectory MODTRANPath MODTRANExe 
      Success = 0;
      % Deal with the inputs
      if exist('Directory', 'var')
        assert(ischar(Directory), 'Mod5:Save:BadDir','Input Directory must be class char (a string).');
        if isempty(Directory)
          Directory = uigetdir;
          if ~ischar(Directory)
            return;
          end
        end
      else
        if isempty(CaseDirectory)
          Direc = fileparts(which('Mod5.m'));
          if exist([Direc '\Mod5Dir.mat'], 'file');
            load([Direc '\Mod5Dir.mat']);
            Directory = CaseDirectory;
          else
            Directory = pwd; % Use working directory
          end          
        else
          Directory = CaseDirectory;
        end
      end
      % OK, should have a directory after all that
      % Obtain the MODTRAN executable directory
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
      
      % Try to move the files to the directory
      try
        Filespec = [MODTRANPath '\' MC(1).CaseName '.*'];
        if ~isempty(dir(Filespec))
          movefile(Filespec, Directory, 'f');
        end
        Filespec = [MODTRANPath '\' MC(1).CaseName '(*).*'];
        if ~isempty(dir(Filespec))
          movefile(Filespec, Directory, 'f');
        end
        save([Directory '\' MC(1).CaseName '.mat'], 'MC');
        Success = 1;
      catch MoveFailed
        warning('Mod5:Save:SaveFailed','Saving of files for case %s seems to have failed.', MC(1).CaseName);
        Success = 0;
        rethrow(MoveFailed);
      end
      
    end % Save
    function Success = Purge(MC)
      % Purge : Delete MODTRAN output files associated with this case
      %
      % Usage :
      %  Success = MyCase.Purge;
      %
      % Where MC is the case for which to purge the output files.
      % All files of the form [MC(1).CaseName '.*'] are deleted in
      % the MODTRAN executable directory.
      %
      % See Also : Save
      %
      
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
      
      try
        delete([MODTRANPath MC(1).CaseName '.*']);
        Success = 1;
      catch DeleteFailed
        Success = 0;
      end
    end % Purge
    function plothandle = Plot(MODCase, PlotFlag)
      % Mod5.Plot : Plot the data (.psc and .plt) for all sub-cases
      iFig = 0; % Count the number of figures
      plothandle = [];
      if ~exist('PlotFlag', 'var')
        PlotFlag = 4;
      end
      for iCase = 1:numel(MODCase)
        if ~isempty(MODCase(iCase).psc)
          if any(PlotFlag == [2 4]) && ~isempty(MODCase(iCase).psc) % Plot the convolved data
            iFig = iFig + 1;
            plothandle(iFig) = figure;
            plot(MODCase(iCase).psc.(MODCase(iCase).psc.Headers{1}), ...
              MODCase(iCase).psc.(MODCase(iCase).psc.Headers{2}));
            xlabel(strrep(MODCase(iCase).psc.xLabel, 'cm^-1', 'cm^{-1}'));
            ylabel(strrep(MODCase(iCase).psc.yLabel, 'cm^-1', 'cm^{-1}'));
            if isempty(MODCase(iCase).CaseDescr)
              title([MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ') - Convolved']);
            else
              title([MODCase(iCase).CaseDescr '(' num2str(MODCase(iCase).CaseIndex) ') - Convolved']);
            end
            grid;
            legend([MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')'], 'Location', 'best');
          end
        end
        if ~isempty(MODCase(iCase).plt)
          if any(PlotFlag == [3 4]) && ~isempty(MODCase(iCase).plt) % Plot the unconvolved data
            iFig = iFig + 1;
            plothandle(iFig) = figure;
            plot(MODCase(iCase).plt.(MODCase(iCase).plt.Headers{1}), ...
              MODCase(iCase).plt.(MODCase(iCase).plt.Headers{2}));
            xlabel(strrep(MODCase(iCase).plt.xLabel, 'cm^-1', 'cm^{-1}'));
            ylabel(strrep(MODCase(iCase).plt.yLabel, 'cm^-1', 'cm^{-1}'));
            if isempty(MODCase(iCase).CaseDescr)
              title([MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')']);
            else
              title(MODCase(iCase).CaseDescr);
            end
            grid;
            legend([MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')'], 'Location', 'best');
          end
        end
      end
    end % Plot
    function plothandle = PlotTp7(MODCase, PlotWhat, SubCases)
      % PlotTp7: Plots data from .tp7 (tape 7) file, stored in MODCase
      %
      % Usage :
      %   plothandle = MODCase.PlotTp7(PlotWhat, SubCases)
      %     Or
      %   plothandle = MODCase.PlotTp7(PlotWhat)
      %
      % Where:
      %   MODCase is the Mod5 from which to plot the data.
      %
      %   PlotWhat is a cell array of strings giving the (fixed) header names
      %     of the data columns in the tp7 structure to plot. To
      %     determine which header names are available for a specific case,
      %     look at the property MyMod5(iSubCase).tp7.Headers.
      %     If PlotWhat is a string (rather than a cell array of strings)
      %     all sub-cases are plotted on a single plot, otherwise each
      %     sub-case will have a seperate plot. If PlotWhat is omitted
      %     or specified as {'ALL'}, all data is plotted.
      %
      %   SubCases allows selection of individual subcases (vector) of
      %     sub-case numbers. If omitted or given as empty, [], 
      %     all sub-cases are plotted, each in an individual plot. 
      %
      %   If the sub-case being plotted has a description (CaseDescr property),
      %     it will be used for the plot title. If not, the CaseName property
      %     will be used. The legends on the plot will correspond to the
      %     Headers by default.
      %
      %   The returned parameter plothandles is a vector of handles to the
      %     plots generated. 

      % Verify inputs
      if exist('SubCases', 'var') && ~isempty(SubCases)
        assert(isnumeric(SubCases) && isvector(SubCases) && all(round(SubCases) == SubCases) && ...
               min(SubCases) >= 1 && max(SubCases) <= numel(MODCase), ...
        'Mod5:PlotTp7:BadCaseIndices','Input SubCases must be vector, integer and within range of the size of the Mod5.');
      else
        SubCases = 1:numel(MODCase); % row vector -> seperate plots for every sub-case
      end
      if exist('PlotWhat', 'var') && ~isempty(PlotWhat)
        assert(ischar(PlotWhat) || iscellstr(PlotWhat), 'Mod5:PlotTp7:BadPlotReq','Input PlotWhat must be a string or cell array of string headers.');
      else
        PlotWhat = {'ALL'};  % Plot the whole shebang
      end
      % Call the plot driver
      if iscellstr(PlotWhat)
        plothandle = MODCase.Plot7(SubCases, PlotWhat, 'tp7');
      else
        plothandle = MODCase.Plot7ByCase(SubCases, PlotWhat, 'tp7');
      end
    end % PlotTp7
    function plothandle = PlotSc7(MODCase, PlotWhat, SubCases)
      % PlotSc7: Plots data from .7sc (or tape7.scn) file, stored in MODCase
      %
      % Usage :
      %   plothandle = MODCase.PlotSc7(PlotWhat, SubCases)
      %     Or
      %   plothandle = MODCase.PlotSc7(PlotWhat)
      %
      % Where:
      %   MODCase is the Mod5 from which to plot the data.
      %   PlotWhat is a cell array of strings giving the (fixed) header names
      %     of the data columns in the sc7 structure to plot. To
      %     determine which header names are available for a specific case,
      %     look at the property MyMod5(iSubCase).sc7.Headers.
      %     If PlotWhat is a string (rather than a cell array of strings)
      %     all sub-cases are plotted on a single plot, otherwise each
      %     sub-case will have a seperate plot. If PlotWhat is omitted
      %     or specified as {'ALL'}, all data is plotted.
      %
      %   SubCases allows selection of individual subcases (vector) of
      %     sub-case numbers. If omitted or given as empty, [], 
      %     all sub-cases are plotted, each in an individual plot. 
      % 
      %   If the sub-case being plotted has a description (CaseDescr property),
      %     it will be used for the plot title. If not, the CaseName property
      %     will be used. The legends on the plot will correspond to the
      %     Headers by default.
      %
      %  In general, transmittance data for a subcase will be plotted together
      %     and radiances together on another plot.
      %
      %   The returned parameter plothandles is a vector of handles to the
      %     plots generated. 

      % Verify inputs
      if exist('SubCases', 'var') && ~isempty(SubCases)
        assert(isnumeric(SubCases) && all(round(SubCases(:)) == SubCases(:)) && min(SubCases(:)) >= 1 && max(SubCases(:) <= numel(MODCase)), ...
        'Mod5:PlotSc7:BadCaseIndices','Input SubCases must be integer and within range of the size of the Mod5.');
      else
        SubCases = 1:numel(MODCase);
      end
      if exist('PlotWhat', 'var') && ~isempty(PlotWhat)
        assert(ischar(PlotWhat) || iscellstr(PlotWhat), 'Mod5:PlotSc7:BadPlotReq','Input PlotWhat must be a string or cell array of string headers.');
      else
        PlotWhat = {'ALL'};  % Plot the whole shebang
      end
      % Call the plot driver
      if iscellstr(PlotWhat)
        plothandle = MODCase.Plot7(SubCases, PlotWhat, 'sc7');
      else
        plothandle = MODCase.Plot7ByCase(SubCases, PlotWhat, 'sc7');
      end
    end % PlotSc7
    function plothandle = PlotChn(MODCase, SubCases)
      % PlotChn : Bar plot of spectral channel outputs (.chn) from MODTRAN
      %
      % Usage :
      %   plothandle = PlotChn(MODCase, SubCases)
      %
      % MODCase is the case for which to plot the channels.
      % SubCases allows selection of subcases. If SubCases is missing
      %  or empty, all subcases are plotted on a single bar plot.
      %
      % This function is not able to plot cases that have different
      % numbers of channels in the .chn data. Therefore present only
      % a subset of cases with the same filters and channels represented
      % in the .flt and .chn data.
      
      if ~exist('SubCases', 'var') || isempty(SubCases)
        SubCases = 1:numel(MODCase);
      end
     
      assert(isnumeric(SubCases) && all(round(SubCases(:)) == SubCases(:)) && all(SubCases(:) >= 1) && all(SubCases(:) <= numel(MODCase)), ...
        'Mod5:PlotChn:BadSubCases','Input SubCases to PlotChn must be integral, less than number of elements in the Mod5.');
      plothandle = [];
      Channels = [];
      ChanRads = [];
      ChanIrrads = [];
      ChanExtincts = [];
      ChanDesc = {};
      iFigure = 0;
      for iSubCase =SubCases
        if ~isempty(MODCase(iSubCase).chn)
          Channels = [Channels MODCase(iSubCase).chn.ChanNumber];
          NextLegend = [MODCase(iSubCase).CaseName '(' num2str(MODCase(iSubCase).CaseIndex) ')'];
          ChanDesc = [ChanDesc NextLegend];
          switch MODCase(iSubCase).IEMSCT
            case 0 % Transmittance cases
              ChanExtincts = [ChanExtincts MODCase(iSubCase).chn.ChanExtinct];
            case {1 2 4} % Radiance Cases
              ChanRads = [ChanRads MODCase(iSubCase).chn.ChanRad];
            case 3 % Irradiance
              ChanIrrads = [ChanIrrads MODCase(iSubCase).chn.ChanIrrad];
          end
        end  
      end
      if ~isempty(ChanExtincts)
        iFigure = iFigure + 1;
        plothandle(iFigure) = figure;
        bar(Channels, ChanExtincts);
        title('Band (Channel) Extinctions');
        grid;
        xlabel('Channel Number');
        ylabel('Channel Extinction (cm^{-1})');
        legend(ChanDesc, 'Location', 'best');        
      end
      if ~isempty(ChanRads) % There is something to plot
        iFigure = iFigure + 1;
        plothandle(iFigure) = figure;
        bar(Channels, ChanRads);
        title('Band (Channel) Radiance');
        grid;
        xlabel('Channel Number');
        ylabel('Band Radiance (W/sr/cm^2)');
        legend(ChanDesc, 'Location', 'best');
      end
      if ~isempty(ChanIrrads)
        iFigure = iFigure + 1;
        plothandle(iFigure) = figure;
        bar(Channels, ChanIrrads);
        title('Band (Channel) Irradiance');
        grid;
        xlabel('Channel Number');
        ylabel('Band Irradiance (W/cm^2)');
        legend(ChanDesc, 'Location', 'best');
      end
    end % PlotChn
    function plothandles = PlotAtm(MODCase, PlotWhat)
      % PlotAtm : Plot user-defined atmopheric profiles
      %
      % Usage :
      %  plothandles = MODCase.PlotAtm(PlotWhat);
      %
      % Where MODCase is a Mod5 (or vector of cases) that have
      % user-defined atmospheres (MODEL = 0 or 7 or 8 and I_RD2C = 1).
      %
      % PlotWhat is a cell array of strings indicating which data should
      % be plotted. Use the following codes:
      %   'P'   - Pressure
      %   'T'   - Temperature
      %   'H2O' - Water Vapor
      %   'CO2' - Carbon Dioxide
      %   'O3'  - Ozone
      %   'N2O' - Nitrous Oxide
      %   'CO'  - Carbon Monoxide
      %   'CH4' - Methane
      %   'O2'  - Oxygen
      %   'NO'  - Nitric Oxide
      %   'SO2' - Sulfur Dioxide
      %   'NO2' - Nitrogen Dioxide
      %   'NH3' - Ammonia
      %   'HNO3'- Nitric Acid
      %
      % The heavy molecular species can also be plotted. Use the chemical
      % symbols given in the MODTRAN manual for the Card 2C series
      % (User-defined Atmospheric Profiles).
      %
      % Use PlotWhat = 'ALL' to plot all available user-defined atmospheric
      % layer data.
      %
      % Only explicitly user-defined data is plotted. No parameters that
      % are defaulted to canned atmospheres are plotted.
      %
      % Limitations :
      %  The user defined atmosphere MUST specify the same units for a
      %  particular molecular species (or temperature/pressure) for all
      %  layers. If different units are given, the plot will be meaningless.
      %  The units for the first layer will be used on the plot.
      %
      
      iPlot = 0;
      plothandles = [];
      assert(ischar(PlotWhat) || iscellstr(PlotWhat), 'Mod5:PlotAtm:BadPlotWhat', ...
        'Input PlotWhat must be a string or cell array of strings.');
      
      LightSpecies = {'H2O', 'CO2', 'O3', 'N2O', 'CO', 'CH4', 'O2', 'NO', 'SO2', 'NO2', 'NH3', 'HNO3'};
      LightSpeciesNames = {'Water Vapor', 'Carbon Dioxide', 'Ozone', 'Nitrous Oxide', 'Carbon Monoxide', 'Methane', 'Oxygen', 'Nitric Oxide', ...
                           'Sulfur Dioxide', 'Nitrogen Dioxide', 'Ammonia', 'Nitric Acid'};
      HeavySpecies = {'CCl3F', 'CCl2F2', 'CClF3', 'CF4', 'CHClF2', 'C2Cl3F3', 'C2Cl2F4', 'C2ClF5', 'ClONO2', 'HNO4', 'CHCl2F', 'CCl4', 'N2O5'};
      HeavySpeciesNames = {'CCl_3F', 'CCl_2F_2', 'CClF_3', 'CF_4', 'CHClF_2', 'C_2Cl_3F_3', 'C_2Cl_2F_4', ...
                           'C_2ClF_5', 'ClONO_2', 'HNO_4', 'CHCl_2F', 'Carbon Tetra-Chloride - CCl_4', 'N_2O_5'};
      if ischar(PlotWhat)
        if strcmpi(PlotWhat, 'ALL');
          PlotWhat = ['P' 'T' LightSpecies HeavySpecies];
        else
          PlotWhat = cellstr(PlotWhat);
        end
      end
                         
      % Scan for stuff to be plotted
      iLight = [];
      iHeavy = [];
      for iWhat = 1:numel(PlotWhat)
        LightMatch = strmatch(upper(PlotWhat{iWhat}), upper(LightSpecies), 'exact');
        if ~isempty(LightMatch)
          iLight = [iLight LightMatch];
        end
        HeavyMatch = strmatch(upper(PlotWhat{iWhat}), upper(HeavySpecies), 'exact');
        if ~isempty(HeavyMatch)
          iHeavy = [iHeavy HeavyMatch];
        end
      end
      iLight = sort(unique(iLight));
      iHeavy = sort(unique(iHeavy));
      % Run through all sub-cases
      % Plot only when the sub-case ...
      %   a) has a user-defined model atmosphere MODEL = 0/7/8, I_RD2C = 1 and
      %   b) user has requested plotting of the atmospheric layer data and
      %   c1) atmospheric layer data is given and is non-zero with explicit or default units
      %        OR
      %   c2) atmospheric layer data is given with explicit units
      for iCase = 1:numel(MODCase)
        PlotData = []; % Build up array of numeric plot data
        nDataCol = 0; % Number of data columns
        XLabels = {};
        AtmName = strtrim(MODCase(iCase).HMODEL);
        Z = MODCase(iCase).ZM;
        if any(MODCase(iCase).MODEL == [0 7 8]) || MODCase(iCase).I_RD2C == 1
          % Check for unit consistency across all layers
          JChar = cellstr(MODCase(iCase).JCHAR);
          JCharX = MODCase(iCase).JCHARX;
          % Not interested in quantities that default to canned atmospheres
          for Canned = 1:6
            JChar = strrep(JChar, num2str(Canned), ' ');
            JCharX = strrep(JCharX, num2str(Canned), ' ');
          end
          % Make sure all non-canned quantities have the same (or default) units for all layers
          if numel(JChar) ~= numel(strmatch(JChar{1}, JChar, 'exact')) || ~all(JCharX(1) == JCharX)
            error('Mod5:PlotAtm:UnitInconsistency', 'Units are inconsistent across atmospheric layers. PlotAtm cannot handle that.')
          end
          JChar = JChar{1};
          % Do Pressure
          if ~isempty(strmatch('P', upper(PlotWhat), 'exact')) && ~isempty(MODCase(iCase).P)
            % Determine the units
            Units = '';
            switch JChar(1)
              case 'A'
                Units = 'mb';
              case 'B'
                Units = 'atm';
              case 'C'
                Units = 'torr';
              case ' '
                if ~all(MODCase(iCase).P == 0)
                  Units = 'mb';
                end
            end
            % If units have been assigned then there is something to plot
            if ~isempty(Units)
              nDataCol = nDataCol + 1;
              PlotData(:, nDataCol) = MODCase(iCase).P;
              XLabels{nDataCol} = ['Pressure (' Units ')'];
            end
          end
          % Do Temperature
          if ~isempty(strmatch('T', upper(PlotWhat), 'exact')) && ~isempty(MODCase(iCase).T)
            % Determine the units
            Units = '';
            switch JChar(2)
              case 'A'
                Units = 'K';
              case 'B'
                Units = '\circC';
              case ' '
                if ~all(MODCase(iCase).T == 0)
                  Units = 'K';
                end
            end
            % If units have been assigned then there is something to plot
            if ~isempty(Units)
              nDataCol = nDataCol + 1;
              PlotData(:, nDataCol) = MODCase(iCase).T;
              XLabels{nDataCol} = ['Temperature (' Units ')'];
            end
          end
        end
        % Next do all the light species WMOL(1) to WMOL(12)
        for iLight = 1:numel(LightSpecies)
          if ~isempty(strmatch(upper(LightSpecies{iLight}), upper(PlotWhat), 'exact')) && size(MODCase(iCase).WMOL, 2) >= iLight
            % Determine the units
            Units = '';
            switch JChar(iLight + 2)
              case 'A'
                Units = 'ppmv';
              case 'B'
                Units = 'n/cm^3';
              case 'C'
                Units = 'g/kg';
              case 'D'
                Units = 'g/m^3';
              case 'E'
                Units = 'mb';
              case 'F'
                if iLight == 1 % H2O
                  Units = 'Dew K';
                end
              case 'G'
                if iLight == 1
                  Units = 'Dew \circC';
                end
              case 'H'
                if iLight == 1
                  Units = 'RH%';
                end
              case ' '
                if ~all(MODCase(iCase).WMOL(:, iLight) == 0)
                  Units = 'ppmv';
                end
            end
            % If units have been assigned then there is something to plot
            if ~isempty(Units)
              nDataCol = nDataCol + 1;
              PlotData(:, nDataCol) = MODCase(iCase).WMOL(:, iLight);
              XLabels{nDataCol} = [LightSpeciesNames{iLight} ' (' Units ')'];
            end
          end
          
        end
        % Now do the heavy species
        for iHeavy = 1:numel(HeavySpecies)
          if ~isempty(strmatch(upper(HeavySpecies{iHeavy}), upper(PlotWhat), 'exact')) && size(MODCase(iCase).WMOLX, 2) >= iHeavy
            % Determine the units
            Units = '';
            switch JCharX(iHeavy)
              case 'A'
                Units = 'ppmv';
              case 'B'
                Units = 'n/cm^3';
              case 'C'
                Units = 'g/kg';
              case 'D'
                Units = 'g/m^3';
              case 'E'
                Units = 'mb';
              case ' '
                if ~all(MODCase(iCase).WMOLX(:, iHeavy) == 0)
                  Units = 'ppmv';
                end
            end
            % If units have been assigned then there is something to plot
            if ~isempty(Units)
              nDataCol = nDataCol + 1;
              PlotData(:, nDataCol) = MODCase(iCase).WMOLX(:, iHeavy);
              XLabels{nDataCol} = [HeavySpeciesNames{iHeavy} ' (' Units ')'];
            end
          end
          
        end
        % Plot any accumulated data
        if ~isempty(PlotData)
          iPlot = iPlot + 1;
          plothandles(iPlot) = figure;
          for iCol = 1:nDataCol
            subplot(1, nDataCol, iCol);
            plot(PlotData(:, iCol), Z);
            grid;
            ylabel('Altitude (km)');
            xlabel(XLabels{iCol});
          end
          if iCol == 1
            title([MODCase(iCase).CaseName ' ' AtmName]);
          end
        end
      end
      if isempty(plothandles)
        warning('Mod5:PlotAtm:NoData','There is no user-defined atmospheric data conforming to the plot request.')
      end
    end % PlotAtm 
    function plothandles = PlotIrrad(MODCase, varargin)
        % PlotIrrad : Plot MODTRAN horizontal irradiances (fluxes)
        %
        % MODTRAN will generate a convolved horizontal flux table if the
        % FLAGS(7) property is set to 't' or 'f'. 
        % 
        % Usage :
        %   plothandle = MyMod5.PlotIrrad;
        %      or
        %   plothandle = MyMod5.PlotIrrad(iAltitudes)        
        %
        % Plots four graphs for each element of the input MyMod5.
        % The first three are plots of upward diffuse, downward diffuse and
        % direct solar irradiance versus the spectral variable (wavelength
        % or wavenumber). The last plot is a plot of total irradiance
        % versus altitude with all of the three components.
        %
        % If the optional altitude boundary index vector iAltitudes is
        % given, only the specified altitudes will be plotted. Note these
        % are not the altitudes themselves, but the indices pointing into
        % the Flx.Altitudes field. If there are less than 6 layer
        % boundaries, then a legend is plotted of the boundary altitudes.
        %
        % The output plothandle is a vector of figure handles.
        %
        % See Also : PlotIrradImg, ReadFlx, PlotFlx, PlotFlxImg

        plothandles = [];
        for iCase = 1:numel(MODCase)
            if ~isempty(MODCase(iCase).flx)
                plothandles = [plothandles Mod5.PlotFlx(MODCase(iCase).flx, varargin{:})];
            end
        end
    end % PlotIrrad
    function plothandles = PlotIrradImg(MODCase, varargin)
        % PlotIrrad : Plot MODTRAN horizontal irradiances (fluxes)as image
        %
        % Usage :
        %    plothandle = MyMCase.PlotFlxImg(Flx);
        %
        %      Or
        %    plothandle = MyMCase.PlotFlxImg(Flx, Altitudes);
        %
        %      Or
        %    plothandle = MyMCase.PlotFlxImg(Flx, Altitudes, InterpMethod);
        %
        %    plothandle = MyMCase.PlotFlxImg(Flx, Altitudes, InterpMethod, TheColorMap);
        %
        % Input MyMCase must be a Mod5 object with .flx field.
        %
        % Plots colored images of the spectral fluxes (horizontal
        % irradiance) with the spectral variable on the horizontal axis and
        % altitude on the vertical axis. Three images are plotted, one for
        % the upward diffuse irradiance, one for downward diffuse and one
        % for direct solar irradiance. If the optional input Altitudes is
        % given (numeric vector), the fluxes are interpolated onto these
        % Altitudes, using the interpolation method specified in the
        % optional additional input InterpMethod. InterpMethods are as for
        % the function interp1. The default altitudes in MODTRAN are not 
        % evenly spaced, so it is highly recommended that the input
        % Altitudes be given with regular spacing of at least 1 km,
        % otherwise the vertical (altitude) scale will be incorrect or
        % misleading.
        % 
        % The color bar scale on the right of the
        % plot can be given as the input TheColorMap. Suitable inputs are
        % anything that is valid for the colormap function. If any of the
        % optional inputs is missing or empty, they will default as follows:
        %    Altitudes : defaults to the Altitudes field in the input Flx
        % InterpMethod : defaults to 'linear'
        %  TheColorMap : defaults to jet (not 'jet'), jet is a
        %                Matlab-defined function that generates the jet colormap.
        %                Other colormaps can be found by getting help on
        %                the colormap function.
        %
        %
        % See Also : ReadFlx, PlotFlx, interp1, colormap
        plothandles = [];
        for iCase = 1:numel(MODCase)
            if ~isempty(MODCase(iCase).flx)
                plothandles = [plothandles Mod5.PlotFlxImg(MODCase(iCase).flx, varargin{:})];
            end
        end
    end % PlotIrradImg
    
    function MC = AttachFlt(MC, Flt, iSubCases)
      % AttachFlt : Attach a filter to a Mod5
      %
      % Usage:
      %   MC = MC.AttachFlt(Flt); % Attach Flt to all sub-cases
      %    Or
      %   MC = MC.AttachFlt(Flt, iSubCases); % Attach only to certain sub-cases
      %
      % Where MC is the Mod5 to which the spectral filter defined
      % by the structure Flt is to be attached. The filter will be
      % used to compute band/channel radiances (.chn file output from MODTRAN)
      % when MODTRAN is run on the case.
      % The structure Flt can be read from a .flt format file, or it can
      % by created using the function Mod5.CreateFlt.
      %
      % If given, iSubCases must be a vector of sub-case indices to
      %   which the filter data is to apply. If not given, the filter
      %   data will apply to all sub-cases.
      %   The Flt data will be attached only to the first sub-case
      %   in iSubCases, in the property flt.
      %
      % Note that attaching a filter to a case will alter the MODTRAN
      %   parameters LFLTNM and FILTNM accordingly. When the case is run,
      %   a .flt file having the name of the case will be written to
      %   the MODTRAN executable directory. Within a Mod5, there
      %   may be several difference filter sets attached to subsets of 
      %   sub-cases. That is, it is possible for each sub-case to have a
      %   different filter set. However, a call to AttachFlt is required
      %   for each different filter set.
      %
      %
      % Flt must be scalar and have the following fields:
      %
      %   UnitsHeader : 'W' for wavenumber in cm^-1, 'N' for wavelength
      %                 in nm, and 'M' for wavelength in microns.
      %        Units  : a string containing 'cm^1', 'nm' or 'µm' as 
      %                 appropriate for the value in UnitsHeader.
      %   FileHeader  : The entire first header (UNITS_HEADER) line,
      %                 being the first line in the .flt file.
      %  FilterHeaders: A cell array of strings, with one string entry
      %                 for each filter found in the file. The number of
      %                 cells is therefore also the number of filters
      %                 found in the file. These are referred to as
      %                 HEADER(i) in the MODTRAN manual.
      %     Filters   : A cell array with each cell containing a two
      %                 column matrix of numbers. The first column is
      %                 the wavenumber or wavelength in the Units given
      %                 above, and the second column is the transmittance
      %                 of the filter at the given wavelength/number.
      %                 There may also be a third column containing
      %                 the wavenumber or wavelength corresponding to
      %                 the wavelength or wavenumber respectively in
      %                 the first column (see AVIRIS.flt).
      %
      % See Also: WriteFlt, ReadFlt, CreateFlt
      %
      
      % Check that the Flt has the required fields
      assert(isscalar(Flt) && isstruct(Flt), 'Mod5:AttachFlt:FltNotStruct', ...
        'Input Flt must be a scalar structure with fields FileHeader, UnitsHeader, Units, FilterHeader and Filters.');      
      if ~all(isfield(Flt, {'FileHeader','UnitsHeader', 'Units', 'FilterHeaders', 'Filters'}))
        error('Mod5:AttachFlt:BadFlt', ...
          'The Flt structure input does not have all the correct fields - FileHeader, UnitsHeader, Units, FilterHeader and Filters. ')
      end
      if exist('iSubCases', 'var')
        assert(isnumeric(iSubCases) && all(iSubCases >= 1) && all(iSubCases <= numel(MC)),'Mod5:AttachFlt:BadiSubCases', ...
          'Input iSubCases must be a numeric vector of integer indices, all less than or equal to the number of sub-cases in MC.');
      else
        iSubCases = 1:numel(MC);
      end
      % There is no validation besides this for now
      % Attach the filter to the first case listed in iSubCases
      MC(iSubCases(1)).flt = Flt;
      for iCase = iSubCases
        % Tell MODTRAN a filter has been attached to this subcase
        MC(iCase).LFLTNM = 'T';
        % Point MODTRAN to the filter (.flt) file.
        % NOTE: the .flt file is only written when MODTRAN is executed on
        % the case (MyCase.Run)
        % The filter data itself is attached to the first iSubCase, and referred to by this iSubCase
        MC(iCase).FILTNM = [MC(iSubCases(1)).CaseName '(' num2str(MC(iSubCases(1)).CaseIndex) ').flt'];
      end
    end % AttachFlt
    function MC = AttachAlb(MC, Alb, iCSALB, iAACSALB)
      % AttachAlb : Attach albedo (reflectance) data to a Mod5
      %
      % AttachAlb will attach lambertian albedo (reflectance) data to a MODTRAN
      % radiance case. The albedo data can come for various sources,
      % including ASD (spectroradiometer) measurements or from the
      % USGS splib database. Using AttachAlb does everything necessary
      % to get MODTRAN to model a lambertian earth surface with the
      % specified albedo.
      %
      % Usage :
      %  MC = MC.AttachAlb(Alb);
      %
      %    Or
      %
      %  MC = MC.AttachAlb(Alb, iCSALB);
      %
      %    Or
      %
      %  MC = MC.AttachAlb(Alb, iCSALB, iAACSALB);
      %
      % Where :
      %
      %  MC is a Mod5. Only radiance cases (IEMSCT = 1 or 2) qualify.
      %    An warning will be issued if MC(i) is not a radiance case, but
      %    the albedo data be attached to the offending sub-case anyway. 
      %
      %  Alb is a structure that defines the spectral albedo (lambertian
      %    reflectance) at the target pixel (H2). Alb has the following fields:
      %
      %   Filename : The name of the file from which the albedo data was 
      %              originally read (if any).
      %     Header : The header information (metadata) to the albedo data
      %      title : The title of the material, substance or surface having 
      %              the given spectral albedo
      %         wv : The wavelengths (in µm) at which the albedo is given 
      %       refl : The reflectance (albedo) of the material at the given wavelengths.
      %
      % Note that only one set of albedo data can be attached to a Mod5.
      %  All sub-cases must draw from the same set of albedo curves. The Alb
      %  structure itself gets attached to the first sub-case that uses
      %  the albedo data given in the property alb.
      %
      % The spectral albedo data must span the spectral limits of the
      %   MODTRAN computation (V1 and V2 on Card 4).
      %   A warning will be issued if this condition is not met. The
      %   albedo data will be attached to the offending sub-cases anyway.
      %   You would be well advised to reduce the span of V1 and V2 to fix
      %   the problem, or supply new albedo data that fully spans the interval.
      %
      % This function alters the input Mod5 (MC) in several ways.
      %   The SURREF input (on MODTRAN Card 1) is set to 'LAMBER'. 
      %   Cards 4A, 4L1 and 4L2 will be set up appropriately as follows:
      %
      %   1) If Alb is scalar, NSURF on Card 4A is set to 1. The CSALB 
      %      on Card 4L1 (H2 target spectral albedo) is set from this Alb(1).
      %      The same albedo data is attached to all sub-cases of MC.
      %   2) If Alb contains more than 2 elements, the inputs iCSALB and
      %      iAACSALB can be used to give the indices of the target pixel 
      %      spectral albedo, Alb(iCSALB) and the area-averaged spectral
      %      albedo Alb(iAACSALB).
      %
      % iCSALB and iAASALB, if given, must either be scalar or they must
      %   have the same number of elements as the input Mod5 MC.
      %   If they have the same number of elements as MC, then different
      %   albedo curves (all from Alb) can be assigned to the different
      %   sub-cases of MC. If albedo data is not to be assigned to a
      %   particular sub-case, use zero in that position in iCSALB or
      %   in iAACSALB. Note that non-zero values in iAACSALB where the
      %   the corresponding value in iCSALB is zero does not make sense
      %   and the iAACSALB value will be ignored.
      %
      % AttachAlb will cause the method Run to write the albedo data to
      %   a file called CaseName.alb, where CaseName is the name of the
      %   first sub-case (MODCase(1).CaseName). The albedo data Alb,
      %   is saved in the Mod5 property alb.
      %
      % AATEMP on Card 4A will not be altered by AttachAlb.      
      %
      % Note : Read the MODTRAN manual carefully concerning the use of
      %        area-averaged surface spectral albedo. This feature is used
      %        to estimate the adjacency effect when imaging calibration
      %        tarps.
      %
      % See Also : ReadAlb, WriteAlb, ReadAlbFromUSGS, ReadAlbFromASD,
      %            CreateAlb, PlotAlb
      %
      % Example :
      %
      %   % Read some reflectance data from an ASD file. Suppose there
      %   % are 4 reflectance curves in the file.
      %   MyAlb = Mod5.ReadAlbFromASD('MyASDTextData.txt');
      %   MyCase = Mod5('MyCase.tp5'); % Read a case - suppose it has 4 subcases
      %   MyCase = MyCase.AttachAlb(MyAlb, [1 3 1 0], [0 0 2 0]);
      %
      %  The above AttachAlb example will attach albedo curves 1, 3 and 1
      %  to sub-cases 1, 2 and 3 respectively for the H2 pixel albedo.
      %  Only sub-case 3 gets a different area-averaged albedo, namely
      %  albedo curve number 2.
      
      % Do some input validation
      assert(isstruct(Alb) && all(isfield(Alb, {'Header','title','wv','refl'})), 'Mod5:WriteAlb:BadAlb', ...
        'The input structure Alb must have the fields Header, title, wv, and refl.');
            
      if exist('iCSALB', 'var')
        assert(isnumeric(iCSALB) && (isscalar(iCSALB) || numel(iCSALB) == numel(MC)), 'Mod5:AttachAlb:BadiCSALB', ...
          'Input iCSALB must be numeric and either be scalar or have the same number of elements as input Mod5 MC.');
        iCSALB = round(iCSALB);        
        assert(all(iCSALB) >= 0 & all(iCSALB) <= numel(Alb), 'Mod5:AttachAlb:iCSALBoutofRange', ...
          'Value(s) of input iCSALB must be positive and less than or equal to number of elements in input Alb.');
      else
        iCSALB = 1;
      end
      if exist('iAACSALB', 'var')
        assert(isnumeric(iAACSALB) && (isscalar(iAACSALB) || numel(iAACSALB) == numel(MC)), 'Mod5:AttachAlb:BadiAACSALB', ...
          'Input iAACSALB must be numeric and either be scalar or have the same number of elements as input Mod5 MC.'); 
        iAACSALB = round(iAACSALB);        
        assert(all(iAACSALB) >= 1 & all(iAACSALB) <= numel(Alb), 'Mod5:AttachAlb:iAACSALBoutofRange', ...
          'Value(s) of input iAACSALB must be less than or equal to number of elements in input Alb.');        
      else
        iAACSALB = 0;
      end
      % If the indices of the albedo data are scalar, pump them up to same size as MC
      if isscalar(iCSALB)
        iCSALB = repmat(iCSALB, size(MC));
      end
      if isscalar(iAACSALB)
        iAACSALB = repmat(iAACSALB, size(MC));        
      end
      
      %% Everything seems to be in order, proceed to attach the albedo data
      % Look for first non-zero element in iCSALB
      iAttach = find(iCSALB > 0);
      if ~isempty(iAttach)
        iAttach = iAttach(1);
      else
        error('Mod5:AttachAlb:iCSALBallZero','At least one element of input iCSALB must be non-zero.');
      end
      MC(iAttach).alb = Alb; % Attach the albedo data, only to first subcase using the data
      for iC = 1:numel(MC) % Run through the sub-cases
        if iCSALB(iC) > 0 % Set up CSALB for this sub-case
          % If not a radiance case, issue warning
          if ~any(MC(iC).IEMSCT == [1 2])
            warning('Mod5:AttachAlb:NotRadianceCase','Sub-case %i is not a radiance case. Albedo data has been attached anyway.', iC);
          end
          % Determine limiting wavelengths of the case
          switch upper(MC(iC).FLAGS(1))
            case {' ', 'W'} % Wavenumbers
              Lambda1 = 10000/MC(iC).V2; % Convert to wavelength in microns
              Lambda2 = 10000/MC(iC).V1;
            case 'M' % Microns
              Lambda1 = MC(iC).V1; % Wavelength is in microns
              Lambda2 = MC(iC).V2;
            case 'N' % Nanometres
              Lambda1 = MC(iC).V1/1000; % Convert to wavelength in microns
              Lambda2 = MC(iC).V2/1000;
          end
          % Check that wavelength range of the sub-case spans the wavelength range of the albedo data
          AlbLambda1 = min(Alb(iCSALB(iC)).wv);
          AlbLambda2 = max(Alb(iCSALB(iC)).wv);
          if (AlbLambda1 > Lambda1) || (Lambda2 > AlbLambda2)
            warning('Mod5:AttachAlb:WavelengthOverlap', ...
              'Albedo wavelength range for sub-case %i does not span the case range (V1 to V2). Albedo data has been attached anyway.', iC);
          end
          if iAACSALB(iC) > 0
            AlbLambda1 = min(Alb(iAACSALB(iC)).wv);
            AlbLambda2 = max(Alb(iAACSALB(iC)).wv);
            if (AlbLambda1 > Lambda1) || (Lambda2 > AlbLambda2)
              warning('Mod5:AttachAlb:WavelengthOverlap', ...
                'Albedo wavelength range for sub-case %i does not span the case range (V1 to V2). Albedo data has not been attached.', iC);
            end
          end % Finished checking wavelength range overlap
          MC(iC).SURREF = 'LAMBER';
          MC(iC).NSURF = 1;
          MC(iC).SALBFL = [MC(iAttach).CaseName '(' num2str(MC(iAttach).CaseIndex) ').alb'];
          MC(iC).CSALB = Mod5.AlbedoName(Alb(iCSALB(iC)).title);
          if iAACSALB(iC) > 0
            MC(iC).NSURF = 2; % Will also specify area-averaged albedo
            MC(iC).CSALB = strvcat(MC(iC).CSALB, Mod5.AlbedoName(Alb(iAACSALB(iC)).title));
          end
        end
      end
    end % AttachAlb
    function MC = Set(MC, varargin)
      % Set : Set any number of Mod5 properties in one function call
      %
      % Usage :
      %   MC = MC.Set(Property1, Value1, Property2, Value2, ...)
      % Where :
      %   The Properties are valid Mod5 properties, including
      %   any of the MODTRAN parameters. The order of the property
      %   value pairs is not important, nor do they have to appear on
      %   a single MODTRAN Card. 
      %
      % Example :
      %
      %  MC = MC.Set('MODTRN', 'M','SPEED','S','MODEL', 3, 'ITYPE', 3, 'IEMSCT', 2, ...
      %              'IMULT', 0, 'M1', 0, 'M2', 0, 'M3', 0, 'M4', 0, 'M5', 0 , 'M6', 0, ...
      %              'MDEF', 0, 'I_RD2C', 0, 'NOPRNT', 1, 'TPTEMP', 0, 'SURREF', '0.5');
      %
      % The above example sets all parameters on MODTRAN Card1. Remember
      % that if MODTRAN requires a particular card, it is important to
      % set all parameters on that card, even if they are not used in a
      % particular case.
      %

      
      % MC must be scalar
      assert(isscalar(MC), 'Mod5:Set','Input Mod5 to method Set must be scalar.');
      
      % Ensure that there are an even number of varargs
      if rem(length(varargin), 2)
        error('Mod5:Set','There must be a value given for each property name - hence an even number of arguments to method Set.');
      end
      
      % Then just blindly run through them and set the properties, provided that the Property is char
      % Rely on set methods such as they exist to check for value correctness
      for iProp = 1:2:length(varargin)
        assert(ischar(varargin{iProp}), 'Mod5:Set', ...
          'Property names must be character strings in the arguments of method Set.');
        MC.(varargin{iProp}) = varargin{iProp + 1};
      end
    end % Set
    function MC = SetCard1(MC, varargin)
      % SetCard1 : Set all parameters on Card 1 - Main Radiation Transport
      %
      % Usage :
      %  MC = MC.SetCard1(MODTRN, SPEED, MODEL, ITYPE, IEMSCT, IMULT, M1, ...
      %                M2, M3, M4, M5, M6, MDEF, I_RD2C, NOPRNT, TPTEMP, SURREF)
      %
      % Refer to the MODTRAN5 User's Manual for descriptions of the input
      % parameters.
      %
      % 
      % Parameters omitted or empty, will get the following defaults:
      % 
      % MODTRN = 'M'; MODTRAN Band Model
      % SPEED  = 'S'; Slow speed correlated-k option
      % MODEL  = 6;   1976 US Standard Atmosphere
      % ITYPE  = 2;   Slant path (LOS) between two altitudes
      % IEMSCT = 0;   Transmittance mode
      % IMULT  = 0;   No multiple scattering (inapplicable to transmittance mode
      % M1 = M2 = M3 = M4 = M5 = M6 = 0; Default profiles to MODEL (1976 US Standard Atm.)
      % MDEF   = 1;   Default other gases and heavy species - no user input
      % I_RD2C     = 0;   Normal program operation - no user-supplied atm. profiles
      % NOPRNT = 1;   Minimize printing to tape6.
      % TPTEMP = 0;   No surface emission added if H2 is above ground
      % SURREF = '0.5'; Albedo of the earth (spectrally flat)
      %
      
      %% Use the inputParser to check input parameters
      iP = inputParser;

      iP.addRequired('MC', @isscalar);
      iP.addOptional('MODTRN', 'M');
      iP.addOptional('SPEED','M', @(x)isscalar(x) && ischar(x));
      iP.addOptional('MODEL', 'S');
      iP.addOptional('ITYPE', 2);
      iP.addOptional('IEMSCT', 0);
      iP.addOptional('IMULT', 0);
      iP.addOptional('M1', 0);
      iP.addOptional('M2', 0);
      iP.addOptional('M3', 0);
      iP.addOptional('M4', 0);
      iP.addOptional('M5', 0);
      iP.addOptional('M6', 0);
      iP.addOptional('MDEF', 1);
      iP.addOptional('I_RD2C', 0);
      iP.addOptional('NOPRNT', 1);
      iP.addOptional('TPTEMP', 0);
      iP.addOptional('SURREF', '0.5', @ischar);
      iP.parse(MC, varargin{:});
      MC.MODTRN = MODTRN;
      MC.SPEED = SPEED;
      MC.MODEL = MODEL;
      MC.TYPE = ITYPE;
      MC.IEMSCT = IEMSCT;
      MC.IMULT = IMULT;
      MC.M1 = M1;
      MC.M2 = M2;
      MC.M3 = M3;
      MC.M4 = M4;
      MC.M5 = M5;
      MC.M6 = M6;
      MC.MDEF = MDEF;
      MC.I_RD2C = I_RD2C;
      MC.NOPRNT = NOPRNT;
      MC.TPTEMP = TPTEMP;
      MC.SURREF = SURREF;
      
      
    end % SetCard1
    function MC = SetRadTransPathGeom(MC, ITYPE, H1, H2, ANGLE, RANGE, BETA, RO, LENN, PHI)
      % SetRadTransPathGeom : Set line-of-sight (path) geometry for radiance/transmittance cases
      %
      % Usage :
      %
      %  MC = MC.SetRadTransPathGeom(ITYPE, H1, H2, ANGLE, RANGE, BETA, RO, LENN, PHI);
      %
      %  The general definitions of the inputs are:
      %    ITYPE defines the type of path - see below
      %    H1 is the altitude above sea level of the sensor (km)
      %    H2 is the altitude above sea level of the target (km)
      %    ANGLE is the zenith angle of the path at H1 (degrees)
      %    RANGE is the path length (km)
      %    BETA is the earth centre angle subtended by the path from H1 to H2
      %    RO is the radius of the earth (km) at the latitude of observation
      %    LENN is a switch to determine whether the short or long path is
      %         selected in the case of a "tangent path". LENN = 0 is the
      %         default and selects the short path. LENN = 1 selects the
      %         long path.
      %    PHI is the zenith angle of the path at H2 (degrees)
      %
      %  Only certain combinations of inputs are consistent. For a complete
      %  set of rules, see the standard Card 3 documentation.
      %
      % 
      %  ITYPE is the type of path
      %  ITYPE = 1  for horizontal paths
      %     then also specify H1 and RANGE only. Other inputs must be zero,
      %     or omitted.
      %  ITYPE = 2  for slant paths between two arbitrary altitudes
      %     then also specify one combination from amongst the following:
      %           (a) specify H1, H2, ANGLE, and LENN (LENN only if H2 < H1)
      %           (b) specify H1, ANGLE, and RANGE
      %           (c) specify H1, H2, and RANGE
      %           (d) specify H1, H2, and BETA
      %           (e) specify H2, H1, PHI, and LENN (LENN only if H1 < H2)
      %           (f) specify H2, PHI, and RANGE
      %    Besides the chosen combination, the other inputs must be zero (or omitted).
      %  ITYPE = 3  for slant paths to space or from space to ground
      %     then also specify one combination from amongst the following:
      %           (a) specify H1 and ANGLE
      %           (b) specify H1 and H2 (for limb-viewing problem where H2 
      %               is the tangent height or minimum altitude of the path 
      %               trajectory).
      %           (c) specify H2 and PHI (here H1 = space, possibly satellite)
      %     Besides the chosen combination, the other inputs must be zero (or omitted).
      %
      %  Omit or specify unrequired parameters as 0. Consult the MODTRAN
      %  manual for which parameters are compulsory, disallowed or
      %  optional in the various instances. The relevant parameters
      %  appear on the standard Card 3.
      %
      %  This function attempts to validate the combination of inputs. 
      %  Examine tape 6 (the file casename.tp6) to see if MODTRAN
      %  accepted the combination as valid and correctly solved for 
      %  the path geometry.
      %
      % See Also : SetIrradPathGeom
      %
      
      %% Validate inputs
      % Only scalar cases
      if ~isscalar(MC)
        error('Mod5:SetRadTransPathGeom:OnlyScalarCases','Only scalar MODTRAN cases are handled by SetRadTransPathGeom.');
      end
      % Firstly, this is the wrong function for irradiance modes
      if MC.IEMSCT == 3
        error('Mod5:SetRadTransPathGeom:WrongIEMSCT', ...
          'This is the wrong function for irradiance cases. Use SetIrradPathGeom instead, or set IEMSCT to 0,1 or 2 for a radiance/transmittance computation.')
      end
      % if inputs don't exist, make them zero
      if ~exist('H1', 'var'), H1 = 0; end;
      if ~exist('H2', 'var'), H2 = 0; end;
      if ~exist('ANGLE', 'var'), ANGLE = 0; end;
      if ~exist('RANGE', 'var'), RANGE = 0; end;
      if ~exist('BETA', 'var'), BETA = 0; end;      
      if ~exist('RO', 'var'), RO = 0; end;
      if ~exist('LENN', 'var'), LENN = 0; end;
      if ~exist('PHI', 'var'), PHI = 0; end;
      
      % All inputs must be scalar and numeric
      assert(Mod5.ScalarNumPos(ITYPE, H1, H2, ANGLE, RANGE, BETA, RO, LENN, PHI), 'Mod5:SetRadTransPathGeom:ScalarNum', ...
        'All inputs to SetRadTransPathGeom must be scalar, numeric and >= 0. ITYPE must be 1, 2 or 3.');
      % The following are the allowed combinations of parameters
      % 1 means mandatory, 0 means disallowed and 2 means optional
      switch ITYPE
        case 1
          Mandatory = [1 0 0 1 0 0]; % Case 1          
          iCase = 1;
          LENNOption = 0;
        case 2
          Mandatory = [1 1 1 0 0 0;  % Case 2a
                       1 0 1 1 0 0;  % Case 2b
                       1 1 0 1 0 0;  % Case 2c
                       1 1 0 0 1 0;  % Case 2d
                       1 1 0 0 0 1;  % Case 2e
                       0 1 0 1 0 1]; % Case 2f
          LENNOption = [1 0 0 0 1 0];
          if PHI > 0 && RANGE > 0
            iCase = 6; % 2f
          elseif PHI > 0
            iCase = 5; % 2e
          elseif BETA > 0
            iCase = 4; % 2d
          elseif RANGE > 0 && ANGLE > 0
            iCase = 2; % 2b
          elseif RANGE > 0
            iCase = 3; % 2c
          else 
            iCase = 1; % 2a
          end
          Mandatory = Mandatory(iCase, :);
          LENNOption = LENNOption(iCase);
        case 3
          Mandatory = [1 0 1 0 0 0;  % Case 3a
                       1 1 0 0 0 0;  % Case 3b
                       1 1 0 0 0 1]; % Case 3c
          LENNOption = 0;
          if PHI > 0
            iCase = 3; % 3c
          elseif H2 == 0
            iCase = 1; % 3a
          else 
            iCase = 2; % 3b
          end
          Mandatory = Mandatory(iCase, :);  
        otherwise
          fprintf(2, 'Use ITYPE = 1 for horizontal path, 2 for slant path between 2 altitudes and 3 for slant path to space or ground.\n');
          error('Mod5:SetRadTransPathGeom:BadITYPE','Input ITYPE must be 1, 2 or 3. Given input was %d.', ITYPE)
      end
      % Check that mandatory fields are zero and
      Parameters = {'H1','H2','ANGLE','RANGE','BETA','PHI'};
      CheckMandatory = [H1 H2 ANGLE RANGE BETA PHI] > 0;
      CheckLENNOption = LENN > 0;
      if ~all(CheckMandatory == Mandatory)
        fprintf(2, 'The following standard Card 3 MODTRAN input parameters should be provided in this case.\nITYPE');
        fprintf(2, ' %s', Parameters{logical(Mandatory)});
        fprintf(2, '\nAll other parameters should be given as 0, or omitted. Consult Card 3 documentation.\n');
        error('Mod5:SetRadTransPathGeom','An incompatible set of path geometry inputs was given.')
      end
      %% Go ahead and set the parameters
      MC.ITYPE = ITYPE;
      MC.H1 = H1;
      MC.H2 = H2;
      MC.ANGLE = ANGLE;
      MC.RANGE = RANGE;
      MC.BETA = BETA;
      MC.RO = RO;
      MC.LENN = LENN;
      MC.PHI = PHI;
    end % SetRadTransPathGeom
    function MC = SetIrradPathGeom(MC, H1, H2, ANGLE, IDAY, RO, ISOURC, ANGLEM)
      % SetIrradPathGeom : Set path (LOS) geometry for direct solar/lunar irradiance cases
      %
      % Usage :
      %
      %  MC = MC.SetIrradPathGeom(H1, H2, ANGLE, IDAY, RO, ISOURC, ANGLEM);
      %
      % Where :
      %    H1 is the altitude above sea level of the sensor/observer (km)
      %    H2 is the tangent height of path to the Sun/Moon (km)
      %    ANGLE is the apparent solar or lunar zenith angle at H1 (degrees)
      %    IDAY is the day of the year, used to correct variations in earth/sun distance
      %    RO is the radius of the earth (km) at the latitude of observation (H1)
      %    ISOURC is the extraterrestrial source, 0 = the Sun, 1 = the Moon
      %    ANGLEM is the phase angle of the Moon, being the angle formed by Sun,
      %      Moon and Earth.
      %
      % Most parameters can be omitted, set empty [], or made zero and will
      % then default to specific values. For example, omitting all parameters ..
      %
      %   MC = MC.SetIrradPathGeom;
      %
      % Will set the path type ITYPE to 3 and configure a vertical path to
      % the Sun/Moon, with the observer at H1 = 0.
      %
      % Mostly, the vertical path is not wanted, and either H2 or ANGLE will
      % be set to a non-zero value (but not both). If both are given as zero
      % that is equivalent to the vertical path geometry.
      %
      % Note that use of this function will automatically set the path
      % type ITYPE to 3 for the solar/lunar irradiance mode.
      %
      % See Also : SetRadTransPathGeom
      
      %% Perform some input checking
      if ~isscalar(MC)
        error('Mod5:SetIrradPathGeom:OnlyScalarCases','Only scalar MODTRAN cases are handled by SetIrradPathGeom.');
      end
      % Firstly, this is the wrong function for non-irradiance modes
      if MC.IEMSCT ~= 3
        error('Mod5:SetIrradPathGeom:WrongIEMSCT', ...
          'This is the wrong function for non-irradiance cases. Use SetRadTransPathGeom instead, or set IEMSCT to 3 for an irradiance computation.')
      end
      % if inputs don't exist, make them zero
      if ~exist('H1', 'var'), H1 = 0; end;
      if ~exist('H2', 'var'), H2 = 0; end;
      if ~exist('ANGLE', 'var'), ANGLE = 0; end;
      if ~exist('IDAY', 'var'), IDAY = 0; end;
      if ~exist('RO', 'var'), RO = 0; end;
      if ~exist('ISOURC', 'var'), ISOURC = 0; end;
      if ~exist('ANGLEM', 'var'), ANGLEM = 0; end;
      assert(Mod5.ScalarNumPos(H1, H2, ANGLE, IDAY, RO, ISOURC, ANGLEM), 'Mod5:SetIrradPathGeom:ScalarNum', ...
        'All inputs to SetIrradPathGeom must be scalar, numeric and >= 0. ITYPE will be set to 3.');
      MC.ITYPE = 3; % Set an irradiance mode computation
      %% Go ahead and set the parameters
      MC.H1 = H1;
      MC.H2 = H2;
      MC.ANGLE = ANGLE;
      MC.IDAY = IDAY;
      MC.RO = RO;
      MC.ISOURC = ISOURC;
      MC.ANGLEM = ANGLEM;
     end % SetIrradPathGeom
    function MC = SetScatGeom(MC, IPARM, IDAY, ISOURC, PARM, TIME, PSIPO, ANGLEM)
      % SetScatGeom: Set the solar/lunar radiation scattering geometry for a Mod5
      %
      % Usage:
      %  MC = MC.SetScatGeom(IPARM, IDAY, ISOURC, PARM, TIME, PSIPO, ANGLEM)
      %
      %  Not all parameters are required in every case. The parameters
      %  required depend on the value of IPARM. Parameters not required
      %  should be set empty [].
      %
      % NOTE : Longitudes in MODTRAN are given positive WEST of Greenwich,
      %        which is an unusual convention.
      %
      % Inputs:
      %   IPARM selects a combination of parameters that define the scattering
      %     geometry. The parameters are then given in the vector input PARM.
      %     For IPARM = 0, specify the following:
      %        PARM(1) = Observer/Sensor Latitude (-90° to +90°)
      %        PARM(2) = Observer/Sensor Longitude (0° to 360° West of Greenwich)
      %        PARM(3) = Solar/Lunar Latitude
      %        PARM(4) = Solar/Lunar Longitude
      %       Then also give ...
      %        PSIPO = True Path Azimuth Angle from H1 to H2 (Degrees East
      %                of Due North)
      %        and if the radiation source is the Moon (ISOURC = 1), also
      %        give:
      %        ANGLEM = Moon phase angle (angle formed by Sun, Moon and
      %                 Earth in degrees), 0° represents full Moon.
      %     
      %     For IPARM = 1, specify the following:
      %        PARM(1) = Observer/Sensor Latitude (-90° to +90°)
      %        PARM(2) = Observer/Sensor Longitude (0° to 360° West of Greenwich)
      %       Then also give ...
      %        TIME = Greenwich time (now called UTC) in decimal hours, or
      %               a row vector of [Hours Minutes Seconds].
      %        PSIPO = True Path Azimuth Angle from H1 to H2 (Degrees East
      %                of Due North)
      %        ISOURC cannot specify the Moon in this case (see below).
      %
      %     For IPARM = 2, specify the following:
      %        PARM(1) = Azimuth angle (in degrees) between observer LOS
      %                  and observer to Sun/Moon path
      %        PARM(2) = Solar/lunar zenith angle at observer
      %        and if the radiation source is the Moon (ISOURC = 1), also
      %        give:
      %        ANGLEM = Moon phase angle (angle formed by Sun, Moon and
      %                 Earth in degrees), 0° represents full Moon.
      %
      %     For IPARM = 10, specify the following:
      %        PARM(1) = Latitude at H2 (target) (-90° to +90°)
      %        PARM(2) = Longitude at H2 (target) (0° to 360° West of Greenwich)
      %        PARM(3) = Solar/Lunar Latitude
      %        PARM(4) = Solar/Lunar Longitude
      %       Then also give ...
      %        PSIPO = True Path Azimuth Angle from H2 to H1 (Degrees East
      %                of Due North)
      %        and if the radiation source is the Moon (ISOURC = 1), also
      %        give:
      %        ANGLEM = Moon phase angle (angle formed by Sun, Moon and
      %                 Earth in degrees), 0° represents full Moon.
      %
      %     For IPARM = 11, specify the following:
      %        PARM(1) = Latitude at H2 (target) (-90° to +90°)
      %        PARM(2) = Longitude at H2 (target) (0° to 360° West of Greenwich)
      %       Then also give ...
      %        TIME = Greenwich time (now called UTC) in decimal hours or a
      %               row vector of [Hours Minutes Seconds].
      %        PSIPO = True Path Azimuth Angle from H1 to H2 (Degrees East
      %                of Due North)
      %        ISOURC cannot specify the Moon in this case.
      %
      %     For IPARM = 12, specify the following:
      %        PARM(1) = Relative solar/lunar azimuth at H2 (target),
      %                  specified in degrees East of North.
      %        PARM(2) = Solar Zenith angle at H2 (target).
      %       Then also give ...
      %        ANGLEM = Moon phase angle (angle formed by Sun, Moon and
      %                 Earth in degrees), 0° represents full Moon.
      %
      % Input IDAY is the day of the year from 1 to 365. Instead of the day
      %  number, you can also give the date in a three-element row vector
      %  having [Year Month Day]. The day number allows correction of
      %  the solar irradiance at the Earth (or Moon as a secondary source)
      %  due to the seasonal variation in Sun-Earth distance. For 
      %  IPARM = 1 or 11, IDAY is used together with TIME to compute
      %  the position of the Sun in the sky.
      %
      % Input ISOURC specifies whether the Sun or the Moon is to be used
      %  as the exoatmospheric source of scattered radiation. Use 
      %  ISOURC = 0 for the Sun and use ISOURC = 1 for the Moon. Note 
      %  that MODTRAN5 does not have the capability to compute the
      %  position of the Moon, and therefore you cannot specify 
      %  ISOURC = 1 in combination with IPARM = 1 or 11. Doing so will
      %  generate an error. Also note that if you specify ISOURC = 1 (Moon),
      %  you must also give the lunar phase angle ANGLEM.
      %
      % Notes:
      % IPARM = 0, 1 or 2 are typically for ground-based sensor/observer,
      % while IPARM = 10, 11 or 12 are commonly used for space-based
      % sensors.
      %
      % For IPARM = 0 and 1, the azimuth angle PSIPO is given from H1 to
      % H2. For IPARM = 10 or 11, PSIPO is the back-bearing azimuth from
      % H2 to H1.
      %
      % There is an ephemeris code to compute the phase angle and position
      % of the Moon for any date/time and location called MoshierMoon
      % for Matlab, by this author. There are numerous other ephemeris
      % codes of varying levels of accuracy available.
      %
     
      
      %% Input checking
      % This function is only for IEMSCT = 2, and IEMSCT is set to 2 if not
      if MC.IEMSCT ~= 2
        warning('Mod5:SetScatGeom:IMESCTnot2','SetScatGeom is only used for a Mod5 having IEMSCT = 2 (See Card 1). IEMSCT will be set to 2.')
      end
      % Input case must be scalar
      assert(isscalar(MC),'Mod5:SetScatGeom:OnlyScalarCases','SetScatGeom only handles scalar Mod5s.');
      assert(exist('IPARM', 'var') && isscalar(IPARM) && isnumeric(IPARM) && any(IPARM == [0 1 2 10 11 12]), 'Mod5:SetScatGeom:BadIPARM', ...
        'Input IPARM must be scalar, numeric and one of 0, 1, 2, 10, 11 or 12.');
      
      % Check IDAY
      if ~exist('IDAY', 'var') || isempty(IDAY)
        IDAY = 93;
      end
      assert(isnumeric(IDAY) && (numel(IDAY) == 3 || isscalar(IDAY)), 'Mod5:SetScatGeom:BadIDAY', ...
        'Input IDAY (day of year) must be a numeric scalar or a vector of length 3 [Year Month Day].');
      % Compute day of year if IDAY given as a three element date
      if numel(IDAY) == 3
        IDAY = datenum(IDAY) - datenum([IDAY(1) 1 1]) + 1; % Find the day number from the date
      end
      
      % Check ISOURC
      if ~exist('ISOURC', 'var') || isempty(ISOURC)
        ISOURC = 0; % Sun, default
      end
      assert(isscalar(ISOURC) && isnumeric(ISOURC) && any(ISOURC == [0 1]), 'Mod5:SetScatGeom:BadISOURC', ...
        'Input ISOURC (extraterrestrial radiation source) must be scalar, numeric and either 0 (Sun) or 1 (Moon).');
      
      % Check TIME if it exists
      if exist('TIME', 'var') && ~isempty(TIME)
        if isnumeric(TIME) && (numel(TIME) == 1 || numel(TIME) == 3) && TIME(1) >= 0 && TIME(1) <= 24
          if numel(TIME) == 3 % Convert [Hours Mins Secs] to decimal hours
            TIME = TIME(1) + TIME(2)/60 + TIME(3)/3600;
          end
        else
          error('Mod5:SetScatGeom:BadTIME','Input TIME (time of day) must be decimal hours (0 to 24) or a 3-element vector [H M S].');
        end
      else
        TIME = [];
      end
      
      % Check PSIPO if it exists
      if exist('PSIPO', 'var') && ~isempty(PSIPO)
        assert(isscalar(PSIPO) && isnumeric(PSIPO) && PSIPO >= 0 && PSIPO <= 360, 'Mod5:SetScatGeom:BadPSIPO', ...
          'Input PSIPO (azimuth H1 to H2 or H2 to H1) must be scalar numeric and from 0 to 360 degrees.');
      else
        PSIPO = [];
      end
      
      % Check ANGLEM if it exists
      if exist('ANGLEM', 'var') && ~isempty(ANGLEM)
        assert(isscalar(ANGLEM) && isnumeric(ANGLEM) && ANGLEM >= -180 && ANGLEM <= 180, 'Mod5:SetScatGeom:BadANGLEM', ...
          'Input ANGLEM (Lunar phase angle) must be scalar, numeric and from -180 to 180 degrees.');
      else
        ANGLEM = [];
      end
      
      %% Perfrom additional validation inside IPARM cases
      % The remainder of checking is performed inside the switch statement
      %
      switch IPARM
        case 0 % Sensor and source lat/long, true path azimuth and lunar phase angle (if Moon)
          % Check PARMs
          assert(exist('PARM', 'var') && isnumeric(PARM) && numel(PARM) == 4, 'Mod5:SetScatGeom:BadPARM', ...
            'Input PARM (scattering geometry parameters) must be numeric and a vector of length 4 for IPARM = 0.');
          assert(all(PARM([1 3]) >= -90) && all(PARM([2 4]) <= 90) && all(PARM([2 4]) >= 0) && all(PARM([2 4]) <= 360), 'Mod5:SetScatGeom', ...
            'Inputs PARM(1) and PARM(3), (latitudes) must be -90 to 90 deg, and PARM(2) and PARM(4) (longitudes) must be 0 to 360 deg.');
          % Check TIME input
          if ~isempty(TIME)
            warning('Mod5:SetScatGeom:TIMEisNotUsed','Input TIME (UTC) is not used for IPARM = 0 and has been ignored.');
          end
          TIME = 0;
          % Check PSIPO and ANGLEM
          if isempty(PSIPO)
            error('Mod5:SetScatGeom:PSIPOisMandatory','Input PSIPO (azimuth angle from H1 to H2) is required for IPARM = 0.');
          end
          if ISOURC == 1 % If Moon the ANGLEM is required
            if isempty(ANGLEM)
              error('Mod5:SetScatGeom','Input ANGLEM (lunar phase angle) is required for IPARM = 0 and ISOURC = 1.')
            end
          else % ANGLEM is not required and is ignored is specified
            if ~isempty(ANGLEM)
              warning('Mod5:SetScatGeom:ANGLEMisNotUsed', ...
                'Input ANGLEM (lunar phase angle) is not used for IPARM = 0 with ISOURC = 0, and has been ignored.');
              ANGLEM = 0;
            end
          end
        case 1 % Observer/sensor lat/long, time and true path azimuth, (Moon not allowed)
          assert(ISOURC == 0, 'Mod5:SetScatGeom:MoonNotAllowed', ...
            'Input ISOURC = 1 (extraterrestrial source is Moon) is not allowed for IPARM = 1.')
          % Check PARMs
          assert(exist('PARM', 'var') && isnumeric(PARM) && numel(PARM) == 2, 'Mod5:SetScatGeom:BadPARM', ...
            'Input PARM (scattering geometry parameters) must be numeric and a vector of length 2 for IPARM = 1.');
          assert(PARM(1) >= -90 && PARM(1) <= 90 && PARM(2) >= 0 && PARM(2) <= 360, 'Mod5:SetScatGeom', ...
            'Input PARM(1) (latitude of observer) must be -90 to 90 deg, and PARM(2) (longitude) must be 0 to 360 deg.');
          PARM(3) = 0;
          PARM(4) = 0;          
          % Check TIME is given
          assert(~isempty(TIME),'Mod5:SetScatGeom:TIMEisMandatory', ...
            'Input TIME (UTC) is required for IPARM = 1.');
          % Check PSIPO is there
          if isempty(PSIPO)
            error('Mod5:SetScatGeom:PSIPOisMandatory','Input PSIPO (azimuth angle from H1 to H2) is required for IPARM = 1.');
          end
          if ~isempty(ANGLEM)
            warning('Mod5:SetScatGeom:ANGLEMisIgnored','Input ANGLEM (lunar phase angle) is not used for IPARM = 1 and has been ignored.');
          end
          ANGLEM = 0;          
        case 2 % Azimuth angle between LOS and sightline to Sun/Moon, Zenith angle of Sun/Moon at H1, together with lunar phase angle (if required)
          % Check PARMs
          assert(exist('PARM', 'var') && isnumeric(PARM) && numel(PARM) == 2, 'Mod5:SetScatGeom:BadPARM', ...
            'Input PARM (scattering geometry parameters) must be numeric and a vector of length 2 for IPARM = 2.');
          assert(PARM(1) >= 0 && PARM(1) <= 360 && PARM(2) >= 0 && PARM(2) <= 90, 'Mod5:SetScatGeom', ...
            'Input PARM(1) (azimuth angle between LOS and Source) must be 0 to 360 deg, and PARM(2) (source zenith angle at H1) must be 0 to 90 deg.');
          PARM(3) = 0;
          PARM(4) = 0;          
          % Check TIME input
          if ~isempty(TIME)
            warning('Mod5:SetScatGeom:TIMEisNotUsed','Input TIME (UTC) is not used for IPARM = 2 and has been ignored.');
          end
          TIME = 0;
          % Check PSIPO input
          if ~isempty(PSIPO)
            warning('Mod5:SetScatGeom:PSIOPOisNotUsed','Input PSIPO (LOS azimuth) is not used for IPARM = 2 and has been ignored.');
          end
          PSIPO = 0;
          % Check ANGLEM
          if ISOURC == 1 % If Moon the ANGLEM is required
            if isempty(ANGLEM)
              error('Mod5:SetScatGeom','Input ANGLEM (lunar phase angle) is required for IPARM = 2 and ISOURC = 1.')
            end
          else % ANGLEM is not required and is ignored is specified
            if ~isempty(ANGLEM)
              warning('Mod5:SetScatGeom:ANGLEMisNotUsed','Input ANGLEM (lunar phase angle) is not used for IPARM = 2 and has been ignored.');
              ANGLEM = 0;
            end
          end
          
        case 10 % Target (H2) and source lat/long, true path azimuth and lunar phase angle (if Moon)
          % Check PARMs
          assert(exist('PARM', 'var') && isnumeric(PARM) && numel(PARM) == 4, 'Mod5:SetScatGeom:BadPARM', ...
            'Input PARM (scattering geometry parameters) must be numeric and a vector of length 4 for IPARM = 10.');
          assert(all(PARM([1 3]) >= -90) && all(PARM([2 4]) <= 90) && all(PARM([2 4]) >= 0) && all(PARM([2 4]) <= 360), 'Mod5:SetScatGeom', ...
            'Inputs PARM(1) and PARM(3), (latitudes) must be -90 to 90 deg, and PARM(2) and PARM(4) (longitudes) must be 0 to 360 deg.');
          % Check TIME input
          if ~isempty(TIME)
            warning('Mod5:SetScatGeom:TIMEisNotUsed','Input TIME (UTC) is not used for IPARM = 10 and has been ignored.');
          end
          TIME = 0;
          % Check PSIPO and ANGLEM
          if isempty(PSIPO)
            error('Mod5:SetScatGeom:PSIPOisMandatory','Input PSIPO (azimuth angle from H2 to H1) is required for IPARM = 10.');
          end
          if ISOURC == 1 % If Moon the ANGLEM is required
            if isempty(ANGLEM)
              error('Mod5:SetScatGeom','Input ANGLEM (lunar phase angle) is required for IPARM = 10 and ISOURC = 1.')
            end
          else % ANGLEM is not required and is ignored if specified
            if ~isempty(ANGLEM)
              warning('Mod5:SetScatGeom:ANGLEMisNotUsed', ...
                'Input ANGLEM (lunar phase angle) is not used for IPARM = 10 with ISOURC = 0, and has been ignored.');
              ANGLEM = 0;
            end
          end          
        case 11 % Target (H2) lat/long, time and true path azimuth (Moon not allowed)
          assert(ISOURC == 0, 'Mod5:SetScatGeom:MoonNotAllowed', ...
            'Input ISOURC = 1 (extraterrestrial source is Moon) is not allowed for IPARM = 11.')          
          % Check PARMs
          assert(exist('PARM', 'var') && isnumeric(PARM) && numel(PARM) == 2, 'Mod5:SetScatGeom:BadPARM', ...
            'Input PARM (scattering geometry parameters) must be numeric and a vector of length 2 for IPARM = 11.');
          assert(PARM(1) >= -90 && PARM(1) <= 90 && PARM(2) >= 0 && PARM(2) <= 360, 'Mod5:SetScatGeom', ...
            'Input PARM(1) (latitude of observer) must be -90 to 90 deg, and PARM(2) (longitude) must be 0 to 360 deg.');
          PARM(3) = 0;
          PARM(4) = 0;
          % Check TIME is given
          assert(~isempty(TIME),'Mod5:SetScatGeom:TIMEisMandatory', ...
            'Input TIME (UTC) is required for IPARM = 11.');
          % Check PSIPO is there
          if isempty(PSIPO)
            error('Mod5:SetScatGeom:PSIPOisMandatory','Input PSIPO (azimuth angle from H2 to H1) is required for IPARM = 11.');
          end
          if ~isempty(ANGLEM)
            warning('Mod5:SetScatGeom:ANGLEMisIgnored','Input ANGLEM (lunar phase angle) is not used for IPARM = 11 and has been ignored.');
          end
          ANGLEM = 0;          
        case 12 % Relative solar/lunar azimuth and solar/lunar zenith angle measured at the target (H2) 
          % Check PARMs
          assert(exist('PARM', 'var') && isnumeric(PARM) && numel(PARM) == 2, 'Mod5:SetScatGeom:BadPARM', ...
            'Input PARM (scattering geometry parameters) must be numeric and a vector of length 2 for IPARM = 12.');
          assert(PARM(1) >= 0 && PARM(1) <= 360 && PARM(2) >= 0 && PARM(2) <= 90, 'Mod5:SetScatGeom', ...
            'Input PARM(1) (relative solar/lunar azimuth angle at H2) must be 0 to 360 deg, and PARM(2) (source zenith angle at H2) must be 0 to 90 deg.');
          PARM(3) = 0;
          PARM(4) = 0;          
          % Check TIME input
          if ~isempty(TIME)
            warning('Mod5:SetScatGeom:TIMEisNotUsed','Input TIME (UTC) is not used for IPARM = 12 and has been ignored.');
          end
          TIME = 0;
          % Check PSIPO input
          if ~isempty(PSIPO)
            warning('Mod5:SetScatGeom:PSIOPOisNotUsed','Input PSIPO (LOS azimuth) is not used for IPARM = 12 and has been ignored.');
          end
          PSIPO = 0;
          % Check ANGLEM
          if ISOURC == 1 % If Moon the ANGLEM is required
            if isempty(ANGLEM)
              error('Mod5:SetScatGeom','Input ANGLEM (lunar phase angle) is required for IPARM = 12 and ISOURC = 1.')
            end
          else % ANGLEM is not required and is ignored is specified
            if ~isempty(ANGLEM)
              warning('Mod5:SetScatGeom:ANGLEMisNotUsed','Input ANGLEM (lunar phase angle) is not used for IPARM = 12 and has been ignored.');
              ANGLEM = 0;
            end
          end
          
      end
      % Set the values in the case
      MC.IEMSCT = 2;
      MC.IPARM = IPARM;
      MC.IDAY = IDAY;
      MC.ISOURC = ISOURC;
      MC.PARM1 = PARM(1);
      MC.PARM2 = PARM(2);
      MC.PARM3 = PARM(3);
      MC.PARM4 = PARM(4);
      MC.TIME = TIME;
      MC.PSIPO = PSIPO;
      MC.ANGLEM = ANGLEM;
      % Issue a warning if aerosol phase function IPH and G have not been set.
      if isempty(MC.IPH)
        warning('Mod5:SetScatGeom:IPHisEmpty', ...
          'The property IPH (Aerosol phase function control flag) has not been set. IPH has been set to 2 (Mie-calculated phase functions) and G to 0.');
        MC.IPH = 2;
        MC.G = 0;
      end
    end % SetScatGeom
    function MC = SetSpectralRange(MC, V1, V2, DV, FWHM, Units, ConvShape, FWHMisRelative)
      % SetSpectralRange : Set the spectral range of the MODTRAN computation
      %
      % Usage :
      %
      %  MC = MC.SetSpectralRange(V1, V2, DV, FWHM, Units, ConvShape, FWHMisRelative)
      %
      %  Where V1 is the starting wavenumber or wavelength (as defined by Units input)
      %        V2 is the final wavenumber or wavelength
      %        DV is the spectral increment in wavenumbers or wavelength
      %        FWHM is the full-width-at-half-maximum of the convolution
      %             (instrument slit) function expressed as an absolute
      %             wavenumber or wavelength (default), or expressed as a 
      %             percentage of wavelength or wavenumber if the input
      %             flag FWHMisRelative is set non-zero.
      %        Units gives the units of V1, V2, DV and absolute FWHM
      %           Choose one of:
      %           'W' for wavenumber in cm^-1
      %           'M' for wavelength in microns
      %           'N' for wavelength in nanometres
      %        ConvShape is the shape of the convolution (instrument slit)
      %             function. Choose from the following :
      %          '1' or 'T' for triangular (default if ConvShape is omitted)
      %          '2' or 'R' for rectangular function.
      %          '3' or 'G' for Gaussian function.
      %          '4' or 'S' for Sinc function.
      %          '5' or 'C' for Sinc-squared function.
      %          '6' or 'H' for Hamming function.
      %          '7' or 'U' for user-defined function.
      %        FWHMisRelative is an optional flag that if set non-zero
      %          means that the FWHM is a percentage of the wavelength or
      %          wavenumber.
      %
      %  V1, V2, DV, FWHM and Units are mandatory inputs.
      
      % The set function for the relevant inputs should do most of the
      % checking.
      
      assert(isscalar(MC), 'Mod5:SetSpectralRange:OnlyScalarCases','Only scalar Mod5''s are currently handled by this function.')
      assert(V2 > V1, 'Mod5:SetSpectralRange:BadV', ...
        'Input V2 (final wavelength/wavenumber) must be greater than V1 (initial wavelength/wavenumber).');
      if ~exist('ConvShape', 'var')
        ConvShape = ' ';
      end
      if ~exist('FWHMisRelative', 'var')
        FWHMisRelative = 0; % Absolute by default
      else
        assert(isscalar(FWHMisRelative) && isnumeric(FWHMisRelative), 'Mod5:SetSpectralRange:BadFWHMisRelative', ...
          'Input FWHMisRelative to function SetSpectralRange must be a scalar, numeric flag.');
      end
      % Set the values in the instance
      MC.V1 = V1;
      MC.V2 = V2;
      MC.DV = DV;
      MC.FWHM = FWHM;
      MC.FLAGS(1) = Units;
      MC.FLAGS(2) = ConvShape; 
      if FWHMisRelative
        AbsFWHM = [V1 V2] * FWHM ./ 100; % Compute absolute FWHM at both limits of the spectral range
        if any(DV > AbsFWHM./2)
          warning('Mod5:SetSpectralRange:DVtooBig','DV should not exceed FWHM. The recommended value for DV is the absolute FWHM/2.')
        end
        MC.FLAGS(3) = 'R'; % Relative FWHM in percent
      else
        if DV > FWHM/2
          warning('Mod5:SetSpectralRange:DVtooBig','DV should not exceed FWHM. The recommended value for DV is the absolute FWHM/2.')          
        end
        MC.FLAGS(3) = 'A'; % Absolute FWHM in wavenumbers or wavelength
      end
    end % SetSpectralRange
    function MC = SetPlot(MC, YFLAG, XFLAG, DLIMIT)
      % SetPlot : Set plot-related inputs on Card 4
      %
      % Usage :
      % 
      %  MC = MC.SetPlot(YFLAG, XFLAG, DLIMIT)
      %
      % Where:
      %   YFLAG must be one of the following :
      %     ' ' (single blank) for no output to .plt and .psc files
      %     'T' to output transmittance data to .plt and .psc files
      %     'R' to output radiance data to .plt and .psc files
      %
      %   XFLAG controls the units for the data output to .plt and .psc files
      %     ' ' (single blank) for no output to .plt and .psc files
      %     'W' to output frequency in wavenumbers (cm^-1) and radiances in
      %         W/sr/cm^2/cm^-1
      %     'M' to output wavelength in microns and radiances in
      %         W/sr/cm^2/µm
      %     'N' to output wavelength in nanometres and radiances in
      %         µW/sr/cm^2/nm
      %
      %   DLIMIT is a character string of up to 8 characters used to
      %         delimit multiple plots written to .plt and .psc files
      %
      % XFLAG, YFLAG and DLIMIT will default to blanks if omitted.
      %
      % Example :
      %
      %  MC = MC.SetPlot;   % No plot data will be written to .psc and .plt
      %
      
      % Input checking will be left to the set methods
      % Just provide some defaults
      if ~exist('YFLAG', 'var') || isempty(YFLAG)
        YFLAG = ' ';
      end
      if ~exist('XFLAG', 'var') || isempty(XFLAG)
        XFLAG = ' ';
      end
      if ~exist('DLIMIT', 'var') || isempty(DLIMIT)
        DLIMIT = '        ';
      end
      
      MC.YFLAG = YFLAG;
      MC.XFLAG = XFLAG;
      MC.DLIMIT = DLIMIT;
    end % SetPlot
    function MC = CreateSeries(MC, varargin)
      % CreateSeries : Generate a set of cases with varying MODTRAN parameters
      %
      % Usage :
      %   SS = MC.CreateSeries(ParamName1, ParamValues1, ParamName2, ParamValues2, ...)
      %
      % Input MC is a scalar Mod5 which serves as a basis for the
      %  sensitivity analysis.
      %
      % ParamNameN is the name of the MOTRAN parameter to vary. ParamName must
      %  be a valid MODTRAN parameter name .e.g. 'MODEL'.
      % ParamValuesN is a vector of values to assign to the subcases.
      % ParamValues must be a cell array of numerics, or a cell array of strings if
      %  the MODTRAN parameter is a string.
      % 
      % The output, SS is a matrix of MODTRAN sub-cases, with ParamName1 varying
      %  down columns, ParamName2 varying across rows and ParamNameN varying
      %  in the Nth dimension. That is, EVERY combination of the variable
      %  parameters is generated. If there are 2 values for ParamName1, 
      %  5 values for ParamName2 and 2 values for ParamName3, there will
      %  be a total of 20 subcases in the generated Mod5 (SS).
      %
      % In order to make the results from the different sub-cases easy
      %  to compare, it is best not to vary parameters such as V1, V2, DV,
      %  FWHM (indeed any parameter on the spectral range and resolution card).
      %
      % Clearly it would also not make sense to compare a transmission run
      %  (IEMSCT = 0) with a radiance run (IEMSCT = 2 or 3). However, it
      %  could certainly make sense to compare an IEMSCT = 2 with an
      %  IEMSCT = 3 run.
      %
      % This function does no checking to see if the sub-cases can be
      %  compared easily. The user is free to vary any parameter. Of
      %  course, this could result in cases that MODTRAN will not accept.
      %
      % The entire sensitivity series is run with a single call to the Run
      %  method. High dimensional sensitivity series can take a long time.
      %
      % Example :
      %
      %  SS = MC.CreateSeries('MODEL', {1 2 3 4 5 6});
      %
      % The above example starts with a scalar Mod5 (MC) and
      % creates another Mod5 (SS) having 6 sub-cases with
      % different canned atmospheres (1 through 6). 
      %
      %  SS = MC.CreateSeries('MODEL', {1 2 3 4 5 6}, 'IEMSCT', {2 3})
      %
      % The above example creates 12 subcases with the canned atmosphere
      %   varying down the columns of the case matrix, with IEMSCT = 2
      %  (thermal radiance mode) in the first column and IEMSCT = 3
      %  (thermal radiance + scattered solar/lunar radiance) in the second
      %  column.
      %
      % Sometimes it is useful to perform a sensitivity series in which
      %  only the minimum and maximum expected values for certain parameters
      %  are given. By obtaining minimum and maximum values for the results
      %  in question, the overall range of the expected output parameter(s)
      %  can be determined.
      
      assert(isscalar(MC), 'Mod5:CreateSeries:OnlyScalarCases',...
        'The base Mod5 must be scalar (have a single element).');
      % Must be even number of parameters in varargin
      if rem(numel(varargin), 2) % odd
        error('Mod5:CreateSeries:OddArgs','The number of input arguments was odd. There must be an even number of parameters.');
      end
      % Verify that all parameter names are character strings and that values are either numeric or cell arrays of strings.
      nTotalSubCases = 1;
      nParm = numel(varargin)/2;
      CaseShape = [];
      for iParm = 1:2:(numel(varargin)-1)
        assert(ischar(varargin{iParm}), 'Mod5:CreateSeries', ...
          'MODTRAN parameter names (ParamNameN) must be character strings in single quotes.');
        assert(iscell(varargin{iParm + 1}) || isnumeric(varargin{iParm + 1}), 'Mod5:CreateSeries:BadArgs', ...
          'MODTRAN parameter values must be a cell array.');
        nTotalSubCases = nTotalSubCases * numel(varargin{iParm + 1});
        CaseShape = [CaseShape numel(varargin{iParm + 1})];
      end
      % Now go ahead and generate the series
      % Get the parameter names in a single cellstring
      ParamNames = {varargin{1:2:end}};
      ParamValues = {varargin{2:2:end}};
      MC.IRPT = 1; % Ensure that all sub-cases are run by MODTRAN
      % Create the array of sub-cases in the right shape
      if nParm == 1
        MC = repmat(MC, [CaseShape 1]);
      else
        MC = repmat(MC, CaseShape);
      end
      MC(end).IRPT = 0; % Stop MODTRAN at the last subcase
      for iParm = 1:nParm
        if nParm == 1
          ParamShape = [numel(ParamValues{iParm}) 1];
        else
          ParamShape = ones(1,nParm);
          ParamShape(iParm) = numel(ParamValues{iParm});
        end
        % Reshape the values into the iParm^th dimension 
        Values = reshape(ParamValues{iParm},ParamShape);
        % Replicate the values into the other dimensions
        ParamShape = CaseShape;
        ParamShape(iParm) = 1;
        Values = repmat(Values, ParamShape);
        % Assign the values to the parameters
        [MC(:).(ParamNames{iParm})] = Values{:};
      end
      %% ReIndex and set up all CaseName properties
      MC = MC.ReIndex(MC(1).CaseName);
    end % CreateSeries
    function MC = CreateOptDepthCase(MC)
        % CreateOptDepthCase : Create case for computing the vertical optical thicknesses
        %
        % Usage :
        %    MC = CreateOptDepthCase(MC);
        % 
        % This function takes an existing shortwave case set and changes
        % them to a set of cases that compute vertical transmission from
        % ground to space. This is useful for confirmation of the aerosol
        % optical thickness as may be measured by a sunphotometer.
        %
        % MC is the input case for which the output spectral optical thicknesses are desired.
        % Generally a new output case will be created. The case name is the
        % same as that of the input case, but with '~OD' appended.
        %
        % Note that "optical thickness" means the same as "optical depth".
        %
        % See Also : MODTRAMCase.ComputeOptDepth
        
        % Switch the case to direct solar irradiance
        for iCase = 1:numel(MC)
            MC(iCase).CaseName = [MC(iCase).CaseName '~OD'];
            MC(iCase).ITYPE = 3; % vertical path from ground to space
            MC(iCase).IEMSCT = 0;
            MC(iCase).IMULT = 0; % No multiple scattering relevant to direct solar irradiance
            MC(iCase).DIS = 'f';
            % Remove anything to do with surface albedo
            MC(iCase).SURREF = '';
            MC(iCase).SALBFL = '';
            MC(iCase).CSALB = '';
            MC(iCase).alb = [];
            
            % Make path geometry from ground to space
            MC(iCase).H1 = 0;
            MC(iCase).H2 = 0;
            MC(iCase).ANGLE = 0;
            MC(iCase).PHI = 0;
            % Clobber outputs
            MC(iCase).tp7 = [];
            MC(iCase).sc7 = [];
        end
        
    end % CreateOptDepthCase    
    function MC = ComputeOptDepth(MC)
        % ComputeOptDepth : Compute optical depth results from transmittances
        %
        % Usage :
        %   MC = ComputeOptDepth(MC);
        %
        % This function will identify transmittance results in the sc7 and
        % tp7 outputs and add a corresponding optical depth. The optical
        % depth is -log(transmittance).
        %
        % See also : Mod5.CreateOptDepthCase
        for iC = 1:numel(MC)
            if ~isempty(MC(iC).tp7)
                for iH = 1:numel(MC(iC).tp7.Headers)
                    switch MC(iC).tp7.Headers{iH}
                        case 'H2OTRANS', MC(iC).tp7.H2OOD = -log(MC(iC).tp7.H2OTRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'H2OOD'];
                        case 'CO2PTRANS', MC(iC).tp7.CO2OD = -log(MC(iC).tp7.CO2PTRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'CO2OD'];                            
                        case 'O3TRANS', MC(iC).tp7.O3OD = -log(MC(iC).tp7.O3TRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'O3OD'];                            
                        case 'TRACETRANS', MC(iC).tp7.TRACEOD = -log(MC(iC).tp7.TRACETRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'TRACEOD'];                            
                        case 'N2CONT', MC(iC).tp7.N2CONTOD = -log(MC(iC).tp7.N2CONT);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'N2CONTOD'];                            
                        case 'H2OCONT', MC(iC).tp7.H2OCOD = -log(MC(iC).tp7.H2OCONT);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'H2OCOD'];                            
                        case 'MOLECSCAT', MC(iC).tp7.MOLECOD = -log(MC(iC).tp7.MOLECSCAT);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'MOLECOD'];                            
                        case 'AERTRANS', MC(iC).tp7.AEROD = -log(MC(iC).tp7.AERTRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'AEROD'];                            
                        case 'HNO3TRANS', MC(iC).tp7.HNO3OD = -log(MC(iC).tp7.HNO3TRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'HNO3OD'];                            
                        case 'AERABTRANS', MC(iC).tp7.AERABOD = -log(MC(iC).tp7.AERABTRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'AERABOD'];                            
                        case 'CO2TRANS', MC(iC).tp7.CO2OD = -log(MC(iC).tp7.CO2TRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'CO2OD'];                            
                        case 'COTRANS', MC(iC).tp7.COOD = -log(MC(iC).tp7.COTRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'COOD'];                            
                        case 'CH4TRANS', MC(iC).tp7.CH4OD = -log(MC(iC).tp7.CH4TRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'CH4OD'];                            
                        case 'N2OTRANS', MC(iC).tp7.N2OOD = -log(MC(iC).tp7.N2OTRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'N2OOD'];                            
                        case 'O2TRANS', MC(iC).tp7.O2OD = -log(MC(iC).tp7.O2TRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'O2OD'];                            
                        case 'NH3TRANS', MC(iC).tp7.NH3OD = -log(MC(iC).tp7.NH3TRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'NH3OD'];                            
                        case 'NOTRANS', MC(iC).tp7.NOOD = -log(MC(iC).tp7.NOTRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'NOOD'];                            
                        case 'NO2TRANS', MC(iC).tp7.NO2OD = -log(MC(iC).tp7.NO2TRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'NO2OD'];                            
                        case 'SO2TRANS', MC(iC).tp7.SO2OD = -log(MC(iC).tp7.SO2TRANS);
                            MC(iC).tp7.Headers = [MC(iC).tp7.Headers 'SO2OD'];                            
                    end
                end
                % Lookup all the headers again
                MC(iC).tp7.HeadDescr = Mod5.LookupHeaders(MC(iC).tp7.Headers);
            end
            if ~isempty(MC(iC).sc7)
                for iH = 1:numel(MC(iC).sc7.Headers)
                    switch MC(iC).sc7.Headers{iH}
                        case 'H2OTRANS', MC(iC).sc7.H2OOD = -log(MC(iC).sc7.H2OTRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'H2OOD'];
                        case 'CO2PTRANS', MC(iC).sc7.CO2OD = -log(MC(iC).sc7.CO2PTRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'CO2OD'];                            
                        case 'O3TRANS', MC(iC).sc7.O3OD = -log(MC(iC).sc7.O3TRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'O3OD'];                            
                        case 'TRACETRANS', MC(iC).sc7.TRACEOD = -log(MC(iC).sc7.TRACETRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'TRACEOD'];                            
                        case 'N2CONT', MC(iC).sc7.N2CONTOD = -log(MC(iC).sc7.N2CONT);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'N2CONTOD'];                            
                        case 'H2OCONT', MC(iC).sc7.H2OCOD = -log(MC(iC).sc7.H2OCONT);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'H2OCOD'];                            
                        case 'MOLECSCAT', MC(iC).sc7.MOLECOD = -log(MC(iC).sc7.MOLECSCAT);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'MOLECOD'];                            
                        case 'AERTRANS', MC(iC).sc7.AEROD = -log(MC(iC).sc7.AERTRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'AEROD'];                            
                        case 'HNO3TRANS', MC(iC).sc7.HNO3OD = -log(MC(iC).sc7.HNO3TRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'HNO3OD'];                            
                        case 'AERABTRANS', MC(iC).sc7.AERABOD = -log(MC(iC).sc7.AERABTRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'AERABOD'];                            
                        case 'CO2TRANS', MC(iC).sc7.CO2OD = -log(MC(iC).sc7.CO2TRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'CO2OD'];                            
                        case 'COTRANS', MC(iC).sc7.COOD = -log(MC(iC).sc7.COTRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'COOD'];                            
                        case 'CH4TRANS', MC(iC).sc7.CH4OD = -log(MC(iC).sc7.CH4TRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'CH4OD'];                            
                        case 'N2OTRANS', MC(iC).sc7.N2OOD = -log(MC(iC).sc7.N2OTRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'N2OOD'];                            
                        case 'O2TRANS', MC(iC).sc7.O2OD = -log(MC(iC).sc7.O2TRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'O2OD'];                            
                        case 'NH3TRANS', MC(iC).sc7.NH3OD = -log(MC(iC).sc7.NH3TRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'NH3OD'];                            
                        case 'NOTRANS', MC(iC).sc7.NOOD = -log(MC(iC).sc7.NOTRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'NOOD'];                            
                        case 'NO2TRANS', MC(iC).sc7.NO2OD = -log(MC(iC).sc7.NO2TRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'NO2OD'];                            
                        case 'SO2TRANS', MC(iC).sc7.SO2OD = -log(MC(iC).sc7.SO2TRANS);
                            MC(iC).sc7.Headers = [MC(iC).sc7.Headers 'SO2OD'];                            
                    end
                end    
                % Lookup all the headers again
                MC(iC).sc7.HeadDescr = Mod5.LookupHeaders(MC(iC).sc7.Headers);
                
            end
        end
    end % ComputeOptDepth  
  end % Public methods
  methods % set/get methods. These methods are to perform integrity checking on class properties
    % Take note that it is (very) bad practice for a set method to meddle with
    % other non-dependent properties. Issues of cross-dependence between properties
    % are a bit tricky. MODTRAN has a lot of these cross-dependencies, where parameters
    % come and go depending on the values of other parameters. However, the VALUES do
    % not depend on other parameters and therefore these are not 'dependent' properties
    % in the Matlab sense. It appears one can rely on the properties being set or
    % read in the order they appear in the properties section. Therefore it seems
    % to be worth issuing warnings if a property has been set and has a cross
    % dependency with a property appearing before it in the properties section.
    % For examples, see set.USRSUN, set.BMNAME or set.FILTNM.
    % At a minimum, the progress target is to have set methods for all
    % the compulsory cards.
    %% Set methods for non-MODTRAN parameter properties
    function MC = set.CaseName(MC, NewCaseName)
     assert(isscalar(MC), 'Mod5.setCaseName.MustBeScalar', ...
       'Setting of CaseName property only deals with scalar (single) cases. Use a loop to set non-scalar cases.');
     assert(ischar(NewCaseName) && numel(NewCaseName) < 80 && Mod5.isValidFilename(NewCaseName), 'Mod5:setCaseName:BadCaseName', ...
        'Input NewCaseName must be a string of less than 80 characters, that is also a valid filename.');
      MC.CaseName = NewCaseName;
    end % set.CaseName
    %% MODTRAN Card 1 set methods
    function MC = set.MODTRN(MC, newMODTRN) % Band model
     % Perform integrity checks
     % Don't handle non-scalar cases
     assert(isscalar(MC), 'Mod5.setMODTRN.MustBeScalar', ...
       'Setting of MODTRN only deals with scalar (single) cases. Use a loop to set non-scalar cases.');
     assert(ischar(newMODTRN) && numel(newMODTRN)==1,'Mod5:setMODTRN:BadValue', ...
     'Parameter MODTRN on Card 1 must be a single character. The class of the new value was %s.', class(newMODTRN));  
     assert(any(upper(newMODTRN) == 'TM CKFL'), 'Mod5:setMODTRN:BadValue', ...
     'Parameter MODTRN on Card 1 must be one of blank, T, M, C, K, F or L. The value given for MODTRN was ''%s''', newMODTRN);
      MC.MODTRN = newMODTRN;
    end % set.MODTRN
    function MC = set.SPEED(MC, newSPEED) % Algorithm speed
     assert(ischar(newSPEED) && numel(newSPEED)==1,'Mod5:setSPEED:BadValue', ...
     'Parameter SPEED on Card 1 must be a single character. The class of the new value was %s.', class(newSPEED));  
     assert(any(upper(newSPEED) == 'S M'), 'Mod5:setSPEED:BadValue', ...
     'Parameter SPEED on Card 1 must be one of blank, S or M. The value passed in was:%s', newSPEED);
      MC.SPEED = newSPEED;
    end % set.SPEED
    function MC = set.BINARY(MC, newBINARY)
     assert(ischar(newBINARY) && numel(newBINARY) == 1, 'Mod5:setBINARY:BadValue', ...
      'Parameter BINARY on Card 1 must be a single character. The class of the new value was %s.', class(newBINARY));
     assert(any(upper(newBINARY) == 'F T'), 'Mod5:setBINARY:BadValue', ...
      'Parameter BINARY on Card 1 must be one of blank, T or F. The value passed in was:%s', newBINARY);
      if upper(newBINARY) == 'T'
          warning('Mod5:setBINARY:NotSupported','Binary output (switch BINARY on Card 1) is not yet supported in this class wrapper. Output set to ASCII.');
          MC.BINARY = ' ';
      else
          MC.BINARY = newBINARY;
      end
    end % set.BINARY
    function MC = set.LYMOLC(MC, newLYMOLC)
     assert(ischar(newLYMOLC) && numel(newLYMOLC)==1,'Mod5:setLYMOLC:BadValue', ...
     'Parameter LYMOLC on Card 1 must be a single character. The class of the new value was %s.', class(newLYMOLC));  
     assert(any(upper(newLYMOLC) == ' +'), 'Mod5:setLYMOLC:BadValue', ...
     'Parameter LYMOLC on Card 1 must be either blank or ''+''. The value passed in was:%s', newLYMOLC);
      MC.LYMOLC = newLYMOLC;
    end % set.LYMOLC
    function MC = set.MODEL(MC, newMODEL) % Canned atmospheric model
      % Validation of MODEL
      assert(isscalar(MC) && isscalar(newMODEL), 'Mod5:setMODEL:MustBeScalar', ...
        'Inputs to set.MODEL must be scalar.');
      assert(isnumeric(newMODEL) && any(newMODEL == [0 1 2 3 4 5 6 7]), 'Mod5:setMODEL:BadInput', ...
        'New MODEL (atmospheric model) value in set.MODEL must be one of 0,1,2,3,4,5,6 or 7.');
      MC.MODEL = newMODEL;
    end % set.MODEL
    function MC = set.ITYPE(MC, newITYPE) % Line of sight type
      % Validation of ITYPE
      assert(isscalar(MC) && isscalar(newITYPE), 'Mod5:setITYPE:MustBeScalar', ...
        'Inputs to set.ITYPE must be scalar.');
      assert(isnumeric(newITYPE) && any(newITYPE == [1 2 3]), 'Mod5:setITYPE:BadInput', ...
        'New ITYPE (line of sight (LOS) path type) value in set.ITYPE must be one of 1,2 or 3.');
      MC.ITYPE = newITYPE;
    end % set.ITYPE
    function MC = set.IEMSCT(MC, newIEMSCT) % Radiance/Irradiance/Transmittance mode
      % Validation of IEMSCT
      assert(isscalar(MC) && isscalar(newIEMSCT), 'Mod5:setIEMSCT:MustBeScalar', ...
        'Inputs to set.IEMSCT must be scalar.');
      assert(isnumeric(newIEMSCT) && any(newIEMSCT == [0 1 2 3]), 'Mod5:setIEMSCT:BadInput', ...
        'New IEMSCT (radiance/transmittance/irradiance mode) value in set.IEMSCT must be one of 0,1,2 or 3.');
      MC.IEMSCT = newIEMSCT;
    end % set.IEMSCT
    function MC = set.IMULT(MC, newIMULT) % Multiple scattering
      assert(isscalar(MC) && isscalar(newIMULT), 'Mod5:setIMULT:MustBeScalar', ...
        'Inputs to set.IMULT must be scalar.');
      assert(isnumeric(newIMULT) && any(newIMULT == [-1 0 1]), ...
        'Mod5:setIMULT:BadIMULT', 'IMULT (multiple scattering flag)value must be -1, 0 or 1.');
      MC.IMULT = newIMULT;
    end % set.IMULT
    function MC = set.M1(MC, newM1) % Temperature/pressure profile
      MC.ScalarIntNumeric(newM1, 0:6, 'M1');
      MC.M1 = newM1;
    end % set.M1
    function MC = set.M2(MC, newM2) % Water Vapour profile
      MC.ScalarIntNumeric(newM2, 0:6, 'M2');
      MC.M2 = newM2;
    end % set.M2
    function MC = set.M3(MC, newM3) % Ozone profile
      MC.ScalarIntNumeric(newM3, 0:6, 'M3');
      MC.M3 = newM3;
    end % set.M3
    function MC = set.M4(MC, newM4) % CH4 profile
      MC.ScalarIntNumeric(newM4, 0:6, 'M4');
      MC.M4 = newM4;
    end % set.M4
    function MC = set.M5(MC, newM5) % N2O profile
      MC.ScalarIntNumeric(newM5, 0:6, 'M5');
      MC.M5 = newM5;
    end % set.M5
    function MC = set.M6(MC, newM6) % CO profile
      MC.ScalarIntNumeric(newM6, 0:6, 'M6');
      MC.M6 = newM6;
    end % set.M6
    function MC = set.MDEF(MC, newMDEF) % Default O2, NO, SO2, NH3, HNO3 profiles
      MC.ScalarIntNumeric(newMDEF, 0:2, 'MDEF');
      MC.MDEF = newMDEF;
    end % set.MDEF
    function MC = set.I_RD2C(MC, newI_RD2C) % User atmosphere input control
      MC.ScalarIntNumeric(newI_RD2C, 0:1, 'I_RD2C');
      MC.I_RD2C = newI_RD2C;
    end % set.I_RD2C
    function MC = set.NOPRNT(MC, newNOPRNT) % Control outputs to tape6 and tape8
      MC.ScalarIntNumeric(newNOPRNT, -2:1, 'NOPRNT');
      MC.NOPRNT = newNOPRNT;
    end % set.NOPRNT
    function MC = set.SURREF(MC, newSURREF) % Surface reflectance
      assert(isscalar(MC) && ischar(newSURREF) && length(newSURREF(:)) <= 7, 'Mod5:setSURREF:BadInput', ...
        'Case input to set.SURREF must be scalar, SURREF must be a string of length 7 or less.');
      MC.SURREF = newSURREF;
    end % set.SURREF
    %% Card 1A set methods
    function MC = set.DIS(MC, newDIS)
      MC.ScalarChar(newDIS, 'tTfF ', 'DIS');
      if any(newDIS == 'tT') && MC.IMULT == 0
        warning('Mod5:setDISAZM:CheckIMULT', ...
          'DISORT can only be used if multi-scatter is enabled. Check the IMULT parameter.')
      end      
      MC.DIS = newDIS;
    end % set.DIS
    function MC = set.DISAZM(MC, newDISAZM)
      MC.ScalarChar(newDISAZM, 'tTfF ', 'DISAZM');
      % Issue a warning if IMULT not set
      if any(newDISAZM == 'tT') && (MC.IMULT == 0 || ~any(MC.DIS == 'tT'))
        warning('Mod5:setDISAZM:CheckIMULT', ...
          'Azimuthal dependence of multi-scattering only valid if DISORT is requested in multi-scatter mode. Check IMULT and DIS parameters.')
      end
      MC.DISAZM = newDISAZM;
    end % set.DISAZM
    function MC = set.DISALB(MC, newDISALB)
      MC.ScalarChar(newDISALB, 'tTfF ', 'DISALB');
      MC.DISALB = newDISALB;
    end % set.DISALB
    function MC = set.NSTR(MC, newNSTR) % number of streams in DISORT
      MC.ScalarIntNumeric(newNSTR, [0 2 4 8 16], 'NSTR');
      if ~any(newNSTR == [0 2]) && (MC.IMULT == 0 || any(MC.DIS == 'fF '))
        warning('Mod5:setDISAZM:CheckIMULT', ...
          'Setting number of streams (NSTR ~= 0 or 2) only effective if DISORT is requested in multi-scatter mode. Check IMULT and DIS parameters.')
      end
      MC.NSTR = newNSTR;
    end % set.NSTR
%     function MC = set.LSUN(MC, newLSUN)
%       MC.ScalarChar(newLSUN, 'tTfF ', 'LSUN');
%       MC.LSUN = newLSUN;
%     end % set.LSUN
    function MC = set.SFWHM(MC, newSFWHM)
      assert(isnumeric(newSFWHM) && isscalar(newSFWHM), 'Mod5:setSFWHM:BadSFWHM', ...
        'Input SFWHM must be scalar numeric.');
      MC.SFWHM = newSFWHM;
    end % set.SFWHM
    function MC = set.CO2MX(MC, newCO2MX)
      if isempty(newCO2MX)
        newCO2MX = 365; % Default to 365 ppmv
      end
      assert(isscalar(MC) && isscalar(newCO2MX), 'Mod5:setCO2MX:MustBeScalar', ...
        'Inputs to %s be scalar.', mfilename);
      assert(isnumeric(newCO2MX),'Mod5:setCO2MX', ...
        'Input parameter CO2MX must be numeric.');
      MC.CO2MX = newCO2MX;
    end % set.CO2MX 
    function MC = set.H2OSTR(MC, newH2OSTR)
      if isempty(newH2OSTR)
        newH2OSTR = '          ';
      end
      assert(isscalar(MC) && ischar(newH2OSTR) && length(newH2OSTR) <= 10, 'Mod5:setH2OSTR:BadH2OSTR', ...
        'Input H2OSTR must be a string of length 10 or fewer characters.');
      if length(newH2OSTR) < 10
        newH2OSTR = [' ' newH2OSTR blanks(10 - length(newH2OSTR) - 1)];
      end
      MC.H2OSTR = newH2OSTR;
    end % set.H2OSTR
    function MC = set.O3STR(MC, newO3STR)
      if isempty(newO3STR)
        newO3STR = '          ';
      end
      assert(isscalar(MC) && ischar(newO3STR) && length(newO3STR) <= 10, 'Mod5:setO3STR:BadO3STR', ...
        'Input O3STR must be a string of length 10 or fewer characters.');
      if length(newO3STR) < 10
        newO3STR = [' ' newO3STR blanks(10 - length(newO3STR) - 1)];
      end
      MC.O3STR = newO3STR;
    end % set.O3STR
    function MC = set.C_PROF(MC, newC_PROF)
      MC.ScalarChar(newC_PROF, '01234567 ', 'C_PROF');
      MC.C_PROF = newC_PROF;
    end % set.C_PROF
    function MC = set.LSUNFL(MC, newLSUNFL)
      MC.ScalarChar(newLSUNFL, 'tTfF 1234567', 'LSUNFL');
      MC.LSUNFL = newLSUNFL;
    end % set.LSUNFL
    function MC = set.LBMNAM(MC, newLBMNAM)
      MC.ScalarChar(newLBMNAM, 'tTfF42 ', 'LBMNAM');
      MC.LBMNAM = newLBMNAM;
    end % set.LBMNAM
    function MC = set.LFLTNM(MC, newLFLTNM)
      MC.ScalarChar(newLFLTNM, 'tTfF ', 'LFLTNM');
      MC.LFLTNM = newLFLTNM;
    end % set.LFLTNM
    function MC = set.H2OAER(MC, newH2OAER)
      MC.ScalarChar(newH2OAER, 'tTfF ', 'H2OAER');
      MC.H2OAER = newH2OAER;
    end % set.H2OAER
    function MC = set.CDTDIR(MC, newCDTDIR)
      MC.ScalarChar(newCDTDIR, 'tTfF ', 'CDTDIR');
      MC.CDTDIR = newCDTDIR;
    end % set.CDTDIR
    function MC = set.SOLCON(MC, newSOLCON)
      if isempty(newSOLCON)
        newSOLCON = 0;
      end
      assert(isscalar(newSOLCON) && isnumeric(newSOLCON), 'Mod5:setSOLCON:BadSOLCON', ...
        'Input SOLCON must be scalar and numeric.');
      MC.SOLCON = newSOLCON;
    end % set.SOLCON
    function MC = set.CDASTM(MC, newCDASTM)
      MC.ScalarChar(newCDASTM, 'tTdDbBfF ', 'CDASTM');
      MC.CDASTM = newCDASTM;
    end % set.CDASTM    
    %% Card 1A1 set method (solar TOA irradiance file name)
    function MC = set.USRSUN(MC, newUSRSUN)
      % Sets the name of the TOA solar irradiance database
      % MC.USRSUN = ''; will open a file dialog.
      % This function needs the location of the MODTRAN executable
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
      % If the new value is the empty matrix, set it to that
      if isempty(newUSRSUN) && isnumeric(newUSRSUN)
        MC.USRSUN = [];
        % The following as warned against by MLint, so just offer warning if 
        % MC.LSUNFL = 'F'; % Don't want MODTRAN to try to read something from non-existent place.
        if isempty(MC.LSUNFL) || upper(MC.LSUNFL(1)) == 'T'
          warning('Mod5:setUSRSUN:LSUNFLInconsistent', ...
            'If USRSUN is set to [], then LSUNFL must be set blank or ''F'' for false.');
        end
      elseif isnumeric(newUSRSUN)
        switch newUSRSUN
          case 1
            MC.USRSUN = '1';
          case 2
            MC.USRSUN = '2';
          case 3
            MC.USRSUN = '3';
          case 4
            MC.USRSUN = '4';
          case 5
            MC.USRSUN = '5';
          case 6
            MC.USRSUN = '6';
          case 7
            MC.USRSUN = '7';
            
          otherwise
            error('Mod5:setLUSRSUN:BadUSRSUN', ...
              'Numeric values for MODTRAN parameter LUSRSUN may be 1, 2, 3 or 4. Otherwise USRSUN must be blank or a valid filename.');
        end
      else
        % Perform some input checking
        assert(ischar(newUSRSUN) && length(newUSRSUN) <= 256, ...
          'Mod5:setUSRSUN:BadUSRSUN','The parameter USRSUN must be a char array of length less than 256.');
        if isempty(newUSRSUN) % Then use a file dialog to set the file
          [Filename, Pathname] = uigetfile({'*.dat', ...
            'User-Defined TOA Irradiance Files (*.dat)'; '*.*', 'All Files (*.*)'}, 'Select User-Defined Solar TOA File', MODTRANPath);
          if Filename % a valid filename was returned from the uigetfile
            % Now the first part of the pathname must match MODTRANPath
            if ~strncmpi(MODTRANPath, Pathname, length(MODTRANPath)) || length(Pathname) < length(MODTRANPath)
              error('Mod5:setUSRSUN:BadPath',...
                'The location of the USRSUN file must be within the current MODTRAN executable path %s', MODTRANPath)
            else
              % Set the new filter filename to the remainder of the string
              FullFilename = [Pathname Filename];
              % Check to see if the filename is not perhaps a pre-defined TOA
              if strcmpi(Filename, 'newkur.dat')
                MC.USRSUN = '1';
              elseif strcmpi(Filename, 'chkur.dat')
                MC.USRSUN = '2';
              elseif strcmpi(Filename, 'cebchkur.dat')
                MC.USRSUN = '3';
              elseif strcmpi(Filename, 'thkur.dat')
                MC.USRSUN = '4';
              else
                MC.USRSUN = FullFilename(length(MODTRANPath)+1:end);
              end
              % Check status of LSUNFL
              if ~isempty(MC.LSUNFL) && any(upper(MC.LSUNFL(1)) == 'F ')
                warning('Mod5:setUSRSUN:LSUNFLInconsistent', ...
                  'If USRSUN is set to a valid file, then LSUNFL must be set ''t'' or ''T'' for true.');
              end
            end
          end
        else
          if ~all(newUSRSUN)==' '  % the input is not just blanks
            % Check existence of the file
            FullFilename = strtrim([MODTRANPath newUSRSUN]);
            if ~exist(FullFilename, 'file')
              warning('Mod5:setUSRSUN:FileNotExist', ...
                'The binary band model file (parameter USRSUN) %s was not found. Check this before running MODTRAN.', FullFilename);
            end
          end
          % and set the property anyway
          MC.USRSUN = strtrim(newUSRSUN);
        end
      end
    end % set.USRSUN
    %% Card 1A2 set method (band model file name)
    function MC = set.BMNAME(MC, newBMNAME)
      % Sets the name of the binary file for the band model
      % MC.BMNAME = ''; will open a file dialog.
      % This function needs the location of the MODTRAN executable
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
      % If the new value is the empty matrix, set it to that
      if isempty(newBMNAME) && isnumeric(newBMNAME)
        MC.BMNAME = [];
        % The following as warned against by MLint, so just offer warning if 
        % MC.LBMNAM = 'F'; % Don't want MODTRAN to try to read something from non-existent place.
        if isempty(MC.LBMNAM) || any(MC(iCase).LBMNAM == 'Tt42')
          warning('Mod5:setBMNAME:LBMNAMInconsistent', ...
            'If BMNAME is set to [], then LBMNAM must be set blank or ''F'' for false.');
        end
      else
        % Perform some input checking
        assert(ischar(newBMNAME) && length(newBMNAME) <= 256, ...
          'Mod5:setBMNAME:BadBMNAME','The parameter BMNAME must be a char array of length less than 256.');
        if isempty(newBMNAME) % Then use a file dialog to set the file
          [Filename, Pathname] = uigetfile({'*.bin', ...
            'Band Model Binary Files (*.bin)'; '*.*', 'All Files (*.*)'}, 'Select Band Model Binary File', MODTRANPath);
          if Filename % a valid filename was returned from the uigetfile
            % Now the first part of the pathname must match MODTRANPath
            if ~strncmpi(MODTRANPath, Pathname, length(MODTRANPath)) || length(Pathname) < length(MODTRANPath)
              error('Mod5:setBMNAME:BadPath',...
                'The location of the BMNAME file must be within the current MODTRAN executable path %s', MODTRANPath)
            else
              % Set the new filter filename to the remainder of the string
              FullFilename = [Pathname Filename];
              MC.BMNAME = FullFilename(length(MODTRANPath)+1:end);
              % Check status of LBMNAM
              if ~isempty(MC.LBMNAM) && any(upper(MC.LBMNAM(1)) == 'F ')
                warning('Mod5:setBMNAME:LBMNAMInconsistent', ...
                  'If BMNAME is set to a valid file, then LBMNAM must be set ''t'' or ''T'' for true.');
              end
            end
          end
        else
          % Check existence of the file
          FullFilename = strtrim([MODTRANPath newBMNAME]);
          if ~exist(FullFilename, 'file')
            warning('Mod5:setBMNAME:FileNotExist', ...
              'The binary band model file (parameter BMNAME) %s was not found. Check this before running MODTRAN.', FullFilename);
          end
          % and set the property anyway
          MC.BMNAME = strtrim(newBMNAME);
        end
      end
    end % set.BMNAME
    %% Card 1A3 set method (instrument filter file name)
    function MC = set.FILTNM(MC, newFILTNM)
      % Set the filter definitions for band radiance computations (.chn output)
      % This function needs the location of the MODTRAN executable
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
      % If the new value is the empty matrix, set it to that
      if isempty(newFILTNM) && isnumeric(newFILTNM)
        MC.FILTNM = [];
        % The following as warned against by MLint, so just offer warning if 
        % MC.LFLTNM = 'F'; % Don't want MODTRAN to try to read something from non-existent place.
        if isempty(MC.LFLTNM) || upper(MC.LFLTNM(1)) == 'T'
          warning('Mod5:setFILTNM:LFLTNMInconsistent', ...
            'If FILTNM is set to [], then LFLTNM must be set blank or ''F'' for false.');
        end
      else
        % Perform some input checking
        assert(ischar(newFILTNM) && length(newFILTNM) <= 256, ...
          'Mod5:setFILTNM:BadFILTNM','The parameter FILTNM must be a char array of length less than 256.');
        if isempty(newFILTNM) % Then use a file dialog to set the file
          [Filename, Pathname] = uigetfile({'*.flt', ...
            'Band Filter Function Files (*.flt)'; '*.*', 'All Files (*.*)'}, 'Select Filter Function File', MODTRANPath);
          if Filename % a valid filename was returned from the uigetfile
            % Now the first part of the pathname must match MODTRANPath
            if ~strncmpi(MODTRANPath, Pathname, length(MODTRANPath)) || length(Pathname) < length(MODTRANPath)
              error('Mod5:setFILTNM:BadPath',...
                'The location of the FILTNM file must be within the current MODTRAN executable path %s', MODTRANPath)
            else
              % Set the new filter filename to the remainder of the string
              FullFilename = [Pathname Filename];
              MC.FILTNM = FullFilename(length(MODTRANPath)+1:end);
              % Check status of LFLTNM
              if ~isempty(MC.LFLTNM) && any(upper(MC.LFLTNM(1)) == 'F ')
                warning('Mod5:setFILTNM:LFLTNMInconsistent', ...
                  'If FILTNM is set to a valid file, then LFLTNM must be set ''t'' or ''T'' for true.');
              end
            end
          end
        else
          % Check existence of the file
          FullFilename = strtrim([MODTRANPath newFILTNM]);
          if ~exist(FullFilename, 'file') && ~strcmp(newFILTNM, [MC.CaseName '.flt'])
            warning('Mod5:setFILTNM:FileNotExist', ...
              'The spectral filter file (parameter FILTNM) %s was not found. Check this before running MODTRAN.', FullFilename);
          end
          % and set the property anyway
          MC.FILTNM = strtrim(newFILTNM);
        end
      end
    end % set.FILTNM
    %% Card 1A4 set method (MODTRAN data directory)
    function MC = set.DATDIR(MC, newDATDIR)
        % Perform some input checking
        assert(ischar(newDATDIR) && length(newDATDIR) <= 256, ...
          'Mod5:setDATDIR:BadDATDIR','The parameter DATDIR must be a char array of length less than 256.');
        MC.DATDIR = strtrim(newDATDIR); 
    end % set.DATDIR
    %% Card 2 set methods
    function MC = set.APLUS(MC, newAPLUS)
      if isempty(newAPLUS)
        newAPLUS = '  ';
      end
      assert(ischar(newAPLUS) && (strcmp(newAPLUS, ' ') || strcmp(newAPLUS, '  ') || strcmp(newAPLUS, 'A+')), 'Mod5:setAPLUS:BadAPLUS', ...
        'Input APLUS must either be blank or equal to ''A+''');
      if strcmp(newAPLUS, ' ')
        newAPLUS = '  ';
      end
      MC.APLUS = newAPLUS;
    end % set.APLUS
    function MC = set.IHAZE(MC, newIHAZE)
      MC.ScalarIntNumeric(newIHAZE, -1:10, 'IHAZE');
      MC.IHAZE = newIHAZE;
    end % set.IHAZE
    function MC = set.CNOVAM(MC, newCNOVAM)
      MC.ScalarChar(newCNOVAM, 'N ', 'CNOVAM');
      MC.CNOVAM = newCNOVAM;      
    end % set.CNOVAM
    function MC = set.ISEASN(MC, newISEASN)
      MC.ScalarIntNumeric(newISEASN, [0 1 2], 'ISEASN');
      MC.ISEASN = newISEASN;
    end % set.ISEASN
    function MC = set.ARUSS(MC, newARUSS)
      if isempty(newARUSS)
        newARUSS = '   ';
      end
      assert(ischar(newARUSS) && (strcmp(newARUSS, ' ') || strcmp(newARUSS, '  ') || strcmp(newARUSS, 'USS') || ...
         strcmp(newARUSS, '   ')), 'Mod5:setARUSS:BadARUSS', ...
        'Input ARUSS must either be blank or equal to ''USS''');
      if strcmp(newARUSS, ' ') || strcmp(newARUSS, '  ')
        newARUSS = '   ';
      end
      MC.ARUSS = newARUSS;
    end % set.ARUSS
    function MC = set.IVULCN(MC, newIVULCN)
      MC.ScalarIntNumeric(newIVULCN, 0:8, 'IVULCN');
      MC.IVULCN = newIVULCN;
    end % set.IVULCN
    function MC = set.ICSTL(MC, newICSTL)
      MC.ScalarIntNumeric(newICSTL, 0:10, 'ICSTL');
      MC.ICSTL = newICSTL;
    end % set.ICSTL
    function MC = set.ICLD(MC, newICLD)
      MC.ScalarIntNumeric(newICLD, [0:11 18 19], 'ICLD');
      MC.ICLD = newICLD;
    end % set.ICLD
    function MC = set.IVSA(MC, newIVSA)
      MC.ScalarIntNumeric(newIVSA, [0 1], 'IVSA');
      MC.IVSA = newIVSA;
    end % set.IVSA
    function MC = set.VIS(MC, newVIS)
%       assert(isscalar(newVIS) && isnumeric(newVIS) && newVIS >= 0, 'Mod5:setVIS:BadVIS', ...
%         'Input VIS (meteorological range in km) must be scalar, positive, numeric.');
      assert(isscalar(newVIS) && isnumeric(newVIS), 'Mod5:setVIS:BadVIS', ...
        'Input VIS (meteorological range in km) must be scalar, positive, numeric.');
    
      MC.VIS = newVIS;
    end % set.VIS
    function MC = set.WSS(MC, newWSS)
      assert(isscalar(newWSS) && isnumeric(newWSS) && newWSS >= 0, 'Mod5:setWSS:BadWSS', ...
        'Input WSS (current wind speed in m/s) must be scalar, positive, numeric.');
      MC.WSS = newWSS;
    end % set.WSS
    function MC = set.WHH(MC, newWHH)
      assert(isscalar(newWHH) && isnumeric(newWHH) && newWHH >= 0, 'Mod5:setWHH:BadWHH', ...
        'Input WHH (24-hour averaged wind speed in m/s) must be scalar, positive, numeric.');
      MC.WHH = newWHH;
    end % set.WHH
    function MC = set.RAINRT(MC, newRAINRT)
      assert(isscalar(newRAINRT) && isnumeric(newRAINRT) && newRAINRT >= 0, 'Mod5:setRAINRT:BadRAINRT', ...
        'Input RAINRT (rain rate in mm/hour) must be scalar, positive, numeric.');
      MC.RAINRT = newRAINRT;
    end % set.RAINRT
    function MC = set.GNDALT(MC, newGNDALT)
      assert(isscalar(newGNDALT) && isnumeric(newGNDALT) && abs(newGNDALT) <= 6, 'Mod5:setGNDALT:BadGNDALT', ...
        'Input GNDALT must be scalar, numeric and between -6 km and 6 km.');
      MC.GNDALT = newGNDALT;
    end % set.GNDALT
    %% Card 3 set methods (line of sight geometry)
    function MC = set.H1(MC, newH1)
      if isempty(newH1)
        newH1 = 0;
      end
      assert(isscalar(newH1) && isnumeric(newH1) && newH1 >= 0,'Mod5:setH1:BadH1',...
        'Input H1 (LOS initial altitude in km) must be scalar, numeric and positive.')
      MC.H1 = newH1;
    end % set.H1
    function MC = set.H2(MC, newH2)
      if isempty(newH2)
        newH2 = 0;
      end
      assert(isscalar(newH2) && isnumeric(newH2) && newH2 >= 0,'Mod5:setH2:BadH2',...
        'Input H2 (LOS final height or tangent altitude in km) must be scalar, numeric and positive.')
      MC.H2 = newH2;
    end % set.H2
    function MC = set.ANGLE(MC, newANGLE)
      if isempty(newANGLE)
        newANGLE = 0;
      end
      assert(isscalar(newANGLE) && isnumeric(newANGLE) && newANGLE >= 0 && newANGLE <= 180,'Mod5:setANGLE:BadANGLE',...
        'Input ANGLE (LOS initial zenith angle in degrees) must be scalar, numeric, positive and <= 180.')
      MC.ANGLE = newANGLE;
    end % set.ANGLE
    function MC = set.RANGE(MC, newRANGE)
      if isempty(newRANGE)
        newRANGE = 0;
      end
      assert(isscalar(newRANGE) && isnumeric(newRANGE) && newRANGE >= 0,'Mod5:setRANGE:BadRANGE',...
        'Input RANGE (LOS total length in km) must be scalar, numeric and positive.')
      MC.RANGE = newRANGE;
    end % set.RANGE
    function MC = set.BETA(MC, newBETA)
      if isempty(newBETA)
        newBETA = 0;
      end
      assert(isscalar(newBETA) && isnumeric(newBETA) && newBETA >= 0,'Mod5:setBETA:BadBETA',...
        'Input BETA (Earth centre angle subtended by H1 and H2 in degrees) must be scalar, numeric and positive.')
      MC.BETA = newBETA;
    end % set.BETA
    function MC = set.RO(MC, newRO)
      if isempty(newRO)
        newRO = 0;
      end
      assert(isscalar(newRO) && isnumeric(newRO) && newRO >= 0,'Mod5:setRO:BadRO',...
        'Input RO (Radius of the earth in km) must be scalar, numeric and positive.')
      MC.RO = newRO;
    end % set.RO
    function MC = set.LENN(MC, newLENN)
      if isempty(newLENN)
        LENN = 0;
      end
      MC.ScalarIntNumeric(newLENN, [0 1], 'LENN');
      MC.LENN = newLENN;
    end % set.LENN
    function MC = set.PHI(MC, newPHI)
      if isempty(newPHI)
        newPHI = 0;
      end
      assert(isscalar(newPHI) && isnumeric(newPHI) && newPHI >= 0 && newPHI <= 180,'Mod5:setPHI:BadPHI',...
        'Input PHI (Zenith angle at H2 toward H1 in degrees) must be scalar, numeric, positive and <= 180.')
      MC.PHI = newPHI;
    end % set.PHI
    %% Alternate Card 3 (Transmitted Solar/Lunar Irradiance, required if IEMSCT = 3 on Card 1)
    function MC = set.IDAY(MC, newIDAY)
      if isempty(newIDAY)
        newIDAY = 0;
      end
      assert((isscalar(newIDAY) || numel(newIDAY) == 3) && isnumeric(newIDAY), 'Mod5:setIDAY:BadIDAY', ...
        'Input IDAY (Day of year) must be scalar, numeric and <= 365, or a 3 element vector [Year Month Day].');
      if numel(newIDAY) == 3
        newIDAY = datenum(newIDAY) - datenum([newIDAY(1) 1 1]) +1;
      else
        assert(newIDAY >= 0 && newIDAY <= 365, 'Mod5:setIDAY:BadIDAY', ...
        'Input IDAY (Day of year) must be scalar, numeric and <= 365, or a 3 element vector [Year Month Day].');
      end
      MC.IDAY = newIDAY;
    end % set.IDAY
    function MC = set.ISOURC(MC, newISOURC)
      if isempty(newISOURC)
        newISOURC = 0; % extraterrestrial source is the sun by default
      end
      assert(isscalar(newISOURC) && isnumeric(newISOURC) && any(newISOURC == [0 1]), 'Mod5:setISOURC:BadISOURC', ...
        'Input ISOURC (Extraterrestrial Source) must be either 0 for the Sun or 1 for the Moon.');
      MC.ISOURC = newISOURC;
    end % set.ISOURC
    function MC = set.ANGLEM(MC, newANGLEM)
      if isempty(newANGLEM)
        newANGLEM = 0;
      end
      assert(isscalar(newANGLEM) && isnumeric(newANGLEM) && newANGLEM >= -180 && newANGLEM <= 180, 'Mod5:setANGLEM:BadANGLEM', ...
        'Input ANGLEM (Phase angle of the Moon) must be scalar from -180 to 180 in degrees.');
      MC.ANGLEM = newANGLEM;
    end % set.ANGLEM
    %% Card 3A1 (Solar/Lunar scattering geometry, required if IEMSCT = 2 on Card 1)
    function MC = set.IPARM(MC, newIPARM)
      if isempty(newIPARM)
        newIPARM = 0;
      end
      assert(isscalar(newIPARM) && isnumeric(newIPARM) && any(newIPARM == [0 1 2 10 11 12]), 'Mod5:setIPARM:BadIPARM', ...
        'Input IPARM (Solar/Lunar scattering geometry control) must be scalar and one of 0, 1, 2, 10, 11 or 12.');
      MC.IPARM = newIPARM;
    end % set.IPARM
    function MC = set.IPH(MC, newIPH)
      if isempty(newIPH)
        newIPH = 0;
      end
      assert(isscalar(newIPH) && isnumeric(newIPH) && any(newIPH == [0 1 2]), 'Mod5:setIPH:BadIPH', ...
        'Input IPH (Aerosol phase function selector) must be scalar and one of 0, 1, or 2.');
      MC.IPH = newIPH;
    end % set.IPH
    %% Card 3A2 (Solar/Lunar scattering geometry, also required if IEMSCT = 2 on Card 1)
    function MC = set.PARM1(MC, newPARM1)
      if isempty(newPARM1)
        newPARM1 = 0;
      end
      assert(isscalar(newPARM1) && isnumeric(newPARM1), 'Mod5:setPARM1:BadPARM1', ...
        'Input PARM1 (solar/lunar radiation scattering geometry parameter) must be scalar and numeric.');
      MC.PARM1 = newPARM1;
    end % set.PARM1
    function MC = set.PARM2(MC, newPARM2)
      if isempty(newPARM2)
        newPARM2 = 0;
      end
      assert(isscalar(newPARM2) && isnumeric(newPARM2), 'Mod5:setPARM2:BadPARM2', ...
        'Input PARM2 (solar/lunar radiation scattering geometry parameter) must be scalar and numeric.');
      MC.PARM2 = newPARM2;
    end % set.PARM2
    function MC = set.PARM3(MC, newPARM3)
      if isempty(newPARM3)
        newPARM3 = 0;
      end
      assert(isscalar(newPARM3) && isnumeric(newPARM3), 'Mod5:setPARM3:BadPARM3', ...
        'Input PARM3 (solar/lunar radiation scattering geometry parameter) must be scalar and numeric.');
      MC.PARM3 = newPARM3;
    end % set.PARM3
    function MC = set.PARM4(MC, newPARM4)
      if isempty(newPARM4)
        newPARM4 = 0;
      end
      assert(isscalar(newPARM4) && isnumeric(newPARM4), 'Mod5:setPARM4:BadPARM4', ...
        'Input PARM4 (solar/lunar radiation scattering geometry parameter) must be scalar and numeric.');
      MC.PARM4 = newPARM4;
    end % set.PARM4
    function MC = set.TIME(MC, newTIME)
      if isempty(newTIME)
        newTIME = 0;
      end
      assert((isscalar(newTIME) || numel(newTIME) == 3) && isnumeric(newTIME) && newTIME(1) >= 0 && newTIME(1) <= 24, 'Mod5:setTIME:BadTIME', ...
        'Input TIME (Greenwich Time now UTC) must be scalar, numeric and from 0 to 24, or a vector [Hour Minute Second].');
      if numel(newTIME) == 3
        assert(all(newTIME([2 3]) >= 0) && all(newTIME([2 3]) <= 60), 'Mod5:setTIME:BadTIME', ...
          'Input TIME (Greenwich Time now UTC) must be scalar, numeric and from 0 to 24, or a vector [Hour Minute Second].');
        newTIME = newTIME(1) + newTIME(2)/60 + newTIME(3)/3600; % Convert to decimal hours
      end
      MC.TIME = newTIME;
    end % set.TIME
    function MC = set.PSIPO(MC, newPSIPO)
      if isempty(newPSIPO)
        newPSIPO = 0;
      end
      assert(isscalar(newPSIPO) && isnumeric(newPSIPO) && newPSIPO >= 0 && newPSIPO <= 360, 'Mod5:setPSIPO:BadPSIPO', ...
        'Input PSIPO (True path azimuth from H1 to H2 or from H2 to H1) must be scalar, numeric and from 0 to 360 degrees.');
      MC.PSIPO = newPSIPO;
    end % set.PSIPO
    function MC = set.G(MC, newG)
      if isempty(newG)
        newG = 0;
      end
      assert(isscalar(newG) && isnumeric(newG) && newG >= -1 && newG <= 1, 'Mod5:setG:BadG', ...
        'Input G (Henyey-Greenstein asymmetry parameter) must be scalar, numeric and from -1 to 1.');
      MC.G = newG;
    end % set.G
    %% Card 4 set methods (Spectral range and resolution)
    function MC = set.V1(MC, newV1)
      assert(isscalar(newV1) && isnumeric(newV1) && newV1 >= 0, 'Mod5:setV1:BadV1',...
        'Input V1 (Start of spectral range) must be scalar, numeric and >= 0.');
      MC.V1 = newV1;
    end % set.V1
    function MC = set.V2(MC, newV2)
      assert(isscalar(newV2) && isnumeric(newV2) && newV2 > 0, 'Mod5:setV2:BadV2',...
        'Input V2 (End of spectral range) must be scalar, numeric and > 0.');
      MC.V2 = newV2;
    end % set.V2
    function MC = set.DV(MC, newDV)
      assert(isscalar(newDV) && isnumeric(newDV) && newDV > 0, 'Mod5:setDV:BadDV',...
        'Input DV (Spectral increment) must be scalar, numeric and > 0.');
      MC.DV = newDV;
    end % set.DV
    function MC = set.FWHM(MC, newFWHM)
      assert(isscalar(newFWHM) && isnumeric(newFWHM) && newFWHM > 0, 'Mod5:setFWHM:BadFWHM',...
        'Input FWHM (Full-Width at Half Maximum of the scanning filter) must be scalar, numeric and > 0.');
      MC.FWHM = newFWHM;
    end % set.FWHM
    function MC = set.YFLAG(MC, newYFLAG)
      if isempty(newYFLAG)
        newYFLAG = ' ';
      end
      assert(ischar(newYFLAG) && numel(newYFLAG) == 1 && any(upper(newYFLAG) == ' TR'), 'Mod5:setYFLAG:BadYFLAG', ...
        'Input YFLAG (Transmittance/Radiance specifier for plot files) must be a single character, one of '' '', ''T'' or ''R''.');
      MC.YFLAG = newYFLAG;
    end % set.YFLAG
    function MC = set.XFLAG(MC, newXFLAG)
      if isempty(newXFLAG)
        newXFLAG = ' ';
      end
      assert(ischar(newXFLAG) && numel(newXFLAG) == 1 && any(upper(newXFLAG) == ' WMN'), 'Mod5:setXFLAG:BadXFLAG', ...
        'Input XFLAG (Spectral units specifier for plot files) must be a single character, one of '' '', ''W'', ''M'' or ''N''.');
      MC.XFLAG = newXFLAG;
    end % set.XFLAG
    function MC = set.DLIMIT(MC, newDLIMIT)
      if isempty(newDLIMIT)
        newDLIMIT = '        ';
      end
      assert(ischar(newDLIMIT) && size(newDLIMIT, 1) == 1 && size(newDLIMIT,2) <= 8, 'Mod5:setDLIMIT:BadDLIMIT', ...
        'Input DLIMIT (Plot file multiple plot delimiter) must be a character string of 8 or fewer characters.');
      newDLIMIT = [newDLIMIT blanks(8 - length(newDLIMIT))]; % Pad out to 8 characters
      MC.DLIMIT = newDLIMIT;
    end % set.DLIMIT
    function MC = set.FLAGS(MC, newFLAGS)
      if isempty(newFLAGS)
        newFLAGS = '       ';
      end
      assert(ischar(newFLAGS) && size(newFLAGS,1) == 1 && size(newFLAGS,2) <= 7, 'Mod5:setFLAGS:BadFLAGS', ...
        'Input FLAGS (Unit, convolution and flux table controls) must be a character string of length 7 or less.');
      % Check each flag for correct range
      assert(any(upper(newFLAGS(1:1)) == ' WMN'), 'Mod5:setFLAGS:BadFLAGS', ...
        'Input FLAGS(1:1) (Unit specifier for V1, V2, DV and FWHM) must be '' '', ''W'', ''M'' or ''N''.');
      assert(any(upper(newFLAGS(2:2)) == ' 1T2R3G4S5C6H7U'), 'Mod5:setFLAGS:BadFLAGS', ...
        'Input FLAGS(2:2) (Convolution instrument function specifier) must be '' '', ''1'', ''T'', ''2'', ''R'', ''3'', ''G'', ''4'', ''S'', ''5'', ''C'', ''6'', ''H'', ''7'' or ''U''.');
      assert(any(upper(newFLAGS(3:3)) == ' AR'), 'Mod5:setFLAGS:BadFLAGS', ...
        'Input FLAGS(3:3) (FWHM absolute/relative specifier) must be '' '', ''A'', or ''R''.');
      assert(any(upper(newFLAGS(4:4)) == ' A'), 'Mod5:setFLAGS:BadFLAGS', ...
        'Input FLAGS(4:4) (Convolve only total quantities or all quantities) must be '' '' or ''A''.');
      assert(any(newFLAGS(5:5) == ' sS'), 'Mod5:setFLAGS:BadFLAGS', ...
        'Input FLAGS(5:5) (Saving of unconvolved results) must be '' '', ''s'', or ''S''.');
      assert(any(newFLAGS(6:6) == ' rR'), 'Mod5:setFLAGS:BadFLAGS', ...
        'Input FLAGS(6:6) (Use of saved results for convolution) must be '' '', ''r'' or ''R''.');
      assert(any(newFLAGS(7:7) == ' tTfF'), 'Mod5:setFLAGS:BadFLAGS', ...
        'Input FLAGS(7:7) (Wrapping of flux table results) must be '' '', ''t'', ''T'', ''f'' or ''F''.');
      MC.FLAGS = newFLAGS;
    end % set.FLAGS
    %% Card 5 set method (flag indicating sub-cases to follow or not)
    function MC = set.IRPT(MC, newIRPT)
      if isempty(newIRPT)
        newIRPT = 0;
      end
      assert(isscalar(newIRPT) && isnumeric(newIRPT) && any(newIRPT == [-4 -3 -1 0 1 3 4]), 'Mod5:setIRPT:BadIRPT', ...
        'Input IRPT (Sub-case repeat control flag) must be scalar, numeric and one of -4, -3, -1, 0, 1, 3 or 4');
      MC.IRPT = newIRPT;
    end % set.IRPT
  end % set/get methods
  methods (Access = private)
    %% Methods to read in and process/distribute MODTRAN output to sub-cases
    function MODCase = ProcessTp7(MODCase)
      % Read tp7 and incorporate results into case instance
      % Check dates and times of files with the correct root that were
      % written between the starting and ending times.
      ResultFile = dir([MODCase(1).CaseName '.tp7']); % The main output
      if isempty(ResultFile)
        warning('Mod5:ProcessTp7:NoTape7', ...
          'No output .tp7 was found for case %s. Make sure that MODTRAN executed correctly.', MODCase(1).CaseName);
        return;
      end
      OneSecond = 1/24/60/60;
      if ResultFile.datenum - MODCase(1).RunStartSerTime < -OneSecond
        warning('Mod5_Run:ResultFileOld',...
          'The %s.tp7 output file found for this case appears to precede the start time of the run and has therefore been ignored.', ...
          MODCase(1).CaseName);
      else
        
        [Data, Heads] = Mod5.Read7([MODCase(1).CaseName '.tp7']);
        % Distribute the data
        if size(Data,1) ~= numel(MODCase)
          warning('Mod5_Run:tp7DataBlocks',...
            'The number of data blocks in file %s does not match the number of sub-cases.', [MODCase(1).CaseName '.tp7']);
        end
        for iSubCase = 1:min(numel(MODCase), size(Data,1))
          % Seems the spectral units are always cm^-1
          MODCase(iSubCase).tp7.SpectralUnits = 'cm^-1';
          MODCase(iSubCase).tp7.RadianceUnits = 'W/sr/cm^2/cm^-1';
          MODCase(iSubCase).tp7.IrradUnits = 'W/cm^2/cm^-1';
          MODCase(iSubCase).tp7.xLabel = 'Wavenumber (cm^{-1})';
          MODCase(iSubCase).tp7.RawHeaders = Heads{iSubCase}; % Include the raw headers
          % Fix the headers
          FixedHeads = Mod5.FixHeaders(Heads{iSubCase});
          % Put in the headers
          MODCase(iSubCase).tp7.Headers = FixedHeads;
          % Look up the header descriptions
          MODCase(iSubCase).tp7.HeadDescr = Mod5.LookupHeaders(FixedHeads);
          
          for iHead = 1:length(Heads{iSubCase}) % Run through the columns of data
            if isvarname(FixedHeads{iHead})
              MODCase(iSubCase).tp7.(FixedHeads{iHead}) = Data{iSubCase, iHead};
            end
          end
        end
      end
    end % ProcessTp7
    function MODCase = Process7sc(MODCase)
      % Read .7sc and incorporate results into case instance
      % Check dates and times of files with the correct root that were
      % written between the starting and ending times.
      
      ResultFile = dir([MODCase(1).CaseName '.7sc']); % The convolved outputs
      if isempty(ResultFile)
        return; % Nothing to read
      end
      OneSecond = 1/24/60/60;
      if ResultFile.datenum - MODCase(1).RunStartSerTime < -OneSecond
        warning('Mod5_Run:ResultFileOld',...
          'The %s.7sc output file found for this case appears to precede the start time of the run and has therefore been ignored.', ...
          MODCase(1).CaseName);
      else
        
        [Data, Heads] = Mod5.Read7([MODCase(1).CaseName '.7sc']);
        if numel(Data) == 1 && isempty(Data{1})
          return; % Nothing to be done - there is no data in the .7sc file
        end
        % Distribute the data
        if size(Data,1) ~= numel(MODCase)
          warning('Mod5_Run:sc7DataBlocks',...
            'The number of data blocks in file %s does not match the number of sub-cases.', [MODCase(1).CaseName '.7sc']);
        end
        for iSubCase = 1:min(numel(MODCase), size(Data,1))
          if isempty(Heads{iSubCase})
            continue; % sorry, no convolved data for this sub-case
          end
          % Record the raw headers
          MODCase(iSubCase).sc7.RawHeaders = Heads{iSubCase};
          % Fix the headers
          FixedHeads = Mod5.FixHeaders(Heads{iSubCase});
          % Put in the headers
          MODCase(iSubCase).sc7.Headers = FixedHeads;
          % Look up the header descriptions
          MODCase(iSubCase).sc7.HeadDescr = Mod5.LookupHeaders(FixedHeads);
          
          % Check the units in the case
          switch upper(MODCase(iSubCase).FLAGS(1))
            case {' ', 'W'}
%               if ~strcmp(FixedHeads{1}, 'FREQ')
%                 warning('Mod5_Run_Process7sc:UnitInconsistency', ...
%                   'Spectral unit inconsistency (cm^-1) encountered in sub case %s(%i).', MODCase(iSubCase).CaseName, MODCase(iSubCase).CaseIndex);
%               end
              MODCase(iSubCase).sc7.SpectralUnits = 'cm^-1';
              MODCase(iSubCase).sc7.RadianceUnits = 'W/sr/cm^2/cm^-1';
              MODCase(iSubCase).sc7.IrradUnits = 'W/cm^2/cm^-1';
              MODCase(iSubCase).sc7.xLabel = 'Wavenumber (cm^{-1})';
            case 'M'
%               if ~strcmp(FixedHeads{1}, 'WAVLUM')
%                 warning('Mod5_Run_Process7sc:UnitInconsistency', ...
%                   'Spectral unit inconsistency (micron) encountered in sub case %s(%i).', MODCase(iSubCase).CaseName, MODCase(iSubCase).CaseIndex);
%               end
              MODCase(iSubCase).sc7.SpectralUnits = [char(181) 'm'];
              MODCase(iSubCase).sc7.RadianceUnits = ['W/sr/cm^2/' char(181) 'm'];
              MODCase(iSubCase).sc7.IrradUnits = ['W/cm^2/' char(181) 'm'];  
              MODCase(iSubCase).sc7.xLabel = ['Wavelength (' char(181) 'm)'];
            case 'N'
%               if ~strcmp(FixedHeads{1}, 'WAVLNM')
%                 warning('Mod5_Run_Process7sc:UnitInconsistency', ...
%                   'Spectral unit inconsistency (nm) encountered in sub case %s(%i).', MODCase(iSubCase).CaseName, MODCase(iSubCase).CaseIndex);
%               end              
              MODCase(iSubCase).sc7.SpectralUnits = 'nm';
              MODCase(iSubCase).sc7.RadianceUnits = [char(181) 'W/sr/cm^2/nm'];   
              MODCase(iSubCase).sc7.IrradUnits = [char(181) 'W/cm^2/nm'];
              MODCase(iSubCase).sc7.xLabel = 'Wavelength (nm)';
            otherwise
              warning('Mod5_Run_Process7sc:BadFLAGS', ...
                'FLAGS(1) in subcase %s(%i) is not valid, wavenumber units cm^-1 assumed.', MODCase(iSubCase).CaseName, MODCase(iSubCase).CaseIndex);
              MODCase(iSubCase).sc7.SpectralUnits = 'cm^-1';
              MODCase(iSubCase).sc7.RadianceUnits = 'W/sr/cm^2/cm^-1';
              MODCase(iSubCase).sc7.RadianceUnits = 'W/cm^2/cm^-1';
          end
          for iHead = 1:length(Heads{iSubCase}) % Run through the columns of data
            if isvarname(FixedHeads{iHead})
              MODCase(iSubCase).sc7.(FixedHeads{iHead}) = Data{iSubCase, iHead};
            end
          end
        end
      end
    end % Process7sc
    function plothandles = Plot7(MODCase, SubCases, PlotWhat, WhichStruct)
      % Plot7 : Private plot driver for plotting .tp7 and .sc7 structure data
      % SubCases is a list of subcases from which to plot.
      % PlotWhat is a cell array of header strings
      % WhichStruct is either 'tp7' or 'sc7'
      
      plothandles = [];
      PlotIndex = 1;      
      % No input checking is done - should have been done by calling function
      for iCase = SubCases % Run through the specified sub-cases
        if isempty(MODCase(iCase).(WhichStruct))
          continue; % Nothing to plot in this subcase
        end
        % If all fields are to be plotted, get the headers
        if strcmpi(PlotWhat{1},'ALL')
          PlotWhat = MODCase(iCase).(WhichStruct).Headers; 
        end
        Descriptions = Mod5.LookupHeaders(PlotWhat);
        IsTransmittance = strfind(Descriptions, 'Transmittance');
        IsRadiance = strfind(Descriptions, 'Radiance');
        IsDepth = strfind(Descriptions, 'Depth');
        IsIrradiance = strfind(Descriptions, 'Irradiance');
        %nPlots = length(cell2mat(IsTransmittance)) + length(cell2mat(IsRadiance));

        %% First run through the transmittance plots
        plothandles(PlotIndex) = figure;        
        hold all;
        TheLegends = {};        
        for iPlot = 1:length(PlotWhat)
          % Do transmittance plots
          if ~isempty(IsTransmittance{iPlot}) && ~isempty(strmatch(upper(PlotWhat{iPlot}), MODCase(iCase).(WhichStruct).Headers, 'exact'))
            plot(MODCase(iCase).(WhichStruct).(MODCase(iCase).(WhichStruct).Headers{1}), ...
                 MODCase(iCase).(WhichStruct).(PlotWhat{iPlot}));
            TheLegends = [TheLegends PlotWhat{iPlot}];               
          end
        end
        if ~isempty(TheLegends) % Something was plotted
          grid;
          xlabel(strrep(MODCase(iCase).(WhichStruct).xLabel,'cm^-1','cm^{-1}'));
          ylabel('Transmittance');
          legend(TheLegends, 'Location', 'best');
          if ~isempty(MODCase(iCase).CaseDescr)
            title([MODCase(iCase).CaseDescr ' - ' MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')']);
          else
            title([MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')']);
          end
          PlotIndex = PlotIndex + 1;          
        else
          % delete the plot
          delete(plothandles(PlotIndex));
          plothandles(PlotIndex) = [];
        end
        hold off;
        %% Next do the radiance plots
        plothandles(PlotIndex) = figure;        
        hold all;
        TheLegends = {};        
        for iPlot = 1:length(PlotWhat)
          % Do radiance plots
          if ~isempty(IsRadiance{iPlot}) && ~isempty(strmatch(upper(PlotWhat{iPlot}), MODCase(iCase).(WhichStruct).Headers, 'exact'))
            plot(MODCase(iCase).(WhichStruct).(MODCase(iCase).(WhichStruct).Headers{1}), ...
                 MODCase(iCase).(WhichStruct).(PlotWhat{iPlot}));
            TheLegends = [TheLegends PlotWhat{iPlot}];               
          end
        end
        if ~isempty(TheLegends) % Something was plotted
          grid;
          xlabel(strrep(MODCase(iCase).(WhichStruct).xLabel,'cm^-1','cm^{-1}'));
          ylabel(['Radiance (' strrep(MODCase(iCase).(WhichStruct).RadianceUnits, 'cm^-1', 'cm^{-1}') ')']);
          legend(TheLegends, 'Location', 'best');
          if ~isempty(MODCase(iCase).CaseDescr)
            title([MODCase(iCase).CaseDescr ' - ' MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')']);
          else
            title([MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')']);
          end
          PlotIndex = PlotIndex + 1;          
        else
          % delete the plot
          delete(plothandles(PlotIndex));
          plothandles(PlotIndex) = [];          
        end
        hold off;
        %% Now do the irradiance plots
        plothandles(PlotIndex) = figure;        
        hold all;
        TheLegends = {};        
        for iPlot = 1:length(PlotWhat)
          % Do radiance plots
          if ~isempty(IsIrradiance{iPlot}) && ~isempty(strmatch(upper(PlotWhat{iPlot}), MODCase(iCase).(WhichStruct).Headers, 'exact'))
            plot(MODCase(iCase).(WhichStruct).(MODCase(iCase).(WhichStruct).Headers{1}), ...
                 MODCase(iCase).(WhichStruct).(PlotWhat{iPlot}));
            TheLegends = [TheLegends PlotWhat{iPlot}];               
          end
        end
        if ~isempty(TheLegends) % Something was plotted
          grid;
          xlabel(strrep(MODCase(iCase).(WhichStruct).xLabel,'cm^-1','cm^{-1}'));
          ylabel(['Irradiance (' strrep(MODCase(iCase).(WhichStruct).IrradUnits, 'cm^-1', 'cm^{-1}') ')']);
          legend(TheLegends, 'Location', 'best');
          if ~isempty(MODCase(iCase).CaseDescr)
            title([MODCase(iCase).CaseDescr ' - ' MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')']);
          else
            title([MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')']);
          end
          PlotIndex = PlotIndex + 1;          
        else % nothing was plotted
          % delete the plot
          delete(plothandles(PlotIndex));
          plothandles(PlotIndex) = [];          
        end
        hold off;
        %% Finally do any optical depth plots
         plothandles(PlotIndex) = figure;        
        hold all;
        TheLegends = {};        
        for iPlot = 1:length(PlotWhat)
          % Do radiance plots
          if ~isempty(IsDepth{iPlot}) && ~isempty(strmatch(upper(PlotWhat{iPlot}), MODCase(iCase).(WhichStruct).Headers, 'exact'))
            plot(MODCase(iCase).(WhichStruct).(MODCase(iCase).(WhichStruct).Headers{1}), ...
                 MODCase(iCase).(WhichStruct).(PlotWhat{iPlot}));
            TheLegends = [TheLegends PlotWhat{iPlot}];               
          end
        end
        if ~isempty(TheLegends) % Something was plotted
          grid;
          xlabel(strrep(MODCase(iCase).(WhichStruct).xLabel,'cm^-1','cm^{-1}'));
          ylabel('Optical Depth');
          legend(TheLegends, 'Location', 'best');
          if ~isempty(MODCase(iCase).CaseDescr)
            title([MODCase(iCase).CaseDescr ' - ' MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')']);
          else
            title([MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')']);
          end
          PlotIndex = PlotIndex + 1;          
        else % nothing was plotted
          % delete the plot
          delete(plothandles(PlotIndex));
          plothandles(PlotIndex) = [];          
        end
        hold off;
      end
      if isempty(plothandles)
        warning('Mod5:Plot7:NothingToPlot', ...
          'The requested data is not available for plotting. Ensure that your case is correctly configured and that MODTRAN has executed correctly.');
      end
    end % Plot7
    function plothandle = Plot7ByCase(MODCase, SubCases, PlotWhat, WhichStruct)
      % Plot7ByCase : Private plot driver for plotting .tp7 and .sc7 structure data
      % SubCases is a list of subcases from which to plot.
      % PlotWhat is a single string giving what to plot
      % WhichStruct is either 'tp7' or 'sc7'
      
      MaxLegends = 10; % if there are more than MaxLegends legends, don't plot them
      plothandle = [];
      PlotWhat = upper(PlotWhat);
      % No input checking is done - should have been done by calling function
      Description = Mod5.LookupHeaders(PlotWhat);
      IsTransmittance = ~isempty(cell2mat(strfind(Description, 'Transmittance')));
      IsRadiance = ~isempty(cell2mat(strfind(Description, 'Radiance')));
      IsDepth = ~isempty(cell2mat(strfind(Description, 'Depth')));
      IsIrradiance = ~isempty(cell2mat(strfind(Description, 'Irradiance')));
      
      %% Transmittance Plot      
      if IsTransmittance
        plothandle = figure;      
        hold all;
        TheLegends = {};
        for iCase = SubCases
          % Plot transmittance data for all sub-cases
          if ~isempty(MODCase(iCase).(WhichStruct)) && ~isempty(strmatch(upper(PlotWhat), MODCase(iCase).(WhichStruct).Headers, 'exact'))
            plot(MODCase(iCase).(WhichStruct).(MODCase(iCase).(WhichStruct).Headers{1}), ...
              MODCase(iCase).(WhichStruct).(PlotWhat));
            NextLegend = [MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')'];
            TheLegends = [TheLegends NextLegend];
          end
        end
        if ~isempty(TheLegends) % Something was plotted, dolly up the plot
          grid;
          xlabel(strrep(MODCase(iCase).(WhichStruct).xLabel,'cm^-1','cm^{-1}'));
          ylabel('Transmittance');
          if length(TheLegends) <= MaxLegends;
            legend(TheLegends, 'Location', 'best');
          end
          if ~isempty(MODCase(iCase).CaseDescr)
            title([MODCase(iCase).CaseDescr Description]);
          else
            title(Description);
          end
        else
          delete(plothandle);
          plothandle = [];
        end
        hold off;
      end % Transmittance plotting
      %% Next do the radiance plot
      if IsRadiance
        plothandle = figure;      
        hold all;
        TheLegends = {};
        for iCase = SubCases
          % Plot radiance data for all sub-cases
          if ~isempty(MODCase(iCase).(WhichStruct)) && ~isempty(strmatch(upper(PlotWhat), MODCase(iCase).(WhichStruct).Headers, 'exact'))
            plot(MODCase(iCase).(WhichStruct).(MODCase(iCase).(WhichStruct).Headers{1}), ...
              MODCase(iCase).(WhichStruct).(PlotWhat));
            NextLegend = [MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')'];
            TheLegends = [TheLegends NextLegend];
          end
        end
        if ~isempty(TheLegends) % Something was plotted
          grid;
          xlabel(strrep(MODCase(iCase).(WhichStruct).xLabel,'cm^-1','cm^{-1}'));
          ylabel(['Radiance (' strrep(MODCase(iCase).(WhichStruct).RadianceUnits, 'cm^-1', 'cm^{-1}') ')']);
          if length(TheLegends) <= MaxLegends;
            legend(TheLegends, 'Location', 'best');
          end
          if ~isempty(MODCase(iCase).CaseDescr)
            title([MODCase(iCase).CaseDescr Description]);
          else
            title(Description);
          end
        else
          delete(plothandle);          
          plothandle = [];
        end
        hold off;
      end
      %% Irradiance plot
      if IsIrradiance
        plothandle = figure;              
        hold all;
        TheLegends = {};
        for iCase = SubCases
          % Plot irradiance data for all sub-cases
          if ~isempty(MODCase(iCase).(WhichStruct)) && ~isempty(strmatch(upper(PlotWhat), MODCase(iCase).(WhichStruct).Headers, 'exact'))
            plot(MODCase(iCase).(WhichStruct).(MODCase(iCase).(WhichStruct).Headers{1}), ...
              MODCase(iCase).(WhichStruct).(PlotWhat));
            NextLegend = [MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')'];
            TheLegends = [TheLegends NextLegend];
          end
        end
        if ~isempty(TheLegends) % Something was plotted
          grid;
          xlabel(strrep(MODCase(iCase).(WhichStruct).xLabel,'cm^-1','cm^{-1}'));
          ylabel(['Irradiance (' strrep(MODCase(iCase).(WhichStruct).IrradUnits, 'cm^-1', 'cm^{-1}') ')']);
          if length(TheLegends) <= MaxLegends;
            legend(TheLegends, 'Location', 'best');
          end
          if ~isempty(MODCase(iCase).CaseDescr)
            title([MODCase(iCase).CaseDescr Description]);
          else
            title(Description);
          end
        else % nothing was plotted
          delete(plothandle);          
          plothandle = [];
        end
        hold off;
      end
      %% Optical depth (thickness) plot
      if IsDepth
        plothandle = figure;              
        hold all;
        TheLegends = {};
        for iCase = SubCases
          % Plot optical depth data for all sub-cases
          if ~isempty(MODCase(iCase).(WhichStruct)) && ~isempty(strmatch(upper(PlotWhat), MODCase(iCase).(WhichStruct).Headers, 'exact'))
            plot(MODCase(iCase).(WhichStruct).(MODCase(iCase).(WhichStruct).Headers{1}), ...
              MODCase(iCase).(WhichStruct).(PlotWhat));
            NextLegend = [MODCase(iCase).CaseName '(' num2str(MODCase(iCase).CaseIndex) ')'];
            TheLegends = [TheLegends NextLegend];
          end
        end
        if ~isempty(TheLegends) % Something was plotted
          grid;
          xlabel(strrep(MODCase(iCase).(WhichStruct).xLabel,'cm^-1','cm^{-1}'));
          ylabel('Optical Depth');
          if length(TheLegends) <= MaxLegends;
            legend(TheLegends, 'Location', 'best');
          end
          if ~isempty(MODCase(iCase).CaseDescr)
            title([MODCase(iCase).CaseDescr Description]);
          else
            title(Description);
          end
        else % nothing was plotted
          delete(plothandle);
          plothandle = [];
        end
        hold off;
      end
      if isempty(plothandle)
        warning('Mod5:Plot7ByCase:NoData', ...
          'The requested plot data was not available for Plot7. Ensure that your case is correctly configured and that MODTRAN has executed correctly.')
      end
    end % Plot7ByCase
    function MODCase = ProcessPlt(MODCase)
      % ProcessPlt : Read and attach plot .plt results to the case
      ResultFile = dir([MODCase(1).CaseName '.plt']); % The plot file, if any
      if isempty(ResultFile)
        return; % nothing to do, no plot file was generated
      end
      OneSecond = 1/24/60/60;
      if ResultFile.datenum - MODCase(1).RunStartSerTime < -OneSecond
        warning('Mod5_Run:ResultFileOld',...
          'The %s plot output file found for this case appears to precede the start time of the run and has therefore been ignored.', ...
          MODCase(1).CaseName);
      else
        PlotData = Mod5.ReadPlt(ResultFile.name);
        % Distribute the plot data to the cases, and set the units
        % Assume that a block of data will occur in the plot data for
        % each sub-case that has the YFLAG set to T or R.
        iBlock = 0;
        for iCase = 1:numel(MODCase)
          if MODCase(iCase).YFLAG == ' ' || isempty(MODCase(iCase).tp7)
            continue; % Move on to next case - no plot data for this case ?
          end
          switch upper(MODCase(iCase).XFLAG)
            case {'W', ' '}
              MODCase(iCase).plt.SpectralUnits = 'cm^-1';
              MODCase(iCase).plt.RadianceUnits = 'W/sr/cm^2/cm^-1';
              MODCase(iCase).plt.IrradUnits = 'W/cm^2/cm^-1';
              Head = 'FREQ';
              MODCase(iCase).plt.Headers{1} = Head;                
              MODCase(iCase).plt.xLabel = 'Wavenumber (cm^-1)';
              iBlock = iBlock + 1;
            case 'M'
              MODCase(iCase).plt.SpectralUnits = [char(181) 'm'];
              MODCase(iCase).plt.RadianceUnits = ['W/sr/cm^2/' char(181) 'm'];
              MODCase(iCase).plt.IrradUnits = ['W/cm^2/' char(181) 'm'];
              Head = 'WAVLUM';
              MODCase(iCase).plt.Headers{1} = Head;                
              MODCase(iCase).plt.xLabel = 'Wavelength (\mum)';
              iBlock = iBlock + 1;
            case 'N'
              MODCase(iCase).plt.SpectralUnits = 'nm';
              MODCase(iCase).plt.RadianceUnits = [char(181) 'W/sr/cm^2/nm'];
              MODCase(iCase).plt.IrradUnits = [char(181) 'W/cm^2/nm'];
              Head = 'WAVLNM';
              MODCase(iCase).plt.Headers{1} = Head;                
              MODCase(iCase).plt.xLabel = 'Wavelength (nm)';
              iBlock = iBlock + 1;
            otherwise
              Head = 'FREQ'; % Don't know what else to do ...
          end
          if iBlock > size(PlotData,1)
            warning('Mod5_ProcessPlots:InsufficientPlotData', ...
              'There is insufficient data in the plot file to assign to the sub-cases in %s.', MODCase(iCase).CaseName);
            break; % Abandon effort to assign plot data
          end
          % Now here is a bit of a conundrum, if YFLAG is R (output radiance to plot file) and
          % IEMSCT = 0 (compute transmittance only), then transmittance is output to the plot file
          switch upper(MODCase(iCase).YFLAG)
            case 'T' % Transmittance is computed presumably for all IEMSCT values
              MODCase(iCase).plt.Headers{2} = 'TRANS';                              
              MODCase(iCase).plt.yLabel = 'Transmittance';
              MODCase(iCase).plt.(Head) = PlotData{iBlock, 1};
              MODCase(iCase).plt.TRANS = PlotData{iBlock, 2};
            case 'R'
              MODCase(iCase).plt.(Head) = PlotData{iBlock, 1};              
              % There is a radiance case and an irradiance case
              switch MODCase(iCase).IEMSCT
                case 0 % Sorry, only computed transmittance, override the 'R' in YFLAG
                  MODCase(iCase).plt.Headers{2} = 'TRANS';                
                  MODCase(iCase).plt.yLabel = 'Transmittance';
                  MODCase(iCase).plt.TRANS = PlotData{iBlock, 2};
                case {1, 2} % Radiances
                  MODCase(iCase).plt.Headers{2} = 'TOTALRAD';                
                  MODCase(iCase).plt.yLabel = ['Radiance (' MODCase(iCase).plt.RadianceUnits ')'];
                  MODCase(iCase).plt.TOTALRAD = PlotData{iBlock, 2};
                case 3 % Irradiance
                  MODCase(iCase).plt.Headers{2} = 'SOLTR';                
                  MODCase(iCase).plt.yLabel = ['Irradiance (' MODCase(iCase).plt.IrradUnits ')'];
                  MODCase(iCase).plt.SOLTR = PlotData{iBlock, 2};
              end
          end
        end
        % Should check where iBlock ends up and warn if not all plot data was distributed
        if iBlock ~= size(PlotData,1)
          warning('Mod5:ProcessPlt:BlockCountMismatch', ...
            'There is a .plt file block count mismatch in case %s', MODCase(1).CaseName)
        end
      end
    end % ProcessPlt
    function MODCase = ProcessPsc(MODCase)
      % ProcessPsc : Read and attach .psc plot results to the case
      ResultFile = dir([MODCase(1).CaseName '.psc']); % The plot file, if any
      if isempty(ResultFile)
        return; % nothing to do, no plot file was generated
      end
      OneSecond = 1/24/60/60;
      if ResultFile.datenum - MODCase(1).RunStartSerTime < -OneSecond
        warning('Mod5_Run:ResultFileOld',...
          'The %s plot output file found for this case appears to precede the start time of the run and has therefore been ignored.', ...
          MODCase(1).CaseName);
      else
        PlotData = Mod5.ReadPlt(ResultFile.name);
        % Distribute the plot data to the cases, and set the units
        % Results in .psc are determined by FLAGS(1)
        iBlock = 0;
        for iCase = 1:numel(MODCase)
          if MODCase(iCase).YFLAG == ' ' || isempty(MODCase(iCase).sc7) % no plot data for this sub-case
            continue;
          end
          switch upper(MODCase(iCase).FLAGS(1))
            case {'W', ' '}
              MODCase(iCase).psc.SpectralUnits = 'cm^-1';
              MODCase(iCase).psc.RadianceUnits = 'W/sr/cm^2/cm^-1';
              MODCase(iCase).psc.IrradUnits = 'W/cm^2/cm^-1';
              Head = 'FREQ';
              MODCase(iCase).psc.Headers{1} = Head;                
              MODCase(iCase).psc.xLabel = 'Wavenumber (cm^-1)';
              iBlock = iBlock + 1;
            case 'M'
              MODCase(iCase).psc.SpectralUnits = [char(181) 'm'];
              MODCase(iCase).psc.RadianceUnits = ['W/sr/cm^2/' char(181) 'm'];
              MODCase(iCase).psc.IrradUnits = ['W/cm^2/' char(181) 'm'];
              Head = 'WAVLUM';
              MODCase(iCase).psc.Headers{1} = Head;                
              MODCase(iCase).psc.xLabel = 'Wavelength (\mum)';
              iBlock = iBlock + 1;
            case 'N'
              MODCase(iCase).psc.SpectralUnits = 'nm';
              MODCase(iCase).psc.RadianceUnits = [char(181) 'W/sr/cm^2/nm'];
              MODCase(iCase).psc.IrradUnits = [char(181) 'W/cm^2/nm'];
              Head = 'WAVLNM';
              MODCase(iCase).psc.Headers{1} = Head;                
              MODCase(iCase).psc.xLabel = 'Wavelength (nm)';
              iBlock = iBlock + 1;
            otherwise
              Head = 'FREQ'; % Don't know what else to do ...
          end
          if iBlock > size(PlotData,1)
            warning('Mod5_ProcessPlots:InsufficientPlotData', ...
              'There is insufficient data in the .psc plot file to assign to the sub-cases in %s.', MODCase(iCase).CaseName);
            break; % Abandon effort to assign plot data
          end
          % Now here is a bit of a conundrum, if YFLAG is R (output radiance to plot file) and
          % IEMSCT = 0 (compute transmittance only), then transmittance is output to the plot file
          switch upper(MODCase(iCase).YFLAG)
            case 'T' % Transmittance is computed presumably for all IEMSCT values
              MODCase(iCase).psc.Headers{2} = 'TRANS';                              
              MODCase(iCase).psc.yLabel = 'Transmittance';
              MODCase(iCase).psc.(Head) = PlotData{iBlock, 1};
              MODCase(iCase).psc.TRANS = PlotData{iBlock, 2};
            case 'R'
              MODCase(iCase).psc.(Head) = PlotData{iBlock, 1};              
              % There is a radiance case and an irradiance case
              switch MODCase(iCase).IEMSCT
                case 0 % Sorry, only computed transmittance, override the 'R' in YFLAG
                  MODCase(iCase).psc.Headers{2} = 'TRANS';                
                  MODCase(iCase).psc.yLabel = 'Transmittance';
                  MODCase(iCase).psc.TRANS = PlotData{iBlock, 2};
                case {1, 2} % Radiances
                  MODCase(iCase).psc.Headers{2} = 'TOTALRAD';                
                  MODCase(iCase).psc.yLabel = ['Radiance (' MODCase(iCase).psc.RadianceUnits ')'];
                  MODCase(iCase).psc.TOTALRAD = PlotData{iBlock, 2};
                case 3 % Irradiance
                  MODCase(iCase).psc.Headers{2} = 'SOLTR';                
                  MODCase(iCase).psc.yLabel = ['Irradiance (' MODCase(iCase).psc.IrradUnits ')'];
                  MODCase(iCase).psc.SOLTR = PlotData{iBlock, 2};
              end
          end
        end
        if iBlock ~= size(PlotData,1)
          warning('Mod5:ProcessPsc:BlockCountMismatch', ...
            'There is a .psc file block count mismatch in case %s', MODCase(1).CaseName)
        end        
      end
    end % ProcessPsc
    function MODCase = ProcessChn(MODCase)
      % ProcessChn : Process any .chn (spectral channel data)
      % This function should deal correctly with radiance, transmittance
      % and irradiance cases.
      ResultFile = dir([MODCase(1).CaseName '.chn']); % The channels output
      if isempty(ResultFile) % nothing to do
        return;
      end
      OneSecond = 1/24/60/60;
      if ResultFile.datenum - MODCase(1).RunStartSerTime < -OneSecond
        warning('Mod5:ProcessChn:ResultFileOld',...
          'The %s.chn output file found for this case appears to precede the start time of the run and has therefore been ignored.', ...
          MODCase(1).CaseName);
      else % Read the data from the .chn file and distribute to the sub-cases
        [Data, Descr, ColHeads] = Mod5.ReadChn([MODCase(1).CaseName '.chn']);
        iBlock = 0;
        for iCase = 1:numel(MODCase)
          if upper(MODCase(iCase).LFLTNM) == 'T'
            iBlock = iBlock + 1;
            if iBlock > numel(Data)
              warning('Mod5:ProcessChn:InsufficientData', ...
                'There were insufficient data blocks in %s.chn to distribute to qualifying sub-cases.', MODCase(1).CaseName);
              return; % Abandon data distribution
            end
            MODCase(iCase).chn.ColHeads = ColHeads{iBlock};
            MODCase(iCase).chn.ChanNumber = Data{iBlock}(:,1);
            MODCase(iCase).chn.ChanDescr = Descr(:,iBlock);
            switch MODCase(iCase).IEMSCT
              case 0 % Transmittance mode
                if isempty(strfind(ColHeads{iBlock}(2,:),'EXTINCTION'))
                  warning('Mod5:ProcessChn:UnexpectedHeaders', ...
                    'Extinction data was expected in .chn data for case %s(%i), but headers do not concur.', MODCase(iCase).CaseName, ...
                    MODCase(iCase).CaseIndex);
                end
                MODCase(iCase).chn.AveExtinct = Data{iBlock}(:,2);
                MODCase(iCase).chn.ChanExtinctUnits = 'cm^-1';
                MODCase(iCase).chn.ChanExtinct = Data{iBlock}(:,3);
                MODCase(iCase).chn.EquivWidthFreq = Data{iBlock}(:,4);
                MODCase(iCase).chn.EquivWidthNm = Data{iBlock}(:,5);
                MODCase(iCase).chn.SpecMinNm = Data{iBlock}(:,6);
                MODCase(iCase).chn.SpecMaxNm = Data{iBlock}(:,7);
              case {1 2 4} % Radiance modes, mode 4 is actually MODTRAN 5
                if isempty(strfind(ColHeads{iBlock}(1,:),'RADIANCE'))
                  warning('Mod5:ProcessChn:UnexpectedHeaders', ...
                    'Radiance data was expected in chn data for case %s(%i), but headers do not concur.', MODCase(iCase).CaseName, ...
                    MODCase(iCase).CaseIndex);
                end
                % Distribute the 8 columns of data to this subcase
                MODCase(iCase).chn.SpecRadFreqUnits = 'W/sr/cm^2/cm^-1';
                MODCase(iCase).chn.SpecRadFreq = Data{iBlock}(:,2);
                MODCase(iCase).chn.SpecRadNmUnits = 'W/sr/cm^2/nm';
                MODCase(iCase).chn.SpecRadNm = Data{iBlock}(:,3);
                MODCase(iCase).chn.ChanRadUnits = 'W/sr/cm^2';
                MODCase(iCase).chn.ChanRad = Data{iBlock}(:,4);
                MODCase(iCase).chn.EquivWidthFreq = Data{iBlock}(:,5);
                MODCase(iCase).chn.EquivWidthNm = Data{iBlock}(:,6);
                MODCase(iCase).chn.SpecMinNm = Data{iBlock}(:,7);
                MODCase(iCase).chn.SpecMaxNm = Data{iBlock}(:,8);
                % And the description of the channel
              case 3 % Irradiance mode
                if isempty(strfind(ColHeads{iBlock}(2,:),'IRRADIANCE'))
                  warning('Mod5:ProcessChn:UnexpectedHeaders', ...
                    'Irradiance data was expected in .chn data for case %s(%i), but headers do not concur.', MODCase(iCase).CaseName, ...
                    MODCase(iCase).CaseIndex);
                end                
                MODCase(iCase).chn.SpecIrradFreqUnits = 'W/cm^2/cm^-1';
                MODCase(iCase).chn.SpecIrradFreq = Data{iBlock}(:,2);
                MODCase(iCase).chn.SpecIrradNmUnits = 'W/cm^2/nm';
                MODCase(iCase).chn.SpecIrradNm = Data{iBlock}(:,3);
                MODCase(iCase).chn.ChanIrradUnits = 'W/cm^2';
                MODCase(iCase).chn.ChanIrrad = Data{iBlock}(:,4);
                MODCase(iCase).chn.EquivWidthFreq = Data{iBlock}(:,5);
                MODCase(iCase).chn.EquivWidthNm = Data{iBlock}(:,6);
                MODCase(iCase).chn.SpecMinNm = Data{iBlock}(:,7);
                MODCase(iCase).chn.SpecMaxNm = Data{iBlock}(:,8);
                
              otherwise
            end
          end
        end
      end
    end % ProcessChn
    function MODCase = ProcessFlx(MODCase)
        % ProcessFlx : Reads and attaches .flx irradiance data
        % This is spectrally convolved data, not raw (tape8) fluxes.
      ResultFile = dir([MODCase(1).CaseName '.flx']); % The flux output
      if isempty(ResultFile) % nothing to do
        return;
      end
      OneSecond = 1/24/60/60;
      if ResultFile.datenum - MODCase(1).RunStartSerTime < -OneSecond
        warning('Mod5:ProcessFlx:ResultFileOld',...
          'The %s.flx output file found for this case appears to precede the start time of the run and has therefore been ignored.', ...
          MODCase(1).CaseName);
      else % Read the data from the .flx file and distribute to the sub-cases
        Flx = Mod5.ReadFlx([MODCase(1).CaseName '.flx']);
        iBlock = 0;
        for iCase = 1:numel(MODCase)
          if any(upper(MODCase(iCase).FLAGS(7)) == 'TF') 
            % Flux data should have been generated for this subcase
            iBlock = iBlock + 1;
            if iBlock > numel(Flx)
              warning('Mod5:ProcessFlx:InsufficientData', ...
                'There were insufficient data blocks in %s.flx to distribute to qualifying sub-cases.', MODCase(1).CaseName);
              return; % Abandon data distribution
            end
            Flx(iBlock).Label = [MODCase(iCase).CaseName '(' num2str(iCase) ')'];
            MODCase(iCase).flx = Flx(iBlock);
          end  
        end % Finished distributing flux data
        % Is there any data left ?
        if iBlock ~= numel(Flx)
            % Issue a warning
            warning('Mod5:ProcessFlx:TooMuchData', ...
              'There were more data blocks in %s.flx than needed to distribute to qualifying sub-cases.', MODCase(1).CaseName);
        end
      end      
    end % ProcessFlx
    %% Utility methods for Describe functions
    function printPreCase(C, fid, OF)
      switch OF
        case 'm' % Matlab script
          fprintf(fid, '%%%% Case Name : %s\n', C.CaseName);
          fprintf(fid, '%% Case Description : %s\n', C.CaseDescr);
          if ~isempty(C.LongDescr)
            LDescr = strrep(C.LongDescr, char(10), [char(10) '% ']);
            fprintf(fid, '%% %s\n', LDescr);
          end
          fprintf(fid, '%%\n');
      end
    end % printPreCase
    function printPreCard(C, fid, OF, CardName, varargin)
      % Find the card description
      iCard = strmatch(CardName, C.CardNames, 'exact');
      if ~isempty(iCard)
        CardDescription = C.CardDescr{iCard};
      else
        CardDescription = '';
      end
      switch OF
        case 'm'
          fprintf(fid, '%%%% Card %s : %s\n', CardName, CardDescription);
      end
    end % printPreCard
    function printCardItem(C, fid, OF, Item, Format, varargin)
      switch OF
        case 'm' % Matlab script
          fprintf(fid, ['%s.' Item ' = ' Format '; %% '], genvarname(C.CaseName), C.(Item));
          if ~isempty(varargin)
            fprintf(fid, varargin{:});
          end
      end
    end % printCardItem
    function printPostCard(C, fid, OF, varargin)
    end % printPostCard
    %% Methods to read in MODTRAN .ltn or .tp5 cards and to Describe cards
    % Note that Describe methods are not yet implemented for many of the subsidiary cards
    function [Card, lin] = ReadSimpleCard(C, fid, FieldWidth, FieldFormat, CardName)
    % Read a simple MODTRAN card (because textscan is buggy)
    if length(FieldWidth) ~= length(FieldFormat)
      warning('ReadSimpleCard:FieldFormatCountMismatch', 'FieldWidth and FieldFormat count mismatch.')
    end
    if C.DebugFlag
      fprintf(1,'Reading Card %s - ', CardName);
    end
    
    % Find starting and ending positions of the fields
    Stop = cumsum(FieldWidth);
    % lin = Mod5.fgetl80(fid);
    lin = Mod5.fgetlN(fid, max(Stop)); % New way of doing things
    % It is unclear why I did the following, because in MODTRAN 5 it causes
    % problems
%     while length(lin) < max(Stop) % Keep reading lines and concatenating until there is enough data to satisfy the format 
%       lin = [lin Mod5.fgetl80(fid)];
%     end
    Start = Stop - FieldWidth + 1;
    % Print the card name if in debug mode
    if C.DebugFlag
      
      % Find the card name in the list
      iMatch = strmatch(CardName, C.CardNames, 'exact');
      if length(iMatch) ~= 1
        warning('Mod5:CardNameNotFound','Card name not found in global list.')
      else
        % Print description
        fprintf(1, '%s\n', C.CardDescr{iMatch});
        % Print a list of parameters
        fprintf(1,'Parameter Names on this Card: ');
        fprintf(1,'%s ', C.ParmNames{iMatch}{:});
        fprintf(1,'\n');
      end
      fprintf(1,'%s\n', lin);      
    end
    iUsedField = 1;
    for iField = 1:length(FieldWidth)
      if FieldFormat{iField}(1) ~= '*' 
        Card{iUsedField} = sscanf(lin(Start(iField):Stop(iField)), ['%' FieldFormat{iField}]);
        if isempty(Card{iUsedField})
          % Card{iUsedField} = []; % Character data is never empty, so must be numeric
          Card{iUsedField} = 0; % Character data is never empty, so must be numeric
        end
        if C.DebugFlag
          fprintf(1,'<%s>\n', lin(Start(iField):Stop(iField)));
        end
        iUsedField = iUsedField + 1;
      end
    end
    end % ReadSimpleCard
    function [Card, lin] = ReadFreeCard(C, fid, FieldFormat, CardName)
    % Read a simple MODTRAN card using free format
    % Get a line
    lin = Mod5.fgetlN(fid, 0); % Get a line, don't pad or truncate
    % Print the card name if in debug mode
    if C.DebugFlag
      fprintf(1,'Reading Free Format Card %s - ', CardName)
      % Find the card name in the list
      iMatch = strmatch(CardName, C.CardNames, 'exact');
      if length(iMatch) ~= 1
        warning('Mod5:CardNameNotFound','Card name not found in global list.')
      else
        % Print the card description
        fprintf(1, '%s\n', C.CardDescr{iMatch});
        % Print the card
        fprintf(1,'%s\n', lin);
        % Print a list of parameters
        fprintf(1,'Parameter Names on this Card: ');
        fprintf(1,'%s ', C.ParmNames{iMatch}{:});
        fprintf(1,'\n');
      end
    end
    Card = textscan(lin, FieldFormat, 1); % Use the format only once
    
    end % ReadFreeCard
    function C = ReadCard1(C, fid) % C is the MODTRAN case instance
      % MODTRN, SPEED, BINARY, LYMOLC, MODEL, ITYPE, IEMSCT, IMULT, M1, M2, M3, M4, M5,
      % M6, MDEF, I_RD2C, NOPRNT, TPTEMP, SURREF
      % old FORMAT (2A1, I3, 12I5, F8.3, A7)
      % new FORMAT (4A1, I1, 11I5, 1X, I4, F8.0, A7)
      [Card, lin] = C.ReadSimpleCard(fid, [1 1 1 1 1 5 5 5 5 5 5 5 5 5 5 5 1 4 8 7], ...
       {'c', 'c', 'c', 'c', 'd', 'd', 'd','d','d','d','d','d','d','d','d','d','*', 'd', 'f', '7c'}, '1');
      [C.MODTRN, C.SPEED, C.BINARY, C.LYMOLC, C.MODEL, C.ITYPE, C.IEMSCT, C.IMULT, C.M1, C.M2, ...
       C.M3, C.M4, C.M5, C.M6, C.MDEF, C.I_RD2C, C.NOPRNT, C.TPTEMP, C.SURREF] = Card{:};
     assert(any(upper(C.SPEED) == 'S M'), 'Mod5:ReadCard1BadSPEED', ...
     'Parameter SPEED on Card 1 must be one of blank, S or M. The card read contained the following:\n%s', lin);         
   
    end % ReadCard1
    function C = WriteCard1(C, fid)
      fprintf(fid, '%c%c%c%c%1d%5d%5d%5d%5d%5d%5d%5d%5d%5d%5d%5d %4d%8.0f%7s\n', ...
        C.MODTRN, C.SPEED, C.BINARY, C.LYMOLC, C.MODEL, C.ITYPE, C.IEMSCT, C.IMULT, C.M1, C.M2, ...
        C.M3, C.M4, C.M5, C.M6, C.MDEF, C.I_RD2C, C.NOPRNT, C.TPTEMP, C.SURREF);
    end % WriteCard1
    function C = DescribeCard1(C, fid, OF)
      % OF is the format
      C.printPreCard(fid, OF, '1');
      C.printCardItem(fid, OF, 'MODTRN', '''%c''', 'The Spectral Band Model is ');
      switch upper(C.MODTRN)
        case {'T', 'M', ' '}
          fprintf(fid, 'the MODTRAN Band Model.\n');
        case {'C', 'K'}
          fprintf(fid, 'the MODTRAN correlated-k option Band Model (IEMSCT radiance modes only; most accurate but slower run time).\n');
        case {'F', 'L'}
          fprintf(fid, 'the 20~cm$^{-1}$ LOWTRAN Band Model (not recommended except for quick historic comparisons).\n');          
      end
      C.printCardItem(fid, OF, 'SPEED', '''%c''');
      switch upper(C.SPEED)
        case {'S', ' '}
          fprintf(fid, ['The ''slow'' speed Correlated-k algorithm using 33 absorption coefficients (k values) per spectral bin (1 cm^{-1}' ...
            'or 15 cm^{-1}). This option is recommended for upper altitude (> 40 km) cooling-rate and weighting-function calculations only.\n']);
        case 'M'
          fprintf(fid, 'The ''medium'' speed Correlated-k algorithm (17 k values).\n');
      end
      C.printCardItem(fid, OF, 'BINARY', '''%c''');
      switch upper(C.BINARY)
          case {'F', ' '}
              fprintf(fid, 'All MODTRAN outputs will be ASCII text files.\n');
          case 'T'
              fprintf(fid, 'The tape7, tape8 and plot files will be output in binary format.\n');
      end
      C.printCardItem(fid, OF, 'LYMOLC', '''%c''');
      switch upper(C.LYMOLC)
          case '+'
              fprintf(fid, 'Atmospheric model includes 16 auxiliary trace species with canned atmospheres or user-defined atmospheres where NMOLYC = 0 (Card 2C).\n'); 
          case ' '
              fprintf(fid, 'Atmospheric model excludes 16 auxiliary trace gase species.\n');
      end
      C.printCardItem(fid, OF, 'MODEL', '%d');
      switch C.MODEL
        case 0, fprintf(fid, 'That single-altitude meteorological data are specified (constant pressure, horizontal path only; see instructions for CARDs 2C, 2C1, 2C2, 2C2X, and 2C3).\n');
        case 1, fprintf(fid, 'The Tropical Atmosphere (15° North Latitude).\n');
        case 2, fprintf(fid, 'The Mid-Latitude Summer Atmosphere (45° North Latitude).\n');
        case 3, fprintf(fid, 'The Mid-Latitude Winter Atmosphere (45° North Latitude).\n');
        case 4, fprintf(fid, 'The Sub-Arctic Summer Atmosphere (60° North Latitude).\n');
        case 5, fprintf(fid, 'The Sub-Arctic Winter Atmosphere (60° North Latitude).\n');
        case 6, fprintf(fid, 'The 1976 US Standard Atmosphere.\n');
        case 7, fprintf(fid, 'A user-specified model atmosphere (e.g. radiosonde data) is to be read in; see instructions for CARDs 2C, 2C1, 2C2, 2C2X, and 2C3.\n');
      end
      C.printCardItem(fid, OF, 'ITYPE', '%d', 'The Line of Sight (LOS) is ');
      switch C.ITYPE
        case 1, fprintf(fid, 'a horizontal (constant-pressure) path, i.e., single layer, no refraction calculation.\n');
        case 2, fprintf(fid, 'a vertical or slant path between two altitudes.\n');
        case 3, fprintf(fid, 'a vertical or slant path to space or ground.\n');     
      end
      C.printCardItem(fid, OF, 'IEMSCT', '%d', 'MODTRAN will compute ');
      switch C.IEMSCT
        case 0, fprintf(fid, 'spectral transmittance of the LOS.\n');
        case 1, fprintf(fid, 'spectral thermal radiance (no sun/moon contributions) along the LOS.\n');
        case 2, fprintf(fid, 'spectral thermal plus solar/lunar radiance along the LOS (if IMULT = 0, only single scatter solar radiance is included).\n');
        case 3, fprintf(fid, 'directly transmitted spectral solar/lunar irradiance along the LOS.\n');
      end
      C.printCardItem(fid, OF, 'IMULT', '%d', 'MODTRAN executes ');
      switch C.IMULT
        case 0,  fprintf(fid, 'without computation of multiple scattering.\n');
        case {-1 1},  fprintf(fid, 'with computation of multiple scattering.\n');     
      end
      C.printCardItem(fid, OF, 'M1', '%d', 'Temperature and Pressure profiles default to ');
      switch C.M1
        case 0, fprintf(fid, 'whatever is specified by parameter MODEL above.\n');
        case 1, fprintf(fid, 'the Tropical Atmosphere (15° North Latitude).\n');
        case 2, fprintf(fid, 'the Mid-Latitude Summer Atmosphere (45° North Latitude).\n');
        case 3, fprintf(fid, 'the Mid-Latitude Winter Atmosphere (45° North Latitude).\n');
        case 4, fprintf(fid, 'the Sub-Arctic Summer Atmosphere (60° North Latitude).\n');
        case 5, fprintf(fid, 'the Sub-Arctic Winter Atmosphere (60° North Latitude).\n');
        case 6, fprintf(fid, 'the 1976 US Standard Atmosphere.\n');
      end
      C.printCardItem(fid, OF, 'M2', '%d', 'Water vapour profile defaults to ');
      switch C.M2
        case 0, fprintf(fid, 'whatever is specified by parameter MODEL above.\n');
        case 1, fprintf(fid, 'the Tropical Atmosphere (15° North Latitude).\n');
        case 2, fprintf(fid, 'the Mid-Latitude Summer Atmosphere (45° North Latitude).\n');
        case 3, fprintf(fid, 'the Mid-Latitude Winter Atmosphere (45° North Latitude).\n');
        case 4, fprintf(fid, 'the Sub-Arctic Summer Atmosphere (60° North Latitude).\n');
        case 5, fprintf(fid, 'the Sub-Arctic Winter Atmosphere (60° North Latitude).\n');
        case 6, fprintf(fid, 'the 1976 US Standard Atmosphere.\n');
      end
      C.printCardItem(fid, OF, 'M3', '%d', 'Ozone (O_3) profile defaults to ');      
      switch C.M3
        case 0, fprintf(fid, 'whatever is specified by parameter MODEL above.\n');
        case 1, fprintf(fid, 'the Tropical Atmosphere (15° North Latitude).\n');
        case 2, fprintf(fid, 'the Mid-Latitude Summer Atmosphere (45° North Latitude).\n');
        case 3, fprintf(fid, 'the Mid-Latitude Winter Atmosphere (45° North Latitude).\n');
        case 4, fprintf(fid, 'the Sub-Arctic Summer Atmosphere (60° North Latitude).\n');
        case 5, fprintf(fid, 'the Sub-Arctic Winter Atmosphere (60° North Latitude).\n');
        case 6, fprintf(fid, 'the 1976 US Standard Atmosphere.\n');
      end
      C.printCardItem(fid, OF, 'M4', '%d', 'Methane (CH_4) profile defaults to ');      
      switch C.M4
        case 0, fprintf(fid, 'whatever is specified by parameter MODEL above.\n');
        case 1, fprintf(fid, 'the Tropical Atmosphere (15° North Latitude).\n');
        case 2, fprintf(fid, 'the Mid-Latitude Summer Atmosphere (45° North Latitude).\n');
        case 3, fprintf(fid, 'the Mid-Latitude Winter Atmosphere (45° North Latitude).\n');
        case 4, fprintf(fid, 'the Sub-Arctic Summer Atmosphere (60° North Latitude).\n');
        case 5, fprintf(fid, 'the Sub-Arctic Winter Atmosphere (60° North Latitude).\n');
        case 6, fprintf(fid, 'the 1976 US Standard Atmosphere.\n');
      end
      C.printCardItem(fid, OF, 'M5', '%d', 'Nitrous Oxide (N_20) profile defaults to ');      
      switch C.M5
        case 0, fprintf(fid, 'whatever is specified by parameter MODEL above.\n');
        case 1, fprintf(fid, 'the Tropical Atmosphere (15° North Latitude).\n');
        case 2, fprintf(fid, 'the Mid-Latitude Summer Atmosphere (45° North Latitude).\n');
        case 3, fprintf(fid, 'the Mid-Latitude Winter Atmosphere (45° North Latitude).\n');
        case 4, fprintf(fid, 'the Sub-Arctic Summer Atmosphere (60° North Latitude).\n');
        case 5, fprintf(fid, 'the Sub-Arctic Winter Atmosphere (60° North Latitude).\n');
        case 6, fprintf(fid, 'the 1976 US Standard Atmosphere.\n');
      end
      C.printCardItem(fid, OF, 'M6', '%d', 'Carbon Monoxide (C0) profile defaults to ');      
      switch C.M6
        case 0, fprintf(fid, 'whatever is specified by parameter MODEL above.\n');
        case 1, fprintf(fid, 'the Tropical Atmosphere (15° North Latitude).\n');
        case 2, fprintf(fid, 'the Mid-Latitude Summer Atmosphere (45° North Latitude).\n');
        case 3, fprintf(fid, 'the Mid-Latitude Winter Atmosphere (45° North Latitude).\n');
        case 4, fprintf(fid, 'the Sub-Arctic Summer Atmosphere (60° North Latitude).\n');
        case 5, fprintf(fid, 'the Sub-Arctic Winter Atmosphere (60° North Latitude).\n');
        case 6, fprintf(fid, 'the 1976 US Standard Atmosphere.\n');
      end
      C.printCardItem(fid, OF, 'MDEF', '%d');      
      switch C.MDEF
        case {0 1}, fprintf(fid, 'Default O2, NO, SO2, NO2, NH3, and HNO3 species profiles as well as default heavy species.\n');
        case 2, fprintf(fid, 'The user must input heavy species (including chlorofluorocarbons) profiles (see card 2C series).\n');
      end
      C.printCardItem(fid, OF, 'I_RD2C', '%d');      
      switch C.I_RD2C
        case 0, fprintf(fid, 'For canned atmospheres or when calculations are to be run with the user-defined atmosphere last read in.\n');
        case 1, fprintf(fid, 'User input atmospheric data are to be read.\n');      
      end
      C.printCardItem(fid, OF, 'NOPRNT', '%d');      
      switch C.NOPRNT
        case 0, fprintf(fid, 'Normal output operation of program; normal tape6 (%s.tp6) output.\n', C.CaseName);
        case 1, fprintf(fid, 'Minimize printing of transmittance or radiance table and atmospheric profiles in tape6 (%s.tp6).\n', C.CaseName);
        case -1, fprintf(fid, 'Create additional tape8 (%s.tp8) output, including either weighting functions in transmission mode (IEMSCT = 0) or fluxes in radiation modes with multiplescattering on (IMULT = ±1 and IEMSCT = 1 or 2).\n', C.CaseName);
        case -2, fprintf(fid, 'Generate spectral cooling rate data in addition to the tape8 (%s.tp8) output; spectral cooling rates are written to the ''%s.clr'' file.\n', C.CaseName, C.CaseName);        
      end
      C.printCardItem(fid, OF, 'TPTEMP', '%g');      
      if C.TPTEMP > 0
        fprintf(fid, 'Boundary temperature (K) at H2 (far end from sensor/observer) to compute thermal radiance.\n');
      else
        fprintf(fid, 'No surface emission contributed at H2 (far end from sensor/observer) if H2 is above ground.\n');
      end
      C.printCardItem(fid, OF, 'SURREF', '''%s''');      
      Trimup = upper(strtrim(C.SURREF));
      if Trimup(1) == 'B'
        fprintf(fid, 'Surface spectral BRDFs (Bidirectional Reflectance Distribution Functions) are specified by CARD 4A, 4B1, 4B2 and 4B3 inputs.\n');        
      elseif Trimup(1) == 'L'
        fprintf(fid, 'Spectral Lambertian surface(s) is (are) specified by CARD 4A, 4L1 and 4L2 inputs.\n');
      elseif str2double(Trimup) >= 0
        fprintf(fid, 'Albedo of the earth (and at H2 if TPTEMP > 0), equal to one minus the surface emissivity and spectrally independent (constant). If the value exceeds one, the albedo is set to 1; if SURREF is blank, the albedo is set to 0.\n');
      elseif str2double(Trimup) < 0
        fprintf(fid, 'Negative integer values allow the user to access pre-stored spectrally variable surface albedos from the ''DATA/spec_alb.dat'' file.\n');
      end
        
    end % DescribeCard1
    function C = ReadCard1A(C, fid)
      % Old format for MODTRAN 4 was
      % DIS, DISAZM, NSTR, LSUN, ISUN, CO2MX, H2OSTR, O3STR, LSUNFL,
      % LBMNAM, LFLTNM, H2OAER, SOLCON
      % FORMAT (2L1, I3, L1, I4, F10.5, 2A10, 4(1X, A1), 2X, F10.3)
      % New format for MODTRAN 5 is
      % DIS, DISAZM, DISALB, NSTR, SFWHM, CO2MX, H2OSTR, O3STR, C_PROF, LSUNFL,
      % LBMNAM, LFLTNM, H2OAER, CDTDIR, SOLCON CDASTM, ASTMC, ASTMX, ASTMO,
      % AERRH, NSSALB
      % FORMAT (3A1, I3, F4.0, F10.0, 2A10, 2A1, 4(1X, A1), F10.0, A1, F9.0, 3F10.0, I10)
      Card = C.ReadSimpleCard(fid, [1 1 1 3 4 10 10 10 1 1 1 1 1 1 1 1 1 1 10 1 9 10 10 10 10], ...
       {'c', 'c','c','d', 'f', 'f','10c', '10c', 'c','c', '*','c','*','c','*','c','*', 'c', 'f', 'c', 'f','f','f','f','d'}, '1A');
      [C.DIS, C.DISAZM, C.DISALB, C.NSTR, C.SFWHM, C.CO2MX, C.H2OSTR, C.O3STR, C.C_PROF, ...
       C.LSUNFL, C.LBMNAM, C.LFLTNM, C.H2OAER, C.CDTDIR, C.SOLCON, ...
       C.CDASTM, C.ASTMC, C.ASTMX, C.ASTMO, C.AERRH, C.NSSALB] = Card{:};
      
    end % ReadCard1A
    function C = WriteCard1A(C, fid)
      fprintf(fid, '%c%c%c%3d%4.0f%10.0f%10s%10s%c%c %c %c %c %c%10.0f%c%9.0f%10.0f%10.0f%10.0f%10d\n', ...
        C.DIS, C.DISAZM, C.DISALB, C.NSTR, C.SFWHM, C.CO2MX, C.H2OSTR, C.O3STR, C.C_PROF, ...
       C.LSUNFL, C.LBMNAM, C.LFLTNM, C.H2OAER, C.CDTDIR, C.SOLCON, ...
       C.CDASTM, C.ASTMC, C.ASTMX, C.ASTMO, C.AERRH, C.NSSALB);
    end % WriteCard1A
    function C = DescribeCard1A(C, fid, OF)
      C.printPreCard(fid, OF, '1A')
      C.printCardItem(fid, OF, 'DIS', '''%c''');
      switch C.DIS
        case {'f', 'F', ' '}
          fprintf(fid, 'The Isaacs 2-stream algorithm is used for multiple scattering (as opposed to DISORT).\n');
        case {'t', 'T'}
          fprintf(fid, 'The DISORT discrete ordinates algoritm is used for multiple scattering.\n');
      end
      C.printCardItem(fid, OF, 'DISAZM', '''%c''', 'DISORT (if enabled with parameter DIS) will run ');
      switch C.DISAZM
        case {'f', 'F', ' '}
          fprintf(fid, 'without azimuth dependent multiple scattering (if requested with IMULT).\n');
        case {'t', 'T'}
          fprintf(fid, 'with azumuth dependent multiple scattering (if requested with IMULT).\n');
      end
      C.printCardItem(fid, OF, 'DISALB', '''%c''');
      switch C.DISALB
          case {'t', 'T'}
              fprintf(fid, 'For DISORT mutiple solar scatter radiance cases, atmospheric correction data will be computed.\n');
          case {'f', 'F', ' '}
              fprintf(fid, 'Atmospheric correction data will not be computed.\n');
      end
      C.printCardItem(fid, OF, 'NSTR', '%d', ['DISORT (if enabled with parameters IMULT and DIS) will '...
                                                  'execute with this number of streams.\n']);
%      C.printCardItem(fid, OF, 'LSUN', '''%c''');
%       switch C.LSUN
%         case {'f', 'F', ' '}
%           fprintf(fid, 'MODTRAN will use the default solar 5 cm^{-1} spectral resolution TOA irradiances.\n');
%         case {'t', 'T'}
%           fprintf(fid, 'MODTRAN will use the default solar 1 cm^{-1} binned spectral resolution TOA irradiances. Input of ISUN is mandatory.\n');
%       end
      C.printCardItem(fid, OF, 'SFWHM', '%d', ['The FWHM (Full Width at Half Maximum) of the triangular scanning function '...
                       'used to smooth the TOA solar irradiance (wavenumbers).\n']);
      C.printCardItem(fid, OF, 'CO2MX', '%g', 'The CO_2 mixing ratio in ppmv (parts per million by volume)\n');
      C.printCardItem(fid, OF, 'H2OSTR', '''%s''', 'Vertical water vapor column modifier (g/cm^{2}, atm-cm or scaling factor).\n');
      C.printCardItem(fid, OF, 'O3STR', '''%s''', 'Vertical ozone column modifier (g/cm^{2}, atm-cm or scaling factor).\n');
      C.printCardItem(fid, OF, 'C_PROF', '''%c''');
      switch C.C_PROF
          case {'0', ' '}
              fprintf(fid, 'There will be no scaling of default molecular profiles.\n');
          case '1'
              fprintf(fid, 'Default profile scale factors are read in on CARD 1A5 for 10 uniformly mixed molecular species.\n');
          case '2'
              fprintf(fid, 'Default profile scale factors are read in on CARD 1A6 for 13 cross-section molecular species.\n');
          case '3'
              fprintf(fid, 'Default profile scale factors are read in on CARDs 1A5 and 1A6 for 10 uniformly mixed and 13 cross-section molecular species.\n');
          case '4'
              fprintf(fid, 'Default profile scale factors are read in on CARD 1A7 for 16 trace molecular species.\n');
          case '5'
              fprintf(fid, 'Default profile scale factors are read in on CARDs 1A5 and 1A7 for 10 uniformly mixed and 16 trace molecular species.\n');
          case '6'
              fprintf(fid, 'Default profile scale factors are read in on CARDs 1A6 and 1A7 for 13 cross-section and 16 trace molecular species.\n');
          case '7'
              fprintf(fid, 'Default profile scale factors are read in on CARDs 1A5, 1A6 and 1A7 for 10 uniformly mixed, 13 cross-section and 16 trace molecular species.\n');
      end
      C.printCardItem(fid, OF, 'LSUNFL', '''%c''', 'If true, read solar irradiance from file named on Card 1A1.\n');
      C.printCardItem(fid, OF, 'LBMNAM', '''%c''', 'If true, read band model from file named on Card 1A2.\n');
      C.printCardItem(fid, OF, 'LFLTNM', '''%c''', 'If true, read instrument band filter data from file named on Card 1A3.\n');
      C.printCardItem(fid, OF, 'H2OAER', '''%c''', 'If true, humidity-based modifications are applied to the aerosols based on water column scaling (H2OSTR).\n');
      C.printCardItem(fid, OF, 'SOLCON', '%g');
      if C.SOLCON < 0
        fprintf(fid, 'Solar TOA irradiance is scaled by this factor.\n');
      elseif C.SOLCON > 0
        fprintf(fid, 'Solar TOA constant is set to this value in W/m^2.\n');        
      else
        fprintf(fid, 'Solar TOA irradiance is not scaled.\n');
      end
    end % DescribeCard1A
    function C = ReadCard1A1(C, fid)
      % USRSUN
      % FORMAT (A80) (If LSUNFL = True)
      Card = C.ReadSimpleCard(fid, 256,{'256c'},'1A1');
      C.LSUNFL = Card{1};
    end % ReadCard1A1
    function C = WriteCard1A1(C, fid)
      fprintf(fid, '%s\n', C.USRSUN);
    end % WriteCard1A1
    function C = DescribeCard1A1(C, fid, OF)
      C.printPreCard(fid, OF, '1A1');
      C.printCardItem(fid, OF, 'USRSUN', '''%s''', 'Solar TOA irradiance database.\n');
    end % DescribeCard1A1
    function C = ReadCard1A2(C, fid)
      % BMNAME
      % FORMAT (A256) (If LBMNAM = True)
      Card = C.ReadSimpleCard(fid, 256,{'256c'},'1A2');
      C.BMNAME = Card{1};
    end % ReadCard1A2
    function C = WriteCard1A2(C, fid)
      fprintf(fid, '%s\n', C.BMNAME);
    end % WriteCard1A2
    function C = DescribeCard1A2(C, fid, OF)
      C.printPreCard(fid, OF, '1A2')
      C.printCardItem(fid, OF, 'BMNAME', '''%s''', 'Band model database file.\n');
    end % DescribeCard1A2
    function C = ReadCard1A3(C, fid)
      % FILTNM
      % FORMAT (A256) (If LFLTNM = True)
      Card = C.ReadSimpleCard(fid, 256,{'256c'},'1A3');
      C.FILTNM = Card{1};
    end % ReadCard1A3 
    function C = WriteCard1A3(C, fid)
      fprintf(fid, '%s\n', C.FILTNM);
    end % WriteCard1A3
    function C = DescribeCard1A3(C, fid, OF)
      C.printPreCard(fid, OF, '1A3')
      C.printCardItem(fid, OF, 'FILTNM', '''%s''', 'Observation instrument spectral band definition file.\n');
    end % DescribeCard1A3  
    
    function C = ReadCard1A4(C, fid)
      % DATDIR
      % FORMAT (A256) (If CDTDIR = True)
      Card = C.ReadSimpleCard(fid, 256,{'256c'},'1A4');
      C.DATDIR = Card{1};
    end % ReadCard1A4 
    function C = WriteCard1A4(C, fid)
      fprintf(fid, '%s\n', C.DATDIR);
    end % WriteCard1A4
    function C = DescribeCard1A4(C, fid, OF)
      C.printPreCard(fid, OF, '1A4')
      C.printCardItem(fid, OF, 'DATDIR', '''%s''', 'Pathname for the MODTRAN data files.\n');
    end % DescribeCard1A4  

    
    function C = ReadCard2(C, fid)
      % (A2, I3, A1, I4, A3, I2, 3(I5), 5F10.5
      Card = C.ReadSimpleCard(fid, [2 3 1 4 3 2 5 5 5 10 10 10 10 10], ...
        {'c','d','c','d','c','d','d','d,','d','f','f','f','f','f'}, '2');
      [C.APLUS, C.IHAZE, C.CNOVAM, C.ISEASN, C.ARUSS, C.IVULCN, C.ICSTL, C.ICLD, ...
       C.IVSA, C.VIS, C.WSS, C.WHH, C.RAINRT, C.GNDALT] = Card{:};
    end % ReadCard2
    function C = WriteCard2(C, fid)
      fprintf(fid, '%2s%3d%c%4d%3s%2d%5d%5d%5d%10.5f%10.5f%10.5f%10.5f%10.5f\n', ...
        C.APLUS, C.IHAZE, C.CNOVAM, C.ISEASN, C.ARUSS, C.IVULCN, C.ICSTL, C.ICLD, ...
        C.IVSA, C.VIS, C.WSS, C.WHH, C.RAINRT, C.GNDALT);
    end % WriteCard2
    function C = ReadCard2APlus(C, fid) % There are two cards to be read here
      % (3(1X, F9.0), 20X, 3(1X, F9.0)) 2 cards
      Card = C.ReadSimpleCard(fid, [1 9 1 9 1 9 20 1 9 1 9 1 9], ...
        {'*','f','*','f','*','f','*','*','f','*','f','*','f'}, '2A+');
      [C.ZAER11, C.ZAER12, C.SCALE1, C.ZAER21, C.ZAER22, C.SCALE2] = Card{:};
      Card = C.ReadSimpleCard(fid, [1 9 1 9 1 9 20 1 9 1 9 1 9], ...
        {'*','f','*','f','*','f','*','*','f','*','f','*','f'}, '2A+');      
      [C.ZAER31, C.ZAER32, C.SCALE3, C.ZAER41, C.ZAER42, C.SCALE4] = Card{:};
    end % ReadCard2APlus
    function C = WriteCard2APlus(C, fid)
      fprintf(fid, [' %9.0f %9.0f %9.0f' blanks(20) ' %9.0f %9.0f %9.0f\n' ], ...
        C.ZAER11, C.ZAER12, C.SCALE1, C.ZAER21, C.ZAER22, C.SCALE2);
      fprintf(fid, [' %9.0f %9.0f %9.0f' blanks(20) ' %9.0f %9.0f %9.0f\n' ], ...
        C.ZAER31, C.ZAER32, C.SCALE3, C.ZAER41, C.ZAER42, C.SCALE4);      
    end % WriteCard2APlus
    function C = ReadCard2A(C, fid)
      % (3F8.3)
      Card = C.ReadSimpleCard(fid, [8 8 8], {'f','f','f'}, '2A');
      [C.CTHIK, C.CALT, C.CEXT] = Card{:};
    end % ReadCard2A
    function C = WriteCard2A(C, fid)
      fprintf(fid, '%8.3f%8.3f%8.3f\n', C.CTHIK, C.CALT, C.CEXT);
    end % WriteCard2A
    function C = ReadCardAlt2A(C, fid)
      % 3F8.3, 2I4, 6F8.3
      Card = C.ReadSimpleCard(fid, [8 8 8 4 4 8 8 8 8 8 8], {'f','f','f','d','d','f','f','f','f','f','f'}, 'Alt2A');
      [C.CTHIK, C.CALT, C.CEXT, C.NCRALT, C.NCRSPC, C.CWAVLN, C.CCOLWD, C.CCOLIP, C.CHUMID, C.ASYMWD, C.ASYMIP] = Card{:};
    end % ReadCardAlt2A
    function C = WriteCardAlt2A(C, fid)
      fprintf(fid, '%8.3f%8.3f%8.3f%4d%4d%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f\n', ...
        C.CTHIK, C.CALT, C.CEXT, C.NCRALT, C.NCRSPC, C.CWAVLN, C.CCOLWD, C.CCOLIP, C.CHUMID, C.ASYMWD, C.ASYMIP);
    end % WriteCardAlt2A
    function C = ReadCard2B(C, fid)
      % 3F10.3
      Card = C.ReadSimpleCard(fid, [10 10 10], {'f','f','f'}, '2B');
      [C.ZCVSA, C.ZTVSA, C.ZINVSA] = Card{:};
    end % ReadCard2B
    function C = WriteCard2B(C, fid)
      fprintf(fid, '%10.3f%10.3f%10.3f\n', C.ZCVSA, C.ZTVSA, C.ZINVSA);
    end % WriteCard2B
    function C = ReadCard2C(C, fid)
      % FORMAT(3I5, A65)
      Card = C.ReadSimpleCard(fid, [5 5 5 65], {'d','d','d','65c'}, '2C');
      [C.ML, C.IRD1, C.IRD2, C.HMODEL] = Card{:};
      % Put the atmosphere title into the subcase short description
      if isempty(C.CaseDescr)
        C.CaseDescr = strtrim(C.HMODEL);
      end
    end % ReadCard2C
    function C = WriteCard2C(C, fid)
      fprintf(fid, '%5d%5d%5d%65s\n',C.ML, C.IRD1, C.IRD2, C.HMODEL);
    end % WriteCard2C
    function C = ReadCard2C1(C, fid, iML)
      % F10.3, 5E10.3, 14A1, 1X, A1
      Card = C.ReadSimpleCard(fid, [10 10 10 10 10 10 14 1 1], ...
        {'f','e','e','e','e','e','14c','*','c'}, '2C1');
      [tZM, tP, tT, WMOL1, WMOL2, WMOL3, tJCHAR, tJCHARX] = Card{:};
      C.ZM(iML,1) = tZM;
      C.P(iML,1) = tP;
      C.T(iML,1) = tT;
      C.JCHAR(iML,:) = tJCHAR;
      C.JCHAR = char(C.JCHAR);
      C.JCHARX(iML) = tJCHARX;
      C.JCHARX = char(C.JCHARX);
      C.WMOL(iML,1:3) = [WMOL1 WMOL2 WMOL3];
    end % ReadCard2C1
    function C = WriteCard2C1(C, fid, iML)
      % Note : Using %E produces three digits in the exponent 0.00E+000 - Will MODTRAN read this correctly ???????
      if ispc
        lin = sprintf('%10.3f%11.3E%11.3E%11.3E%11.3E%11.3E%14s %c', ...
          C.ZM(iML,1), C.P(iML,1), C.T(iML,1),  C.WMOL(iML,1:3), char(C.JCHAR(iML,:)), char(C.JCHARX(iML)));
        lin = strrep(lin, 'E+0', 'E+');
        lin = strrep(lin, 'E-0', 'E-');
        fprintf(fid, '%s\n', lin);
      else
      fprintf(fid, '%10.3f%10.3E%10.3E%10.3E%10.3E%10.3E%14s %c\n', ...
            C.ZM(iML,1), C.P(iML,1), C.T(iML,1),  C.WMOL(iML,1:3), char(C.JCHAR(iML,:)), char(C.JCHARX(iML)));
      end
      
    end % WriteCard2C1
    function C = ReadCard2C2(C, fid, iML)
      % WMOL(J), J=4, 12 FORMAT (8E10.3, /E10.3)
      Card = C.ReadSimpleCard(fid, [10 10 10 10 10 10 10 10 10], ...
        {'e','e','e','e','e','e','e','e','e'}, '2C2');
      [A4, A5, A6, A7, A8, A9, A10, A11, A12] = Card{:};
      C.WMOL(iML, 4:12) = [A4, A5, A6, A7, A8, A9, A10, A11, A12];
    end % ReadCard2C2
    function C = WriteCard2C2(C, fid, iML)
      if ispc
        lin = sprintf('%11.3E%11.3E%11.3E%11.3E%11.3E%11.3E%11.3E%11.3E\n%11.3E', C.WMOL(iML, 4:12)); 
        lin = strrep(lin, 'E+0', 'E+');
        lin = strrep(lin, 'E-0', 'E-');
        fprintf(fid, '%s\n', lin);
      else
        fprintf(fid, '%10.3E%10.3E%10.3E%10.3E%10.3E%10.3E%10.3E%10.3E\n%10.3E\n', C.WMOL(iML, 4:12));
      end
    end % WriteCard2C2
    function C = ReadCard2C2X(C, fid, iML)
      %(WMOLX(J), J=1, 13) (If MDEF=2 & IRD1=1)
      % FORMAT (8E10.3, /5E10.3)      
      Card = C.ReadSimpleCard(fid, [10 10 10 10 10 10 10 10 10 10 10 10 10], ...
        {'e','e','e','e','e','e','e','e','e','e','e','e','e'}, '2C2X');
      [WMOLX1, WMOLX2, WMOLX3, WMOLX4, WMOLX5, WMOLX6, WMOLX7, ...
       WMOLX8, WMOLX9, WMOLX10, WMOLX11, WMOLX12, WMOLX13] = Card{:};
      C.WMOLX(iML,:) = [WMOLX1, WMOLX2, WMOLX3, WMOLX4, WMOLX5, WMOLX6, WMOLX7, ...
       WMOLX8, WMOLX9, WMOLX10, WMOLX11, WMOLX12, WMOLX13];
    end % ReadCard2C2X
    function C = WriteCard2C2X(C, fid, iML)
      if ispc
        lin = sprintf('%11.3E%11.3E%11.3E%11.3E%11.3E%11.3E%11.3E%11.3E\n%11.3E%11.3E%11.3E%11.3E%11.3E', C.WMOLX(iML, :));
        lin = strrep(lin, 'E+0', 'E+');
        lin = strrep(lin, 'E-0', 'E-');
        fprintf(fid, '%s\n', lin);
      else
        fprintf(fid, '%10.3E%10.3E%10.3E%10.3E%10.3E%10.3E%10.3E%10.3E\n%10.3E%10.3E%10.3E%10.3E%10.3E\n', C.WMOLX(iML, :));
      end
    end % WriteCard2C2X
    function C = ReadCard2C3(C, fid, iML)
      % FORMAT (10X, 3F10.3, 5I5)
      Card = C.ReadSimpleCard(fid, [10 10 10 10 5 5 5 5 5], {'*','f','f','f','d','d','d','d','d'}, '2C3');
      [tAHAZE, tEQLWCZ, tRRATZ, tIHA1, tICLD1, tIVUL1, tISEA1, tICHR1] = Card{:};
      C.AHAZE(iML,1) = tAHAZE;
      C.EQLWCZ(iML,1) = tEQLWCZ;
      C.RRATZ(iML,1) = tRRATZ;
      C.IHA1(iML,1) = tIHA1;
      C.ICLD1(iML,1) = tICLD1;
      C.IVUL1(iML,1) = tIVUL1;
      C.ISEA1(iML,1) = tISEA1;
      C.ICHR1(iML,1) = tICHR1;
    end % ReadCard2C3
    function C = WriteCard2C3(C, fid, iML)
      fprintf(fid, '          %10.3f%10.3f%10.3f%5d%5d%5d%5d%5d\n', ...
              C.AHAZE(iML,1), C.EQLWCZ(iML,1), C.RRATZ(iML,1), C.IHA1(iML,1), ...
              C.ICLD1(iML,1), C.IVUL1(iML,1), C.ISEA1(iML,1), C.ICHR1(iML,1));

    end % WriteCard2C3
    function C = ReadCard2D(C, fid)
      % FORMAT (4I5)
      Card = C.ReadSimpleCard(fid, [5 5 5 5], {'d','d','d','d'}, '2D');
      [IREG1,IREG2,IREG3,IREG4] = Card{:};
      C.IREG = [IREG1 IREG2 IREG3 IREG4];
      
    end % ReadCard2D
    function C = WriteCard2D(C, fid)
      fprintf(fid, '%5d%5d%5d%5d\n', C.IREG);
    end % WriteCard2D
    function C = ReadCard2D1(C, fid, iNREG)
      % FORMAT (E10.3, A70)
      Card = C.ReadSimpleCard(fid, [10 70], {'e', '70c'}, '2D1');
      [tAWCCON, tTITLE] = Card{:};
      C.AWCCON(iNREG,1) = tAWCCON;
      C.TITLE = strvcat(C.TITLE, char(tTITLE));
    end % ReadCard2D1
    function C = WriteCard2D1(C, fid, iNREG)
      if ispc
        lin = sprintf('%11.3E%70s', C.AWCCON(iNREG,1), C.TITLE(iNREG,:));
        lin = strrep(lin, 'E+0', 'E+');
        lin = strrep(lin, 'E-0', 'E-');
        fprintf(fid, '%s\n', lin);
      else
        fprintf(fid, '%10.3E%70s\n', C.AWCCON(iNREG,1), C.TITLE(iNREG,:));
      end
    end % WriteCard2D1
    function C = ReadCard2D2(C, fid, iNREG, nSets)
      % CARD 2D2: (VARSPC(I), EXTC(N, I), ABSC(N, I), ASYM(N, I), I=l, 2, ...,)
      % If IREG(N)=1: I=1, 2, ..., 47
      % If ARUSS = 'USS', I=1, 2, ..., IREG(N)
      % FORMAT ((3(F6.2, 2F7.5, F6.4)))
      % This function is wrong and needs attention !
      % There are 3 sets of 4 numbers (12 numbers) per line.
      % Therefore the number of cards is ...
      nCards = ceil(nSets/3);
      % warning('ReadCard2D2:CouldBeBroken', 'Reading of Card 2D2 could be incorrect - check you results.')
      Widths = repmat([6 7 7 6], 1, 3); % 3 sets of 4 numbers per card
      Formats = repmat({'f','f','f','f'}, 1, 3);
      Data = [];
      for iCard = 1:nCards
        Card = C.ReadSimpleCard(fid, Widths, Formats, '2D2');
        Data = [Data Card{:}];
      end
%       if length(Data) ~= nSets * 4
%         warning('Mod5:ReadCard2D2InsufficientData','There was insufficient data provided on the 2D2 card series.')
%       end
      % Distribute the resulting data to the four variables
      iPoint = 1;
      for iSet = 1:nSets     
        C.VARSPC(iNREG, iSet) = Data(iPoint);
        C.EXTC(iNREG, iSet) = Data(iPoint+1);
        C.ABSC(iNREG, iSet) = Data(iPoint+2);
        C.ASYM(iNREG, iSet) = Data(iPoint+3);
        iPoint = iPoint + 4;
      end
    end % ReadCard2D2
    function C = WriteCard2D2(C, fid, iNREG, nSets)
      nCards = ceil(nSets/3); % Total number of cards to write
      iSet = 1;
      for iCard = 1:nCards
        fprintf(fid, '%6.2f%7.5f%7.5f%6.4f',C.VARSPC(iNREG, iSet), C.EXTC(iNREG, iSet), C.ABSC(iNREG, iSet), C.ASYM(iNREG, iSet));
        iSet = iSet + 1;
        if iSet > nSets
          fprintf(fid, '\n');
          break; 
        end
        fprintf(fid, '%6.2f%7.5f%7.5f%6.4f',C.VARSPC(iNREG, iSet), C.EXTC(iNREG, iSet), C.ABSC(iNREG, iSet), C.ASYM(iNREG, iSet));
        iSet = iSet + 1;
        if iSet > nSets
          fprintf(fid, '\n');
          break; 
        end
        fprintf(fid, '%6.2f%7.5f%7.5f%6.4f\n',C.VARSPC(iNREG, iSet), C.EXTC(iNREG, iSet), C.ABSC(iNREG, iSet), C.ASYM(iNREG, iSet));
        iSet = iSet + 1;
      end
    end % WriteCard2D2    
    function C = ReadCard2E1(C, fid, iNCRALT)
      % (ZCLD(I, 0), CLD(I, 0), CLDICE(I, 0), RR(I, 0), I = 1, NCRALT)
      % FORMAT((4F10.5)) (If ICLD = 1 - 10, NCRALT <= 3)
      % Not too sure about this one either
      Card = C.ReadSimpleCard(fid, [10 10 10 10],{'f','f','f','f'}, '2E1');
      [tZCLD, tCLD, tCLDICE, tRR] = Card{:};
      C.ZCLD(iNCRALT,1) = tZCLD;
      C.CLD(iNCRALT,1) = tCLD;
      C.CLDICE(iNCRALT,1) = tCLDICE;
      C.RR(iNCRALT,1)= tRR;
    end % ReadCard2E1
    function C = WriteCard2E1(C, fid, iNCRALT)
      fprintf(fid, '%10.5f%10.5f%10.5f%10.5f\n', C.ZCLD(iNCRALT,1), C.CLD(iNCRALT,1), C.CLDICE(iNCRALT,1), C.RR(iNCRALT,1));
    end % WriteCard2E1
    function C = ReadCard2E2(C, fid, iNCRSPC)
      % (WAVLEN(I), EXTC(6, I), ABSC(6, I), ASYM(6, I), EXTC(7, I),
      % ABSC(7, I), ASYM(7, I), I = 1, NCRSPC)(if ICLD = 1 - 10, NCRSPC <= 2)
      % FORMAT(7F10.5)
        Card = C.ReadSimpleCard(fid, [10 10 10 10 10 10 10], {'f','f','f','f','f','f','f'}, '2E2');
        [tWAVLEN, EXTC6, ABSC6, ASYM6, EXTC7, ABSC7, ASYM7] = Card{:};
        C.WAVLEN(iNCRSPC) = tWAVLEN;
        C.EXTC(6, iNCRSPC) = EXTC6;
        C.ABSC(6, iNCRSPC) = ABSC6;
        C.ASYM(6, iNCRSPC) = ASYM6;
        C.EXTC(7, iNCRSPC) = EXTC7;
        C.ABSC(7, iNCRSPC) = ABSC7;
        C.ASYM(7, iNCRSPC) = ASYM7;
    end % ReadCard2E2
    function C = WriteCard2E2(C, fid, iNCRSPC)
      fprintf(fid, '%10.5f%10.5f%10.5f%10.5f%10.5f%10.5f%10.5f\n', C.WAVLEN(iNCRSPC), C.EXTC(6, iNCRSPC), C.ABSC(6, iNCRSPC), ...
        C.ASYM(6, iNCRSPC), C.EXTC(7, iNCRSPC), C.ABSC(7, iNCRSPC), C.ASYM(7, iNCRSPC));
    end % WriteCard2E2
    function MC = ReadCard3Series(MC, fid)
      % ReadCard3Series : Read all 3-series cards, Line of Sight Geometry
      % Card 3 - Line of Sight Geometry
      if MC.IEMSCT == 3
        MC = MC.ReadCardAlt3(fid); % Read alternate form of Card 3
      else
        MC = MC.ReadCard3(fid); % Read normal form of Card 3
      end
      if MC.IEMSCT == 2
        MC = MC.ReadCard3A1(fid);
        MC = MC.ReadCard3A2(fid);
      end
      if MC.IPH == 1
        MC = MC.ReadCard3B1(fid);
        if MC.NWLF == 0
          MC = MC.ReadCard3B2(fid);
        elseif MC.NWLF > 0 % Read Cards 3C1 to 3C6
          % warning('Mod5:FnotReadRight','Reading of F on Cards 3C1 to 3C6 could be incorrect.')
          MC = MC.ReadCard3C1(fid);
          MC = MC.ReadCard3C2(fid);
          for iNANGLS = 1:MC.NANGLS
            MC = MC.ReadCard3C3(fid, iNANGLS);
            MC = MC.ReadCard3C4(fid, iNANGLS);
            MC = MC.ReadCard3C5(fid, iNANGLS);
            MC = MC.ReadCard3C6(fid, iNANGLS);
          end
        end
      end

    end % ReadCard3Series - Reads all 3-series cards
    function MC = WriteCard3Series(MC, fid)
      % WriteCard3Series : Write all 3-series cards, Line of Sight Geometry
      % Card 3 - Line of Sight Geometry
      if MC.IEMSCT == 3
        MC = MC.WriteCardAlt3(fid); % Write alternate form of Card 3
      else
        MC = MC.WriteCard3(fid); % Write normal form of Card 3
      end
      if MC.IEMSCT == 2
        MC = MC.WriteCard3A1(fid);
        MC = MC.WriteCard3A2(fid);
      end
      if MC.IPH == 1
        MC = MC.WriteCard3B1(fid);
        if MC.NWLF == 0
          MC = MC.WriteCard3B2(fid);
        elseif MC.NWLF > 0 % Write Cards 3C1 to 3C6
          %warning('Mod5:FnotWriteRight','Writing of F on Cards 3C1 to 3C6 could be incorrect.')
          MC = MC.WriteCard3C1(fid);
          MC = MC.WriteCard3C2(fid);
          for iNANGLS = 1:MC.NANGLS
            MC = MC.WriteCard3C3(fid, iNANGLS);
            MC = MC.WriteCard3C4(fid, iNANGLS);
            MC = MC.WriteCard3C5(fid, iNANGLS);
            MC = MC.WriteCard3C6(fid, iNANGLS);
          end
        end
      end
      
    end % WriteCard3Series
    function MC = DescribeCard3Series(MC, fid, OF)
      if MC.IEMSCT == 3
        MC = MC.DescribeCardAlt3(fid, OF); % Describe alternate form of Card 3
      else
        MC = MC.DescribeCard3(fid, OF); % Describe normal form of Card 3
      end
      if MC.IEMSCT == 2
        MC = MC.DescribeCard3A1(fid, OF);
        MC = MC.DescribeCard3A2(fid, OF);
      end
    end % DescribeCard3Series
    function C = ReadCard3(C, fid)
      %     H1, H2, ANGLE, RANGE, BETA, RO, LENN, PHI
      %     FORMAT (6F10.3, I5, 5X, F10.3)
      Card = C.ReadSimpleCard(fid, [10 10 10 10 10 10 5 5 10], {'f','f','f','f','f','f','d','*','f'}, '3');
      [C.H1, C.H2, C.ANGLE, C.RANGE, C.BETA, C.RO, C.LENN, C.PHI] = Card{:};
    end % ReadCard3
    function C = WriteCard3(C, fid)
      fprintf(fid, '%10.3f%10.3f%10.3f%10.3f%10.3f%10.3f%5d     %10.3f\n', ...
        C.H1, C.H2, C.ANGLE, C.RANGE, C.BETA, C.RO, C.LENN, C.PHI);
    end % WriteCard3
    function C = DescribeCard3(C, fid, OF)
      C.printPreCard(fid, OF, '3');
      fprintf(fid, '%% The Line of Sight (LOS) is ');
      switch C.ITYPE
        case 1, fprintf(fid, 'a horizontal (constant-pressure) path, i.e., single layer, no refraction calculation.\n');
        case 2, fprintf(fid, 'a vertical or slant path between two altitudes.\n');
        case 3, fprintf(fid, 'a vertical or slant path to space or ground.\n');     
      end
      
      % Figure out which combination of card 3 inputs is relevant
      switch C.ITYPE
        case 1
          Mandatory = [1 0 0 1 0 0]; % Case 1          
          iCase = 1;
          LENNOption = 0;
        case 2
          Mandatory = [1 1 1 0 0 0;  % Case 2a
                       1 0 1 1 0 0;  % Case 2b
                       1 1 0 1 0 0;  % Case 2c
                       1 1 0 0 1 0;  % Case 2d
                       1 1 0 0 0 1;  % Case 2e
                       0 1 0 1 0 1]; % Case 2f
          LENNOption = [1 0 0 0 1 0];
          if C.PHI > 0 && C.RANGE > 0
            iCase = 6; % 2f
          elseif C.PHI > 0
            iCase = 5; % 2e
          elseif C.BETA > 0
            iCase = 4; % 2d
          elseif C.RANGE > 0 && C.ANGLE > 0
            iCase = 2; % 2b
          elseif C.RANGE > 0
            iCase = 3; % 2c
          else 
            iCase = 1; % 2a
          end
          Mandatory = Mandatory(iCase, :);
          LENNOption = LENNOption(iCase);
        case 3
          Mandatory = [1 0 1 0 0 0;  % Case 3a
                       1 1 0 0 0 0;  % Case 3b
                       1 1 0 0 0 1]; % Case 3c
          LENNOption = 0;
          if C.PHI > 0
            iCase = 3; % 3c
          elseif C.H2 == 0
            iCase = 1; % 3a
          else 
            iCase = 2; % 3b
          end
          Mandatory = Mandatory(iCase, :);  
      end
      % Print all, but indicate which are ignored
      if Mandatory(1) % H1
        C.printCardItem(fid, OF, 'H1', '%g', 'Initial path altitude in km.\n');
      else
        C.printCardItem(fid, OF, 'H1', '%g', 'Not used in this case. (Initial path altitude in km.)\n');        
      end
      if Mandatory(2) % H2
        switch C.ITYPE
          case 2
            C.printCardItem(fid, OF, 'H2', '%g', 'Final path altitude in km.\n');
          case 3
            C.printCardItem(fid, OF, 'H2', '%g', 'Path tangent altitude in km.\n');
        end
      else
         C.printCardItem(fid, OF, 'H2', '%g', 'Not used in this case. (Final path altitude in km.)\n');
      end
      if Mandatory(3) % ANGLE
        C.printCardItem(fid, OF, 'ANGLE', '%g', 'Initial zenith angle at H1 in degrees.\n');
      else
        C.printCardItem(fid, OF, 'ANGLE', '%g', 'Not used in this case. (Initial zenith angle at H1 in degrees.)\n');        
      end
      if Mandatory(4) % RANGE
        C.printCardItem(fid, OF, 'RANGE', '%g', 'Path length in km.\n');
      else
        C.printCardItem(fid, OF, 'RANGE', '%g', 'Not used in this case. (Path length in km).\n');                
      end
      if Mandatory(5) % BETA
        C.printCardItem(fid, OF, 'BETA', '%g', 'Earth centre angle (in degrees) subtended by path from H1 to H2.\n');   
      else
        C.printCardItem(fid, OF, 'BETA', '%g', 'Not used in this case. (Earth centre angle in degrees subtended by path from H1 to H2.)\n');   
      end
      if C.RO == 0
        C.printCardItem(fid, OF, 'RO', '%g', 'Radius of the earth in km at the path latitude. Will default to a value depending on MODEL.\n');
      else
        C.printCardItem(fid, OF, 'RO', '%g', 'Radius of the earth in km at the path latitude.\n');        
      end
      if Mandatory(6) % PHI
        C.printCardItem(fid, OF, 'PHI', '%g', 'Zenith angle (in degrees) at H2.\n');
      else
        C.printCardItem(fid, OF, 'PHI', '%g', 'Not used in this case. (Zenith angle in degrees at H2.)\n');        
      end
    end % DescribeCard3
    function C = ReadCardAlt3(C, fid)
      % H1, H2, ANGLE, IDAY, RO, ISOURC, ANGLEM (If IEMSCT=3)
      % FORMAT (3F10.3, I5, 5X, F10.3, I5, F10.3)
      Card = C.ReadSimpleCard(fid, [10 10 10 5 5 10 5 10], {'f','f','f','d','*','f','d','f'}, 'Alt3');
      [C.H1, C.H2, C.ANGLE, C.IDAY, C.RO, C.ISOURC, C.ANGLEM] = Card{:};
    end % ReadCardAlt3
    function C = WriteCardAlt3(C, fid)
      fprintf(fid, '%10.3f%10.3f%10.3f%5d     %10.3f%5d%10.3f\n', ...
        C.H1, C.H2, C.ANGLE, C.IDAY, C.RO, C.ISOURC, C.ANGLEM);
    end % WriteCardAlt3
    function C = DescribeCardAlt3(C, fid, OF)
      % Describe the alternate form of the LOS geometry card
      C.printPreCard(fid, OF, 'Alt3');
      if C.ITYPE == 3
        fprintf(fid, '%% The Line of Sight (LOS) is a vertical or slant path to the ');
        switch C.ISOURC
          case 0
            fprintf(fid, 'Sun, for a solar irradiance calculation.\n');
          case 1
            fprintf(fid, 'Moon, for a lunar irradiance calculation.\n');
        end
        
      else
        fprintf(fid, '%% Warning : The path type should be ITYPE = 3, but is ITYPE = %d.', C.ITYPE);
      end
      C.printCardItem(fid, OF, 'H1', '%10.3f', 'Sensor/Observer altitude in km.\n');
      if C.H2 > 0
        C.printCardItem(fid, OF, 'H2', '%10.3f', 'Tangent height of path to Sun or Moon in km.\n');
      else
        C.printCardItem(fid, OF, 'H2', '%10.3f', 'Not used in this case (Tangent height of path to Sun or Moon in km).\n');
      end
      if C.IDAY > 0
        C.printCardItem(fid, OF, 'IDAY', '%d', 'Day of the year used to correct TOA Solar/Lunar irradiance.\n');
      else
        C.printCardItem(fid, OF, 'IDAY', '%d', 'Not used in this case (Day of the year used to correct TOA Solar/Lunar irradiance).\n');        
      end
      if C.RO == 0
        C.printCardItem(fid, OF, 'RO', '%10.3f', 'Radius of the earth in km at the path latitude. Will default to a value depending on MODEL.\n');
      else
        C.printCardItem(fid, OF, 'RO', '%10.3f', 'Radius of the earth in km at the path latitude.\n');        
      end
    switch C.ISOURC
      case 0
        C.printCardItem(fid, OF, 'ISOURC', '%d', 'The extraterrestrial source is the Sun.\n');
        C.printCardItem(fid, OF, 'ANGLEM', '%10.3f', 'Not used in this case (Phase angle of the Moon).\n');
      case 1
        C.printCardItem(fid, OF, 'ISOURC', '%d', 'The extraterrestrial source is the Moon.\n');  
        C.printCardItem(fid, OF, 'ANGLEM', '%10.3f', 'Phase angle of the Moon in degrees (0 to 180).\n');        
    end
    end % DescribeCardAlt3
    function C = ReadCard3A1(C, fid)
      % IPARM, IPH, IDAY, ISOURC (If IEMSCT=2)
      % FORMAT (4I5)
      Card = C.ReadSimpleCard(fid, [5 5 5 5], {'d','d','d','d'}, '3A1');
      [C.IPARM, C.IPH, C.IDAY, C.ISOURC] = Card{:};
    end % ReadCard3A1
    function C = WriteCard3A1(C, fid)
      fprintf(fid, '%5d%5d%5d%5d\n', C.IPARM, C.IPH, C.IDAY, C.ISOURC); 
    end % WriteCard3A1
    function C = DescribeCard3A1(C, fid, OF)
      % Describe the solar/lunar scattering geometry card 3A1
      C.printPreCard(fid, OF, '3A1');
      C.printCardItem(fid, OF, 'IPARM', '%d', 'Solar/Lunar scattering geometry is described by ')
      switch C.IPARM
        case 0
          fprintf(fid, 'observer lat/long and Sun/Moon lat/long.\n');          
        case 1
          fprintf(fid, 'observer lat/long together with IDAY (day number) and TIME (UTC).\n');
        case 2
          fprintf(fid, 'LOS azimuth, solar/lunar azimuth and solar/lunar zenith angle at H1.\n');
        case 10
          fprintf(fid, 'lat/long at H2, solar/lunar lat/long and true LOS azimuth from H2 to H1.\n');          
        case 11
          fprintf(fid, 'lat/long at H2, TIME (UTC) and true LOS azimuth from H2 to H1.\n');          
        case 12
          fprintf(fid, 'relative solar/lunar azimuth at H2, TIME (UTC) and solar zenith angle at H2.\n');                    
      end
      C.printCardItem(fid, OF, 'IPH', '%d', 'The aerosol phase function is ')
      switch C.IPH
        case 0
          fprintf(fid, 'a spectrally independent Henyey-Greenstein function (see Card 3A2).\n');
        case 1
          fprintf(fid, 'user-defined (see Card 3B).\n');          
        case 2
          fprintf(fid, 'taken from the internal Mie-generated database for the canned atmospheric models.\n');                    
      end
      C.printCardItem(fid, OF, 'IDAY', '%d', 'Day of the year used to correct TOA Solar/Lunar irradiance and compute solar/lunar sky position.\n');
    switch C.ISOURC
      case 0
        C.printCardItem(fid, OF, 'ISOURC', '%d', 'The extraterrestrial source is the Sun.\n');
      case 1
        C.printCardItem(fid, OF, 'ISOURC', '%d', 'The extraterrestrial source is the Moon.\n');  
    end
    end % DescribeCard3A1
    function C = ReadCard3A2(C, fid)
      % PARM1, PARM2, PARM3, PARM4, TIME, PSIPO, ANGLEM, G
      % FORMAT (8F10.3) (If IEMSCT=2)
      Card = C.ReadSimpleCard(fid, [10 10 10 10 10 10 10 10], {'f','f','f','f','f','f','f','f'}, '3A2');
      [C.PARM1, C.PARM2, C.PARM3, C.PARM4, C.TIME, C.PSIPO, C.ANGLEM, C.G] = Card{:};
    end % ReadCard3A2
    function C = WriteCard3A2(C, fid)
      fprintf(fid, '%10.3f%10.3f%10.3f%10.3f%10.3f%10.3f%10.3f%10.3f\n', ...
        C.PARM1, C.PARM2, C.PARM3, C.PARM4, C.TIME, C.PSIPO, C.ANGLEM, C.G);
    end % WriteCard3A2
    function C = DescribeCard3A2(C, fid, OF)
      % Describe solar/lunar scattering geometry parameters
      C.printPreCard(fid, OF, '3A2');
      switch C.IPARM
        case 0
         C.printCardItem(fid, OF, 'PARM1', '%g', 'Sensor/Observer latitude in degrees (-90 to 90).\n');
         C.printCardItem(fid, OF, 'PARM2', '%g', 'Sensor/Observer longitude in degrees (0 to 360 West of Greenwich).\n');
         C.printCardItem(fid, OF, 'PARM3', '%g', 'Sun/Moon latitude in degrees (-90 to 90).\n');
         C.printCardItem(fid, OF, 'PARM4', '%g', 'Sun/Moon longitude in degrees (0 to 360 West of Greenwich).\n'); 
         C.printCardItem(fid, OF, 'TIME', '%g', 'Not used in this case. (Time, UTC, in hours).\n');                  
         C.printCardItem(fid, OF, 'PSIPO', '%g', 'True path azimuth from H1 to H2 in degrees (positive East of North).\n');
        case 1
         C.printCardItem(fid, OF, 'PARM1', '%g', 'Sensor/Observer latitude in degrees (-90 to 90).\n');
         C.printCardItem(fid, OF, 'PARM2', '%g', 'Sensor/Observer longitude in degrees (0 to 360 West of Greenwich).\n');
         C.printCardItem(fid, OF, 'PARM3', '%g', 'Not used in this case. IDAY and TIME used to compute Sun/Moon position in sky.\n');
         C.printCardItem(fid, OF, 'PARM4', '%g', 'Not used in this case. IDAY and TIME used to compute Sun/Moon position in sky.\n');
         C.printCardItem(fid, OF, 'TIME', '%g', 'Time (UTC) in decimal hours.\n')                  
         C.printCardItem(fid, OF, 'PSIPO', '%g', 'True path azimuth from H1 to H2 in degrees (positive East of North).\n');         
        case 2
         C.printCardItem(fid, OF, 'PARM1', '%g', 'Azimuth angle between observer LOS and Sun/Moon (positive East, -180 to 180).\n');
         C.printCardItem(fid, OF, 'PARM2', '%g', 'Solar/Lunar zenith angle at H1.\n');
         C.printCardItem(fid, OF, 'PARM3', '%g', 'Not used in this case. Geometry fully specified by PARM1 and PARM2.\n');
         C.printCardItem(fid, OF, 'PARM4', '%g', 'Not used in this case. Geometry fully specified by PARM1 and PARM2.\n');
         C.printCardItem(fid, OF, 'TIME', '%g', 'Not used in this case. (Time, UTC, in hours).\n'); 
         C.printCardItem(fid, OF, 'PSIPO', '%g', 'Not used in this case. (True path azimuth).\n');                  
        case 10
         C.printCardItem(fid, OF, 'PARM1', '%g', 'Latitude at H2 in degrees (-90 to 90).\n');
         C.printCardItem(fid, OF, 'PARM2', '%g', 'Longitude at H2 in degrees (0 to 360 West of Greenwich).\n');
         C.printCardItem(fid, OF, 'PARM3', '%g', 'Sun/Moon latitude in degrees (-90 to 90).\n');
         C.printCardItem(fid, OF, 'PARM4', '%g', 'Sun/Moon longitude in degrees (0 to 360 West of Greenwich).\n');
         C.printCardItem(fid, OF, 'TIME', '%g', 'Not used in this case. (Time, UTC, in hours).\n');         
         C.printCardItem(fid, OF, 'PSIPO', '%g', 'True path azimuth from H2 to H1 in degrees (positive East of North).\n');         
        case 11
         C.printCardItem(fid, OF, 'PARM1', '%g', 'Latitude at H2 in degrees (-90 to 90).\n');
         C.printCardItem(fid, OF, 'PARM2', '%g', 'Longitude at H2 in degrees (0 to 360 West of Greenwich).\n');
         C.printCardItem(fid, OF, 'PARM3', '%g', 'Not used in this case.\n');
         C.printCardItem(fid, OF, 'PARM4', '%g', 'Not used in this case.\n'); 
         C.printCardItem(fid, OF, 'TIME', '%g', 'Time (UTC) in decimal hours.\n');
         C.printCardItem(fid, OF, 'PSIPO', '%g', 'True path azimuth from H2 to H1 in degrees (positive East of North).\n');
        case 12
         C.printCardItem(fid, OF, 'PARM1', '%g', 'Relative solar/lunar azimuth angle in degrees (positive East of North).\n');
         C.printCardItem(fid, OF, 'PARM2', '%g', 'Solar zenith angle at H2 in degrees.\n');
         C.printCardItem(fid, OF, 'PARM3', '%g', 'Not used in this case. Geometry fully specified by PARM1 and PARM2.\n');
         C.printCardItem(fid, OF, 'PARM4', '%g', 'Not used in this case. Geometry fully specified by PARM1 and PARM2.\n');
         C.printCardItem(fid, OF, 'TIME', '%g', 'Not used in this case. (Time, UTC, in hours).\n');         
         C.printCardItem(fid, OF, 'PSIPO', '%g', 'Not used in this case. (True path azimuth).\n');                  
      end
      switch C.ISOURC
        case 0
          C.printCardItem(fid, OF, 'ANGLEM', '%g', 'Not used in this case (Phase angle of the Moon).\n');
        case 1
          C.printCardItem(fid, OF, 'ANGLEM', '%g', 'Phase angle of the Moon in degrees (0 to 180).\n');
      end
      if C.IPH == 0
        C.printCardItem(fid, OF, 'G', '%g', 'Asymmetry factor for use with Henyey-Greenstein phase function.\n');
      else
        C.printCardItem(fid, OF, 'G', '%g', 'Not used in this case. (Asymmetry factor for use with Henyey-Greenstein phase function).\n');        
      end
    end % DescribeCard3A2
    function C = ReadCard3B1(C, fid)
      % NANGLS, NWLF (If IPH=1)
      % FORMAT (2I5)
      Card = C.ReadSimpleCard(fid, [5 5], {'d','d'}, '3B1');
      [C.NANGLS, C.NWLF] = Card{:};
    end % ReadCard3B1
    function C = WriteCard3B1(C, fid)
      fprintf(fid, '%5d%5d\n', C.NANGLS, C.NWLF);
    end % WriteCard3B1
    function C = ReadCard3B2(C, fid)
      % (ANGF(I), F(1, I, 1), F(2, I, 1), F(3, I, 1), F(4, I, 1), I=l, NANGLS)
      % FORMAT (5E10.3) (If IPH=1 and NWLF=0)
      % Still does not make sense to me ...
      for I = 1:C.NANGLS
        Card = C.ReadSimpleCard(fid, [10 10 10 10 10], ...
          {'e','e','e','e','e'}, '3B2');
        [tANGF, F11, F21, F31, F41] = Card{:};
        C.ANGF(I) = tANGF;
        C.F(1,I,1) = F11;
        C.F(2,I,1) = F21;
        C.F(3,I,1) = F31;
        C.F(4,I,1) = F41;
      end
    end % ReadCard3B2
    function C = WriteCard3B2(C, fid)
      for I = 1:C.NANGLS
        fprintf(fid, '%10.3E%10.3E%10.3E%10.3E%10.3E\n', ...
          C.ANGF(I),C.F(1,I,1),C.F(2,I,1),C.F(3,I,1),C.F(4,I,1));
      end
    end % WriteCard3B2
    function C = ReadCard3C1(C, fid)
      % (ANGF(I), I=1, NANGLS) (IF IPH=1 and NWLF > 0)
      % FORMAT (8(1X, F9.0))
      Card = C.ReadSimpleCard(fid, [1 9 1 9 1 9 1 9 1 9 1 9 1 9 1 9], ...
        {'*','f','*','f','*','f','*','f','*','f','*','f','*','f','*','f'}, '3C1');
      for I = 1:C.NANGLS
        C.ANGF(I) = Card{I};
      end
        
    end % ReadCard3C1
    function C = WriteCard3C1(C, fid)
      for I = 1:C.NANGLS
        fprintf(fid, ' %9.0f', C.ANGF(I));
      end
      fprintf(fid, '\n');
    end % WriteCard3C1
    function C = ReadCard3C2(C, fid)
      % (WLF(J), J=1, NWLF) (If IPH=1 and NWLF > 0)
      % FORMAT (8(1X, F9.0))
      Card = C.ReadSimpleCard(fid, [1 9 1 9 1 9 1 9 1 9 1 9 1 9 1 9], ...
        {'*','f','*','f','*','f','*','f','*','f','*','f','*','f','*','f'}, '3C2');
      for I = 1:C.NWLF
        C.WLF(I) = Card{I};
      end      
    end % ReadCard3C2
    function C = WriteCard3C2(C, fid)
      for I = 1:C.NWLF
        fprintf(fid, ' %9.0f', C.WLF(I));
      end
      fprintf(fid, '\n');
    end % WriteCard3C1    
    function C = ReadCard3C3(C, fid, iNANGLS)
      % (F(1, I, J), J=1, NWLF) (If IPH=1 and NWLF > 0)
      % FORMAT (8(1X, E9.3))
        Card = C.ReadSimpleCard(fid, [1 9 1 9 1 9 1 9 1 9 1 9 1 9 1 9], ...
          {'*','e','*','e','*','e','*','e','*','e','*','e','*','e','*','e'}, '3C3');
        for iNWLF = 1:C.NWLF % wavelength index
          C.F(1,iNANGLS,iNWLF) = Card{iNWLF};
        end
    end % ReadCard3C3
    function C = WriteCard3C3(C, fid, iNANGLS)
      for iNWLF = 1:C.NWLF
        if ispc
          lin = sprintf(' %10.3E', C.F(1,iNANGLS,iNWLF));
          lin = strrep(lin, 'E+0', 'E+');
          lin = strrep(lin, 'E-0', 'E-');
          fprintf(fid, '%s', lin);
        else
          fprintf(fid, ' %9.3E', C.F(1,iNANGLS,iNWLF));
        end
      end
      fprintf(fid, '\n');
    end % WriteCard3C3
    function C = ReadCard3C4(C, fid, iNANGLS)
      % (F(2, I, J), J=1, NWLF) (If IPH=1 and NWLF > 0)
      % FORMAT (8(1X, E9.3))
        Card = C.ReadSimpleCard(fid, [1 9 1 9 1 9 1 9 1 9 1 9 1 9 1 9], ...
          {'*','e','*','e','*','e','*','e','*','e','*','e','*','e','*','e'}, '3C4');
        for iNWLF = 1:C.NWLF
          C.F(2,iNANGLS,iNWLF) = Card{iNWLF};
        end
    end % ReadCard3C4
    function C = WriteCard3C4(C, fid, iNANGLS)
      for iNWLF = 1:C.NWLF
        if ispc
          lin = sprintf(' %10.3E', C.F(2,iNANGLS,iNWLF));
          lin = strrep(lin, 'E+0', 'E+');
          lin = strrep(lin, 'E-0', 'E-');
          fprintf(fid, '%s', lin);
        else
          fprintf(fid, ' %9.3E', C.F(2,iNANGLS,iNWLF));
        end
      end
      fprintf(fid, '\n');
    end % WriteCard3C4
    function C = ReadCard3C5(C, fid, iNANGLS)
      % (F(3, I, J), J=1, NWLF) (If IPH=1 and NWLF > 0)
      % FORMAT (8(1X, E9.3))
        Card = C.ReadSimpleCard(fid, [1 9 1 9 1 9 1 9 1 9 1 9 1 9 1 9], ...
          {'*','e','*','e','*','e','*','e','*','e','*','e','*','e','*','e'}, '3C5');
        for iNWLF = 1:C.NWLF
          C.F(3,iNANGLS,iNWLF) = Card{iNWLF};
        end
    end % ReadCard3C5
    function C = WriteCard3C5(C, fid, iNANGLS)
      for iNWLF = 1:C.NWLF
        if ispc
          lin = sprintf(' %10.3E', C.F(3,iNANGLS,iNWLF));
          lin = strrep(lin, 'E+0', 'E+');
          lin = strrep(lin, 'E-0', 'E-');
          fprintf(fid, '%s', lin);          
        else
          fprintf(fid, ' %9.3E', C.F(3,iNANGLS,iNWLF));         
        end
      end
      fprintf(fid, '\n');
    end % WriteCard3C5
    function C = ReadCard3C6(C, fid, iNANGLS)
      % (F41, I, J), J=1, NWLF) (If IPH=1 and NWLF > 0)
      % FORMAT (8(1X, E9.3))
        Card = C.ReadSimpleCard(fid, [1 9 1 9 1 9 1 9 1 9 1 9 1 9 1 9], ...
          {'*','e','*','e','*','e','*','e','*','e','*','e','*','e','*','e'}, '3C6');
        for iNWLF = 1:C.NWLF
          C.F(4,iNANGLS,iNWLF) = Card{iNWLF};
        end
    end % ReadCard3C6
    function C = WriteCard3C6(C, fid, iNANGLS)
      for iNWLF = 1:C.NWLF
        if ispc
          lin = sprintf(' %10.3E', C.F(4,iNANGLS,iNWLF));
          lin = strrep(lin, 'E+0', 'E+');
          lin = strrep(lin, 'E-0', 'E-');
          fprintf(fid, '%s', lin);          
        else
          fprintf(fid, ' %9.3E', C.F(4,iNANGLS,iNWLF));
        end
      end
      fprintf(fid, '\n');
    end % WriteCard3C6
    function C = ReadCard4(C, fid)
      % V1, V2, DV, FWHM, YFLAG, XFLAG, DLIMIT, FLAGS
      % FORMAT (4F10.0, 2A1, A8, A6) (MODTRAN3.7)
      % FORMAT (4F10.0, 2A1, A8, A7) (MODTRAN4.0)
      Card = C.ReadSimpleCard(fid, [10 10 10 10 1 1 8 7], {'f','f','f','f','c','c','8c','7c'}, '4');
      [C.V1, C.V2, C.DV, C.FWHM, C.YFLAG, C.XFLAG, C.DLIMIT, C.FLAGS] = Card{:};
    end % ReadCard4
    function C = WriteCard4(C, fid)
      % Note - all the example cases with PcModWin4 use F10.3 here
      % while the User's manual prescribes F10.0. Using F10.3
      fprintf(fid, '%10.3f%10.3f%10.3f%10.3f%c%c%8s%7s\n', ...
        C.V1, C.V2, C.DV, C.FWHM, C.YFLAG, C.XFLAG, C.DLIMIT, C.FLAGS);
    end % WriteCard4
    function C = DescribeCard4(C, fid, OF)
      % Card 4 is spectral range and control flags
      C.printPreCard(fid, OF, '4');
      C.printCardItem(fid, OF, 'V1', '%g');
      switch C.FLAGS(1)
        case {' ', 'W'}
          fprintf(fid, 'Starting wavenumber in cm^-1. (Wavelength is %g nm or %g µm)\n', 1e7/C.V1, 1e4/C.V1);
        case 'M'
          fprintf(fid, 'Starting wavelength in microns. (Wavenumber is %g cm^-1)\n', 1e4/C.V1);          
        case 'N'
          fprintf(fid, 'Starting wavelength in nanometres. (Wavenumber is %g cm^-1)\n', 1e7/C.V1);
      end
      C.printCardItem(fid, OF, 'V2', '%g');
      switch C.FLAGS(1)
        case {' ', 'W'}
          fprintf(fid, 'Final wavenumber in cm^-1. (Wavelength is %g nm or %g µm)\n', 1e7/C.V2, 1e4/C.V2);
        case 'M'
          fprintf(fid, 'Final wavelength in microns. (Wavenumber is %g cm^-1)\n', 1e4/C.V2);          
        case 'N'
          fprintf(fid, 'Final wavelength in nanometres. (Wavenumber is %g cm^-1)\n', 1e7/C.V2);
      end
      C.printCardItem(fid, OF, 'DV', '%g');
      switch C.FLAGS(1)
        case {' ', 'W'}
          fprintf(fid, 'Spectral wavenumber increment in cm^-1.\n');
        case 'M'
          fprintf(fid, 'Spectral wavelength increment in microns.\n');          
        case 'N'
          fprintf(fid, 'Spectral wavelength increment in nanometres.\n');
      end
      C.printCardItem(fid, OF, 'FWHM', '%g');
      switch C.FLAGS(2)
        case {' ', '1', 'T'}
          fprintf(fid, 'Triangular');
        case {'2', 'R'}
          fprintf(fid, 'Rectangular');
        case {'3', 'G'}
          fprintf(fid, 'Gaussian');          
        case {'4', 'S'}
          fprintf(fid, 'Sinc');
        case {'5', 'C'}
          fprintf(fid, 'Sinc-squared');
        case {'6', 'H'}
          fprintf(fid, 'Hamming');
        case {'7', 'U'}
          fprintf(fid, 'User-defined');
      end
      if C.FLAGS(3) == ' ' || C.FLAGS(3) == 'A' % FWHM is absolute
        switch C.FLAGS(1)
          case {' ', 'W'}
            fprintf(fid, ' convolution function width (wavenumber in cm^-1).\n');
          case 'M'
            fprintf(fid, ' convolution function width (wavelength in microns).\n');
          case 'N'
            fprintf(fid, ' convolution function width (wavelength in nanometres).\n');
        end
      else % FWHM is relative to current wavelength/wavenumber
        switch C.FLAGS(1)
          case {' ', 'W'}
            fprintf(fid, ' convolution function width (percentage of wavenumber).\n');
          case 'M'
            fprintf(fid, ' convolution function width (percentage of wavelength).\n');
          case 'N'
            fprintf(fid, ' convolution function width (percentage of wavelength).\n');
        end        
      end
      C.printCardItem(fid, OF, 'YFLAG', '''%c''');
      switch C.YFLAG
        case ' '
          fprintf(fid, 'There will be no plot data output to .plt and .psc files.\n');
        case 'T'
          fprintf(fid, 'Transmittance plot data will be output to .plt and .psc files.\n');
        case 'R'
          fprintf(fid, 'Radiance plot data will be output to .plt and .psc files.\n');
      end 
      C.printCardItem(fid, OF, 'XFLAG', '''%c''');
      switch C.XFLAG
        case ' '
          fprintf(fid, 'There will be no plot data output to .plt and .psc files.\n');
        case 'W'
          fprintf(fid, 'Spectral variable in plot files is wavenumber in cm^-1 and radiances are in W/sr/cm^2/cm^-1.\n');
        case 'M'
          fprintf(fid, 'Spectral variable in plot files is wavelength in microns and radiances are in W/sr/cm^2/µm.\n');
        case 'N'
          fprintf(fid, 'Spectral variable in plot files is wavelength in nanometres and radiances are in µW/sr/cm^2/nm.\n');
      end
      C.printCardItem(fid, OF, 'DLIMIT', '''%s''', 'Delimiter string for multiple plots in single plot file.\n');
      C.printCardItem(fid, OF, 'FLAGS', '''%s''', 'Control flags.\n');
    end % DescribeCard4
    function MC = ReadCard4Ato4L2(MC, fid)
      % Read cards 4A through to 4L2 as required.
      % Read BRDF data if SURREF is BRDF or LAMBER
      if strncmpi(strtrim(MC.SURREF),'B',1) || strncmpi(strtrim(MC.SURREF),'L',1)
        MC = MC.ReadCard4A(fid);
        if strncmpi(strtrim(MC.SURREF),'B',1)
          for iNSURF = 1:MC.NSURF
            
            MC = MC.ReadCard4B1(fid, iNSURF);
            MC = MC.ReadCard4B2(fid, iNSURF);
            for iNWVSRF = 1:MC.NWVSRF % Read card 4B3
              MC = MC.ReadCard4B3(fid, iNSURF, iNWVSRF);
            end
          end
        elseif strncmpi(strtrim(MC.SURREF),'L',1)
          MC = MC.ReadCard4L1(fid);
          for iNSURF = 1:MC.NSURF
            
            MC = MC.ReadCard4L2(fid, iNSURF);
          end
        end
      end
      
    end % ReadCard4Ato4L2
    function MC = WriteCard4Ato4L2(MC, fid)
      % Write cards 4A through to 4L2 as required.
      % Write BRDF data if SURREF is BRDF or LAMBER
      if strncmpi(strtrim(MC.SURREF),'B',1) || strncmpi(strtrim(MC.SURREF),'L',1)
        MC = MC.WriteCard4A(fid);
        if strncmpi(strtrim(MC.SURREF),'B',1)
          for iNSURF = 1:MC.NSURF
            
            MC = MC.WriteCard4B1(fid, iNSURF);
            MC = MC.WriteCard4B2(fid, iNSURF);
            for iNWVSRF = 1:MC.NWVSRF % Write card 4B3
              MC = MC.WriteCard4B3(fid, iNSURF, iNWVSRF);
            end
          end
        elseif strncmpi(strtrim(MC.SURREF),'L',1)
          MC = MC.WriteCard4L1(fid);
          for iNSURF = 1:MC.NSURF
            MC = MC.WriteCard4L2(fid, iNSURF);
          end
        end
     
      end
      
    end % WriteCard4Ato4L2
    function C = ReadCard4A(C, fid)
      % NSURF, AATEMP
      % FORMAT (I1, F9.0) (If SURREF = 'BRDF' or 'LAMBER')
      Card = C.ReadSimpleCard(fid, [1 9], {'d','f'}, '4A');
      [C.NSURF, C.AATEMP] = Card{:};
    end % ReadCard4A
    function C = WriteCard4A(C, fid)
      fprintf(fid, '%1d%9.0f\n', C.NSURF, C.AATEMP);
    end % WriteCard4A
    function C = ReadCard4B1(C, fid, iNSURF)
      % CBRDF
      % FORMAT (A80) (If SURREF = 'BRDF')
      Card = C.ReadSimpleCard(fid, 80, {'80c'}, '4B1');
      C.CBRDF(iNSURF,:) = Card{1};
      C.CBRDF = char(C.CBRDF);
    end % ReadCard4B1
    function C = WriteCard4B1(C, fid, iNSURF)
      fprintf(fid, '%s\n', C.CBRDF(iNSURF,:));
    end % WriteCard4B1
    function C = ReadCard4B2(C, fid, iNSURF)
      % NWVSRF, SURFZN, SURFAZ
      % FORMAT (*) (If SURREF = 'BRDF')
      % Damn, this card is free format - new function required
      Card = C.ReadFreeCard(fid, '%f %f %f', '4B2');
      [tNWVSRF, tSURFZN, tSURFAZ] = Card{:};
      % Concatenate vertically for every occurrance
      C.NWVSRF(iNSURF,1) = tNWVSRF;
      C.SURFZN(iNSURF,1) = tSURFZN;
      C.SURFAZ(iNSURF,1) = tSURFAZ;
    end % ReadCard4B2
    function C = WriteCard4B2(C, fid, iNSURF)
      fprintf(fid, '%d %f %f\n', C.NWVSRF(iNSURF,1), C.SURFZN(iNSURF,1), C.SURFAZ(iNSURF,1));
    end % WriteCard4B2
    function C = ReadCard4B3(C, fid, iNSURF, iNWVSRF)
      % WVSURF, (PARAMS(I), I = 1, NPARAM)
      % FORMAT (*) (If SURREF = 'BRDF')
      % Current BRDFs are parametrized by up to 4 values (NPARAM = 3 or 4)
      Card = C.ReadFreeCard(fid, '%f %f %f %f %f', '4B3'); % Could be up to 4 after WVSURF
      [tWVSURF, tPARAMS1, tPARAMS2, tPARAMS3, tPARAMS4] = Card{:};
      C.WVSURF(iNSURF,1) = tWVSURF;
      C.PARAMS1(iNSURF, iNWVSRF) = tPARAMS1;
      C.PARAMS2(iNSURF, iNWVSRF) = tPARAMS2;
      C.PARAMS3(iNSURF, iNWVSRF) = tPARAMS3;
      C.PARAMS4(iNSURF, iNWVSRF) = tPARAMS4;    
    end % ReadCard4B3
    function C = WriteCard4B3(C, fid, iNSURF, iNWVSRF)
      fprintf(fid, '%f %f %f %f %f\n', ...
        C.WVSURF(iNSURF,1), C.PARAMS1(iNSURF, iNWVSRF), C.PARAMS2(iNSURF, iNWVSRF), C.PARAMS3(iNSURF, iNWVSRF), C.PARAMS4(iNSURF, iNWVSRF));
    end % WriteCard4B3
    function C = ReadCard4L1(C, fid)
      % SALBFL
      % FORMAT (A80) (If SURREF = 'LAMBER')
      % Note : there is an error in the MODTRAN 4 manual :
      %  The manual states that Card 4L1 is read in NSURF times, but it
      %  is actually only read once. Only card 4L2 is read NSURF times
      %  in the case of a lambertian surface.
      %  The MODTRAN 5 manual is correct in this respect.
      Card = C.ReadSimpleCard(fid, 80, {'c'}, '4L1');
      %fprintf(1,'Read 4L1 %s\n', Card{1});
      C.SALBFL = Card{1};
      C.SALBFL = char(C.SALBFL);
    end % ReadCard4L1
    function C = WriteCard4L1(C, fid)
      fprintf(fid, '%s\n', C.SALBFL);
    end % WriteCard4L1
    function C = ReadCard4L2(C, fid, iNSURF)
      % CSALB
      % FORMAT (A80) (If SURREF = 'LAMBER')
      Card = C.ReadSimpleCard(fid, 80, {'c'}, '4L2');
      %fprintf(1,'Read 4L2 %s\n', Card{1});
      
      C.CSALB(iNSURF,:) = Card{1};
      C.CSALB = char(C.CSALB);
    end % ReadCard4L2
    function C = WriteCard4L2(C, fid, iNSURF)
      fprintf(fid, '%s\n', C.CSALB(iNSURF,:));
    end % WriteCard4L2
    function C = ReadCard5(C, fid)
      % IRPT
      % FORMAT (I5)
      Card = C.ReadSimpleCard(fid, 5, {'d'}, '5');
      C.IRPT = Card{1};
    end % ReadCard5
    function C = WriteCard5(C, fid)
      fprintf(fid, '%5d\n', C.IRPT);
    end % WriteCard5
    function C = DescribeCard5(C, fid, OF)
      % Card 5 controls repeat runs
      C.printPreCard(fid, OF, '5');
      C.printCardItem(fid, OF, 'IRPT', '%d');
      switch C.IRPT
        case 0
          fprintf(fid, 'MODTRAN Terminates.\n');
        case {-1, 1}
          fprintf(fid, 'MODTRAN reads a full set of new card data followed by an additional Card 5.\n');
        case {-3, 3}
          fprintf(fid, 'MODTRAN reads a new LOS geometry card (Card 3) and surface (Card 4 series) followed by an additional Card 5.\n');
        case {-4, 4}
          fprintf(fid, 'MODTRAN reads new spectral and surface cards (Card 4 series) followed by an additional Card 5.\n');
      end
    end 
    function Pass = ScalarIntNumeric(MC, Value, ValidRange, Caller)
      Pass = isscalar(MC) && isscalar(Value) && isnumeric(Value) && any(Value == ValidRange);
      if ~Pass
        fprintf(2, 'Inputs to set.%s must be scalar and new value must be one of ', Caller);
        fprintf(2, '%d ', ValidRange);
        fprintf(2, '\n');
        error(['Mod5:set' Caller ':BadInput'],'Bad input (%d) to set.%s encountered.', Value, Caller);
      end
    end % ScalarIntNumeric
    function Pass = ScalarChar(MC, Value, ValidChar, Caller)
      Pass = isscalar(MC) && isscalar(Value) && ischar(Value) && any(Value == ValidChar);
      if ~Pass
        fprintf(2, 'Inputs to set.%s must be scalar and new value must be one of ', Caller);
        for iChar = 1:length(ValidChar)
          fprintf(2, '''%c ''', ValidChar(iChar));
        end
        fprintf(2, '\n');
        error(['Mod5:set' Caller ':BadInput'],'Bad input to set.%s encountered.', Caller);
      end      
    end
  end % private methods
end % Class Mod5

