GalacticGlobularClusters
================================

<h3>A Shiny application to interactively explore the dataset(s) of Galactic Globular Clusters</h3>

<br />

<h4>Table of Contents</h4>
[Summary](#Summary)<br />
[References](#Refs)<br />
[Other Information](#Other)<br />
<br /><br />


<a name="Summary"/>
<h4>Summary</h4>

The intended purpose of this application is create an interactive plotting tool to exmaine the characteristics of the globular clusters in the Milky Way. Because there are many relationships between different variables relating to these clusters, it can be time-consuming to make or customize these plots one by one simply to examine/re-examine a relation. This space has been created and made available to alleviate this issue. The goal is to facilitate easier exploration of the rich dataset of these globular clusters.

The Shiny application can be found [here](https://rwk506.shinyapps.io/ShinyClusters/). The application includes a panel to the left where the user can choose an x and y variable, as well as a third variable by which to color the points being plotted. The main page shows the resulting plot in the primary tab "Main Plot". A linear fit can be toggled on and off in the plot at the user's discretion. Hovering the mouse over each data point will give some basic information about each cluster, including the NGC designation, the [Fe/H] metallicity, and the RA/Dec locations.

The "Data Summary" tab gives a brief overview of each X, Y, color variable selected. The "Variables" tab includes a brief description of each choice available to the user. The "References" tab provides references from which the data are derived and links to the papers/sources for each, as well as a short description.

If you have additional interest in seeing variables not included, have problems with the application, or intend to use this work for academic/public purposes, please get in touch.

<br /> <br /><br />




<a name="Refs"/>
<h4>References</h4>

The references used to put together the dataset used for this project are as follows:

<b>Harris 2010 Galactic Globular Cluster Catalog</b>

[A New Catalog of Globular Clusters in the Milky Way: Harris, W. E. 1996, AJ, 112, 1487—. 2010, ArXiv e-prints, arXiv:1012.3224](http://adsabs.harvard.edu/abs/2010arXiv1012.3224H)

The Harris 2010 catalog is by far the primary source for most of the information included.
<br />

<b>Catelan 2009</b>

[Horizontal branch stars: the interplay between observations and theory, and insights into the formation of the Galaxy: Catelan, M. 2009, Ap & SS, 320, 261](http://adsabs.harvard.edu/abs/2009Ap%26SS.320..261C)

This reference provides the main source of information related to the horizontal branch mean period and Oosterhoff groups.
<br />

<b>Dotter et al. 2010</b>

[The ACS Survey of Galactic Globular Clusters. IX. Horizontal Branch Morphology and the Second Parameter Phenomenon: Dotter, A., Sarajedini, A., Anderson, J., et al. 2010, ApJ, 708, 698](http://adsabs.harvard.edu/abs/2010ApJ...708..698D)

The Dotter et al. 2010 paper provides some age and HB information for comparison purposes.
<br />

<b>Schiavon et al. 2005</b>

[A Library of Integrated Spectra of Galactic Globular Clusters : Schiavon, R. P., Rose, J. A., Courteau, S., MacArthur, L. A. 2005, ApJS, 160, 163](http://adsabs.harvard.edu/abs/2005ApJS..160..163S)

The library of integrated cluster spectra provides the highly accurate spectral [Fe/H] measurements included for many of the clusters.
<br />

<b>Roediger et al. 2014</b>

[Constraining Stellar Population Models. I. Age, Metallicity and Abundance Pattern Compilation for Galactic Globular Clusters: Roediger, J. C., Courteau, S., Graves, G., & Schiavon, R. P. 2014, ApJS, 210, 10](http://adsabs.harvard.edu/abs/2014ApJS..210...10R)

This source also provide ages and [Fe/H] measurements, but also measurements of individual elemental abundances for some other clusters, from a compilation of previous studies.
<br />

<b>HST UV Legacy survey</b>

[The Hubble Space Telescope UV Legacy Survey of Galactic Globular Clusters. I. Overview of the Project and Detection of Multiple Stellar Populations: Piotto, G., Milone, A. P., Bedin, L. R., et al. 2015, AJ, 149, 91](http://adsabs.harvard.edu/abs/2015AJ....149...91P)

The new UV Legacy Survey of the Galactic Globular Clusters (led by PI: Piotto) provides some initial, rough measurements of multiple population qualities for the clusters.



<br /> <br /><br />

<a name="Other"/>
<h4>Other Information</h4>

Author: RWK <br />
License: None. <br />
Contact: May be made through GitHub. Please contact if you intend to use for public/academic purposes. Also contact if any application issues arise. <br />

