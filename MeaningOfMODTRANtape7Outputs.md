The precise meaning of the column headers in the MODTRAN tape7 output is not provided in any detail in the MODTRAN manual. Some help can be obtained by searching for the relevant column headers on the web. Perhaps the most helpful is the following from Ontar at the link :
http://www.ontar.com/Software/ContentPage.aspx?item=support_faq_pcmodwin_000005
The column headers are as follows:

FREQ - Frequency in cm-1.

TRANS - Total transmission through defined path. For example one would assume that for a downward looking path from H1 to H2, the transmittance is from H1 to H2. For calculation of reflected solar component, one could always use the layer by layer transmittance to calculate the total attenuation through both the downwelling and upwelling paths.

PTH THRML - Radiance component due to the atmosphere received at the observer. This term includes the THRML SCT component which will be 0.0 if multiple scattering is not running.

SURF EMIS - Component of radiance due to surface emission received at the observer.

SOL SCAT - Component of scattered solar radiance received at the observer. This term includes the SING SCAT component.

GRND RFLT - GRND RFLT is the total (direct + diffuse) solar flux impingent on the ground and reflected directly to the sensor from the ground. Thus, GRND RFLT = DRCT RFLT + Diffuse Reflected. If the downward solar flux is dominated by the direct term, GRND and DRCT will be equal (Lex Burke, email 15-Dec-2003). In practice the Diffuse Reflected term will only be significant (non-zero) if multiple scattering is selected.

TOTAL RAD = PTH THRML + SURF EMIS + SOL SCAT + GRND RFLT

REF SOL - REF SOL is the top-of-atmosphere solar irradiance times the L-shaped path from the sun-to-H2-to-H1. If H2 is the ground, the DRCT RFCT is simply the REF SOL times the surface BRDF over pi steradians (Lex Burke, email 15-Dec-2003).

SOL@OBS - Total Solar irradiance at the observer. I believe this is similar to the REF SOL, but also includes a contribution from the SOL SCAT term.

For the Direct Solar Irradiance option:

SOL TR - Is the transmitted solar irradiance to the observer at height H1

SOL - Is the top of the atmosphere irradiance