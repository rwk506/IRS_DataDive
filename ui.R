library(shiny)
library(shiny)
library(ggplot2)
library(ggvis)

# Define UI
shinyUI(fluidPage(
  
  # Application title
  titlePanel("The Milky Way Globular Cluster System"),
  
  # Sidebar with controls to select the variable to plot against
  # mpg and to specify whether outliers should be included
  sidebarLayout(
    sidebarPanel(width=3,
      titlePanel("Plotting"),
      
      #### select menus for x and y variables      
      selectInput("xvariable", "X axis:",
                  names(clusts),
                  selected="Metallicity"),
      selectInput("yvariable", "Y axis:",
                  names(clusts),
                  selected = "Age_from_compilation"),
      
      #### select menu for color-grouping option
      selectInput("Group","Color points by:",
                  names(clusts),
                  selected = "Absolute_Vmagnitude")  #,
            
      #### Allow user-defined x and y boundaries?
      #numericInput("xlow", label = h3("Numeric input"), value=1),
      
      #### select whether or not to show a linear fit
      #selectInput("radio2", "Linear Fit",
      #           list("Off" = 0,
      #                 "On" = 100))
    ),
    

### main panel of the app
    ### this is where the first tab will show the plot with the user's inputs
    mainPanel(
      tabsetPanel(
        tabPanel(
          h4("Main Plot"),
          br(), h4(tags$b("Exploring the rich dataset of the old globular clusters in our galaxy")),
          p("This Shiny application is written in order to explore the data of Galactic Globular Clusters from Harris
            (2010) combined with several other studies (as outlined in the 'References' tab). The user can choose an
            X-variable to plot, a Y-variable to plot, and a variable on which to group (color) the data. A linear fit can
            also be chosen to be computed and the results will be displayed at the bottom of the page.", br(), br(),"A summary
            of the X, Y, and color variables is given in the 'Data Summary' tab, and descriptions of the variables are available
            in the 'Variables' tab. Information and links to the references from which the data is derived is given in the
            'References' tab."),
          br(),
          h4(textOutput("caption")),
          ggvisOutput("ggvis"),
          uiOutput("ggvis_ui"),
          p(textOutput("showfit")),
          p(textOutput("showfit2")),
          #p(textOutput("xlow")),  #### print check
          #p(textOutput("opacity")),  ### just another print check, remove later
          br(),
          br(),
          br(),
          p(tags$b("Links:"), style = "font-size:16pt;"),
          a("GitHub Page", href="https://github.com/rwk506/", style = "font-size:13pt;"),
          br(),
          a("Personal/Academic Page", href="http://www.astro.ufl.edu/~rawagnerkaiser/Home.html", style = "font-size:13pt;"),  #style = "font-family: 'times'"
          br(),
          br()
          ),
        
        #### Additional tab panel for more information/tables/summaries and stuff
        tabPanel(
          h4("Data Summary"),
          br(),
          p("Please note that the linear fit is for the entire set of points, not differentiated by grouping/coloring of points. Links to
            GitHub are at the bottom of this page."),
          br(),
          p(tags$b("Plot Data Summary:"), style = "font-size:16pt;"),
          p(textOutput("xvar")),
          p(verbatimTextOutput("summaryX")), br(),
          p(textOutput("yvar")),
          p(verbatimTextOutput("summaryY")), br(),
          p(textOutput("grp")),
          p(verbatimTextOutput("summaryGroup")), br(),
          br(),
          p(tags$b("Links:"), style = "font-size:16pt;"),
          a("GitHub Page", href="https://github.com/rwk506/", style = "font-size:13pt;"),
          br(),
          a("Personal/Academic Page", href="http://www.astro.ufl.edu/~rawagnerkaiser/Home.html", style = "font-size:13pt;"),  #style = "font-family: 'times'"
          br(),
          br()
          ),
        
        #### Description tab for all the included variables (try to keep in order...)
        tabPanel(
          h4("Variables"),
          br(),
          p("The variables available for plotting are described below."),
          br(), br(),
          p(tags$b("Variable Descriptions:"), style = "font-size:16pt;"),
          p(tags$b("Name: "),"The NGC catalog name for the cluster"),
          p(tags$b("Log_Galactocentric_Distance: "), "The (base-10) logarithm of the distance of the cluster from the Galactic center, in kpc"),
          p(tags$b("Heliocentric_Distance: "), "The distance of the cluster from the sun's position, assuming R(sun) = 8.0 kpc"),
          p(tags$b("Metallicity: "), "The [Fe/H] metallicity, as given in the Harris 2010 cluster catalog"),
          p(tags$b("Reddening: "), "The measure of foreground E(B-V), the reddening of the cluster's color in the B-V plane due to dust in the line of sight"),
          p(tags$b("Apparent_Distance_Modulus: "), "The observed apparent distance modulus to the cluster in the V band"),
          p(tags$b("Number_of_Populations_by_eye: "), "The number of populations that the HST-based ultraviolet CMD suggests (half-integers represent uncertainty as to the number of populations)"),
          p(tags$b("UV_Color_Spread_of_RGB: "), "A relative measurement of the observed spread of the red giant branch in the HST-based ultraviolet CMD"),
          p(tags$b("Absolute_Vmagnitude: "), "The absolute integrated V-band magnitude of the cluster (often used as a proxy for mass)"),
          p(tags$b("Apparent_Vmag: "), "The apparent integrated V-band magnitude of the cluster"),
          p(tags$b("UB_color: "), "The integrated (U-B) color of the cluster"),
          p(tags$b("BV_color: "), "The integrated (B-V) color of the cluster"),
          p(tags$b("VR_color: "), "The integrated (V-R) color of the cluster"),
          p(tags$b("VI_color: "), "The integrated (V-I) color of the cluster"),
          p(tags$b("Ellipticity: "), "A measurement of the elongation of the cluster from perfectly a spherical distribution of stars"),
          p(tags$b("Radial_Velocity: "), "Radial velocity relative to the sun, in km/s"),
          p(tags$b("Radial_Velocity_Error: "), "Observational uncertainty in the Radial_Velocity measurement"),
          p(tags$b("LSR_Radial_Velocity: "), "Radial velocity relative to sun's local standard of rest (LSR), in km/s"),
          p(tags$b("Central_Sigma_V: "), "Central velocity dispersion of the cluster, in km/s"),
          p(tags$b("Central_Sigma_V_Error: "), "Observational uncertainty in the Central_Sigma_V measurement"),
          p(tags$b("Central_Concentration: "), "King-model central concentration, a measurement of density of the cluster"),
          p(tags$b("Core_Radius: "), "The core radius of the cluster, measured in arcminutes"),
          p(tags$b("Half_Light_Radius: "), "The radius including half the light of the cluster, measured in arcminutes"),
          p(tags$b("Central_Surface_Brightness: "), "Measurement of V-band magnitudes per square arcsecond of the cluster"),
          p(tags$b("Log_Luminosity_Density: "), "The base-10 logarithm of solar luminosities per cubic parsec of the cluster"),
          p(tags$b("Log_Core_Relaxtime: "), "The relaxation time of the cluster, measured in base-10 logarithm of years"),
          p(tags$b("Log_HMR_Relaxtime: "), "The half-median relaxation time of the cluster, measured in base-10 logarithm of years"),
          p(tags$b("Age_from_compilation: "), "The age of the cluster in Gyr, as noted by the reference in Age_Reference"),
          p(tags$b("Age_compilation_err: "), "The error in the Age_from_compilation of the cluster (if given), also in Gyr"),
          p(tags$b("Age_Reference: "), "The reference from which Age_from_compilation and its error are reported"),
          p(tags$b("RGB_median_color: "), "The estimated median color of the cluster's red giant branch"),
          p(tags$b("Mean_Period_of_RRab: "), "The mean period of the RR Lyrae stars (type ab only) in the cluster, in days"),
          p(tags$b("Number_of_RRab: "), "The number of RR Lyrae in the cluster used for the determination of Mean_Period_of_RRab"),
          p(tags$b("Oosterhoff_Type: "), "The determined Oosterhoff Type (I, II, or III) of the cluster based on the horizontal branch"),
          p(tags$b("Galaxy_Population: "), "The likely population of the Galaxy to which the cluster belongs; BD = Bulge/Disk, YH = Young Halo, OY = Old Halo, C = omega Centauri"),
          p(tags$b("Horizontal_Branch_Magnitude: "), "The magnitude of the horizontal branch stars/RR Lyrae (V-band)"),
          p(tags$b("Specific_RRLyrae_Frequency: "), "The specific frequency of the RR Lyrae stars relative to the cluster"),
          p(tags$b("Horizontal_Branch_Ratio: "), "A measurement of the horizontal branch morphoology, determined from blue RR Lyrae (B), middle HB RR Lyrae (V), and red RR Lyrae (R): (B-R)/(B+V+R)"),
          p(tags$b("Horizontal_Branch_Type: "), "The Dickens classification of the horizontal branch morphology, from 0 (blue) to 7 (red)"),
          p(tags$b("FeH_Dotter2010: "), "The [Fe/H] metallicity from Dotter et al. 2010"),
          p(tags$b("Alpha_Fe_Dotter: "), "The [alpha/Fe] enrichment of the cluster from Dotter et al. 2010"),
          p(tags$b("Age_Dotter2010: "), "The age (in Gyr) from Dotter et al. 2010"),
          p(tags$b("Age_err_Dotter2010: "), "The observational uncertainty in Age_Dotter2010, also in Gyr"),
          p(tags$b("Integrated_Spectral_FeH: "), "The integrated spectral [Fe/H] metallicity from Schiavon et al. 2005"),
          p(tags$b("Age_Roediger2014: "), "The age of the cluster (in Gyr) from Roediger et al. 2014"),
          p(tags$b("Age_err_Roediger2014: "), "The observational uncertainty in Age_Roediger2014, also in Gyr"),
          p(tags$b("Fe_H_Roediger2014: "), "The [Fe/H] metallicity from Roediger 2014"),
          p(tags$b("Fe_H_Roediger2014_err: "), "The observational uncertainty in Fe_H_Roediger2014"),
          p(tags$b("Mg_Fe: "), "A measurement of [Mg/Fe] for a subset of stars in the cluster from Roediger et al. 2014"),
          p(tags$b("Mg_Fe_err: "), "The observational uncertainty of Mg_Fe"),
          p(tags$b("C_Fe: "), "A measurement of [C/Fe] for a subset of stars in the cluster from Roediger et al. 2014"),
          p(tags$b("C_Fe_err: "), "The observational uncertainty of C_Fe"),
          p(tags$b("N_Fe: "), "A measurement of [N/Fe] for a subset of stars in the cluster from Roediger et al. 2014"),
          p(tags$b("N_Fe_err: "), "The observational uncertainty of N_Fe"),
          p(tags$b("Ca_Fe: "), "A measurement of [Ca/Fe] for a subset of stars in the cluster from Roediger et al. 2014"),
          p(tags$b("Ca_Fe_err: "), "The observational uncertainty of Ca_Fe"),
          p(tags$b("O_Fe: "), "A measurement of [O/Fe] for a subset of stars in the cluster from Roediger et al. 2014"),
          p(tags$b("O_Fe_err: "), "The observational uncertainty of O_Fe"),
          p(tags$b("Na_Fe: "), "A measurement of [Na/Fe] for a subset of stars in the cluster from Roediger et al. 2014"),
          p(tags$b("Na_Fe_err: "), "The observational uncertainty of Na_Fe"),
          p(tags$b("Si_Fe: "), "A measurement of [Si/Fe] for a subset of stars in the cluster from Roediger et al. 2014"),
          p(tags$b("Si_Fe_err: "), "The observational uncertainty of Si_Fe"),
          p(tags$b("Cr_Fe: "), "A measurement of [Cr/Fe] for a subset of stars in the cluster from Roediger et al. 2014"),
          p(tags$b("Cr_Fe_err: "), "The observational uncertainty of Cr_Fe"),
          p(tags$b("Ti_Fe: "), "A measurement of [Ti/Fe] for a subset of stars in the cluster from Roediger et al. 2014"),
          p(tags$b("Ti_Fe_err: "), "The observational uncertainty of Ti_Fe"),
          p(tags$b("Longitude: "), "The Galactic longitude of the cluster, in degrees"),
          p(tags$b("Latitude: "), "The Galactic latitude of the cluster, in degrees"),
          p(tags$b("X: "), "The X position of the cluster from the Galactic center, in kpc"),
          p(tags$b("Y: "), "The Y position of the cluster from the Galactic center, in kpc"),
          p(tags$b("Z: "), "The Z position of the cluster from the Galactic center, in kpc"),
          p(tags$b("R.A.: "), "The right ascension of the cluster in decimal degrees"),
          p(tags$b("Dec: "), "The declination of the cluster in decimal degrees"),
          p(tags$b("RA_hour: "), "The RA hour of the cluster"),
          p(tags$b("RA_mins: "), "The RA minute of the cluster"),
          p(tags$b("RA_secs: "), "The RA second of the cluster"),
          p(tags$b("Dec_deg: "), "The declination degree of the cluster"),
          p(tags$b("Dec_mins: "), "The declination minute of the cluster"),
          p(tags$b("Dec_secs: "), "The declination second of the cluster"),
          br(),br(), br(),
          p(tags$b("Links:"), style = "font-size:16pt;"),
          a("GitHub Page", href="https://github.com/rwk506/", style = "font-size:13pt;"),
          br(),
          a("Personal/Academic Page", href="http://www.astro.ufl.edu/~rawagnerkaiser/Home.html", style = "font-size:13pt;"),  #style = "font-family: 'times'"
          br(),
          br()
        ),
        
        tabPanel(
          ######## Reference Section
          h4("References"),
          br(),
          p("The references from which the available data are compiled are listed, linked, and briefly described below."),
          br(), br(),
          p(tags$b("References:"), style = "font-size:16pt;"),
          br(),
          #### Harris
          p(tags$b("Harris 2010 Galactic Globular Cluster Catalog")),
          p(a("A New Catalog of Globular Clusters in the Milky Way", href="http://adsabs.harvard.edu/abs/2010arXiv1012.3224H"),
            (": Harris, W. E. 1996, AJ, 112, 1487—. 2010, ArXiv e-prints, arXiv:1012.3224")),
          p("The Harris 2010 catalog is by far the primary source for most of the information included."), br(),
          
          #### Catelan
          p(tags$b("Catelan 2009")), 
          p(a("Horizontal branch stars: the interplay between observations and theory, and insights into the formation of the Galaxy", href="http://adsabs.harvard.edu/abs/2009Ap%26SS.320..261C"),
            (": Catelan, M. 2009, Ap & SS, 320, 261")),
          p("This reference provides the main source of information related to the horizontal branch mean period and Oosterhoff groups."), br(),
          
          #### Dotter
          p(tags$b("Dotter et al. 2010")), 
          p(a("The ACS Survey of Galactic Globular Clusters. IX. Horizontal Branch Morphology and the Second Parameter Phenomenon", href="http://adsabs.harvard.edu/abs/2010ApJ...708..698D"),
            (": Dotter, A., Sarajedini, A., Anderson, J., et al. 2010, ApJ, 708, 698")),
          p("The Dotter et al. 2010 paper provides some age and HB information for comparison purposes."), br(),
          
          #### Schiavon
          p(tags$b("Schiavon et al. 2005")), 
          p(a("A Library of Integrated Spectra of Galactic Globular Clusters", href="http://adsabs.harvard.edu/abs/2005ApJS..160..163S"),
            (": Schiavon, R. P., Rose, J. A., Courteau, S., MacArthur, L. A. 2005, ApJS, 160, 163")),
          p("The library of integrated cluster spectra provides the highly accurate spectral [Fe/H] measurements included for many of the clusters."), br(),
          
          #### Roediger
          p(tags$b("Roediger et al. 2014")), 
          p(a("Constraining Stellar Population Models. I. Age, Metallicity and Abundance Pattern Compilation for Galactic Globular Clusters", href="http://adsabs.harvard.edu/abs/2014ApJS..210...10R"),
            (": Roediger, J. C., Courteau, S., Graves, G., & Schiavon, R. P. 2014, ApJS, 210, 10")),
          p("This source also provide ages and [Fe/H] measurements, but also measurements of individual elemental abundances for some other clusters, from a compilation of previous studies."), br(),
          
          #### UV Piotto
          p(tags$b("HST UV Legacy survey")), 
          p(a("The Hubble Space Telescope UV Legacy Survey of Galactic Globular Clusters. I. Overview of the Project and Detection of Multiple Stellar Populations", href="http://adsabs.harvard.edu/abs/2015AJ....149...91P"),
            (": Piotto, G., Milone, A. P., Bedin, L. R., et al. 2015, AJ, 149, 91")),
          p("The new UV Legacy Survey of the Galactic Globular Clusters (led by PI: Piotto) provides some initial, rough measurements of multiple population qualities for the clusters."),
          br(),br(), br(),
          p(tags$b("Links:"), style = "font-size:16pt;"),
          a("GitHub Page", href="https://github.com/rwk506/", style = "font-size:13pt;"),
          br(),
          a("Personal/Academic Page", href="http://www.astro.ufl.edu/~rawagnerkaiser/Home.html", style = "font-size:13pt;"),  #style = "font-family: 'times'"
          br(),
          br()
        )
        
      )
    ))
  ))