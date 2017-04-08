library(shiny)
library(ggplot2)
library(ggvis)

# Define UI
shinyUI(fluidPage(theme = "bootstrap.css",
  
  # Application title
  titlePanel( h2("Building a Better Revenue Model for NPOs: Planning for the Future", style = "color:#B22222"), windowTitle = "Revenue Models for Non-Profits"),
  
  # Sidebar with controls to select the variable to plot against
  # mpg and to specify whether outliers should be included
  sidebarLayout(
    sidebarPanel(width=4,
      #titlePanel("Plot Options"),
      
      #### select menus for x and y variables      
      selectInput("xvariable", "NTEE Category:",
                  #c("A","B","C")),
                  as.character(sort(unique(DF$NTEE_topname))),
                  selected="ARTS, CULTURE and HUMANITIES (A)"),
      # selectInput("yvariable", "Y axis:",
      #             (as.character(na.omit(unique(DF$NTEE_topname)))),
      #             selected = "YOUTH DEVELOPMENT")
      
      #### Allow user-defined x and y boundaries?
      #numericInput("xlow", label = h3("Numeric input"), value=1),
      
      #### select whether or not to show a linear fit
      # selectInput("radio2", "Show Fit",
      #            list("Off" = 0,
      #                  "On" = 100))
      
      tags$hr(),
      p(tags$b("How does your organization compare?")),
      p("Load your own CSV file* here to see 
        how your finances compare to similar organizations!", style = "font-size:11pt;"),
      fileInput("file1","",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")      ),
      # p("...  - formatted as 'year, total_gifts, total_revenue' 
      #   for each year of your filed tax return. Choose the NTEE category for your organization and...
      #   The value of 'total_gifts' is 990 Core_Pt VIII-1h(A) on the 990 form and 
      #   'total_revenue' is from box 990 Core_Pt VIII-12(A).", style = "font-size:9pt;"),
      p("*For more details/an example of how to format and upload your organization's data for comparison, 
        see the 'Your Data' tab on the right.", style = "font-size:9pt;"),
      tags$hr()
      #checkboxInput("header", "Header", TRUE)
    ),
    

### main panel of the app
    ### this is where the first tab will show the plot with the user's inputs
    mainPanel(
      tabsetPanel(
        tabPanel(
          h4("Main"),
          br(), h4(tags$b("How does the revenue model of your non-profit compare to similar organizations?")), br(),
          p("We can explore this question through the examination of tax documents for hundreds
            of thousands of non-profits who filed with the IRS in the 2015 fiscal year. By analyzing how much 
            of a non-profit's revenue derives from donor contributions (as opposed to program revenue, membership
            fees, etc.), we can examine how the revenue model changes for similar non-profit organizations over time."),
          p("In the plot below, the amount of contributed gifts is compared to the total revenue of the non-profits to observe 
            trends as organizations age.
            This metric indicates how financially dependent (high ratio on y-axis) or how independent (low ratio on y-axis) 
            an organization is likely to be on individual contributions compared to how long it has been in operation."),
          br(),
          ggvisOutput("ggvis"),
          uiOutput("ggvis_ui"),
          br(),
          p("(The datafile is fairly large and may take a minute to load -- we appreciate your patience!)", style = "font-size:8pt;"),
          br(),
          br(),
          h4(tags$b("Did you upload your own data?")),
          p("If you've uploaded your organization's data, it should appear in the above plot in green. A visual inspection 
            will provide some idea if your organization is more or less dependent on individual donations than average for
            the NTEE category chosen."),
          p("A numerical similarity measure between -1 and 1 is provided below -", tags$b("what does your data say?"), br(),
          p(tags$b("Similarity measure: "), textOutput("corrl")),
          tags$i(" --  Is your value close to 1?"), " Then your organization has a similar revenue model to the organizations of the NTEE category chosen",br(),
          tags$i(" --  Is your value close to 0?"), " Your revenue model is not similar to the NTEE category displayed - your organization 
                  may be over-reliant or under-reliant on individual donations. You may want to consider options and plan what 
                  long-term sources of revenue are best for your NPO.", br(),
          tags$i(" --  Is your value close to -1?"), " Your revenue model defies all expectations! This", tags$i(" may "), "be a good thing, but consider re-evaluating
                  how your organization compares to similar organizations and what the long-term goals of your organization are."),
          br(),
          p("One can use this applet to inspect how non-profit organization revenue models differ over time/age for various types of NPOs 
            (e.g.: foreign aid, public servies) as designated by NTEE codes, which can be changed from the left panel
            dropdown menu. More details available in the 'IRS Data' tab."),
          br(),
          br(),
          br(),
          h4(tags$b("Other analysis projects:")),
          a("GitHub Page", href="https://github.com/rwk506/", style = "font-size:12pt;"),
          br(),
          a("Webpage", href="http://www.astro.ufl.edu/~rawagnerkaiser/Home.html", style = "font-size:12pt;"),  #style = "font-family: 'times'"
          br(),
          br()
          ),
        
        #### Additional tab panel for more information/tables/summaries and stuff
        tabPanel(
          h4("IRS Data"), br(),
          h4(tags$b("An Analysis of Non-Profit Organization Revenue Models Using IRS Form 990 Data")),
          br(),
          p("Below is a summary of the median ratio for each year for the selected NTEE code for organizations that
            reported a non-zero fundraising contributions. For each organization where data is available, we use the 
            formation year of the organization to determine how long the organization has been operating. Using the 
            total contributed gifts reported on the IRS 990 form, we compare to the total revenue brought in by the 
            organization. This metric allows us to examine the dependency of the organizations on contributed gifts 
            in relation to their total revenue."),
          p("For each age, from the newest to the oldest organizations, we plot the median ratio of contributions to 
            revenue for each age. Through this process, we can examine how the financial business models of similar 
            non-profits changes and evolves over the course of their existence."),
          br(),
          h4(tags$b("IRS Data Summary:")),
          p("Below is the data plotted 'Main' tab."),
          dataTableOutput('table'),
          br(),
          h4(tags$b("Other analysis projects:")),
          a("GitHub Page", href="https://github.com/rwk506", style = "font-size:12pt;"),
          br(),
          a("Webpage", href="http://www.astro.ufl.edu/~rawagnerkaiser/Home.html", style = "font-size:12pt;"),  #style = "font-family: 'times'"
          br(),
          br()
          ),
        
        #### Additional tab panel for more information/tables/summaries and stuff
        tabPanel(
          h4("Your Data"),
          br(),
          h4(tags$b("Formatting and Uploading Your Data:")),
          p("If you want to upload a file containing your organization's data, you may do so via the upload file option 
            on the left panel. The information in your uploaded file should be taken from your organization's IRS Form 990
            filings, as detailed below.",
            "The file should be formatted preferably without a header; each line of the plain text file (e.g.: notepad or textedit) 
            should contain three comma separated values - the tax filing year, the total contributions from gifts for that 
            fiscal year, and the total revenue of that fiscal year."),
          p(tags$b("For example, take a file formatted as below:"), br(), 
            "1995, 10000, 20000", br(), "1998, 15000, 40000", br() ,"2002, 32000, 80000"),
          p("In the first row of this example, the tax filing in 1995 had $10,000 in contributed gifts and $20,000 
            in revenue."),
          p(tags$b("The values for columns 2 and 3 can be extracted from your organization's tax filings in IRS Form 990 Core document."), br(),
            tags$i("Column 2:")," amount of contributed gifts - Part VIII, Column A,Box 1h.", br(),
            tags$i("Column 3:")," total revenue reported - Part VIII, Column A, Box 12.", br(),
            "(These are both on page 9 of the 2015 version of the IRS 990 tax form; note that the format of this form may have 
            changed over time and older tax years may have these values in different locations on the IRS 990 form.)"),
          br(),
          p(tags$b("An example of a correctly formatted .csv file for an imaginary nonprofit may be downloaded here:")),
          downloadButton('downloadData', 'Download'), br(),
          br(),
          p("An example tax form can be accessed ", a("here.", href="https://www.irs.gov/pub/irs-pdf/f990.pdf"),
            "Ideally, the more tax years that you can include in your data file upload the better!", tags$b("By 
            comparing your data to that of similar organizations, you can gain important insight into the sustainability 
            of your organization's revenue model.")), br(),br(),
          h4(tags$b("Case Study Example:")),
          p("Imagine you are part of a youth development organization (NTEE code 'O') 
            that has been in operation for 20 years. Presently, you may be seeing a decrease in your reliance on 
            contributions to the total revenue of your organization, perhaps making more and more revenue from programs
            or membership fees."),
          p("However, if you don't see the finances of your organization heading in that direction (and your organization
            remains heavily dependent on individual contributions), you may want to re-examine your revenue model and 
            consider changes that would lead to more sustainable revenue streams as your organization moves forward."),
          br(),
          p("If you have uploaded a file, the data (and the columns calulated for plotting) will be shown below. The first 
            three columns are those provided by you, 'form' is the calculated years since tax filing and 'ratio' is the 
            calculated contributions/revenue ratio."),
          dataTableOutput('contents'),
          br(),br(),br(),
          h4(tags$b("Other analysis projects:")),
          a("GitHub Page", href="https://github.com/rwk506", style = "font-size:12pt;"),
          br(),
          a("Webpage", href="http://www.astro.ufl.edu/~rawagnerkaiser/Home.html", style = "font-size:12pt;"),  #style = "font-family: 'times'"
          br(),
          br()
          ),

        
        #### Description tab for all the included variables (try to keep in order...)
        tabPanel(
          h4("NTEEs"),
          br(),
          p("The various NTEE codes are described below and further information is available via ", 
          a("this link", href="http://nccs.urban.org/classification/national-taxonomy-exempt-entities"), "."),
          br(),
          br(),
          h4(tags$b("NTEE Codes and Descriptions:")),
          p(tags$b("D"),": ANIMAL-RELATED"),
          p(tags$b("A"),": ARTS, CULTURE and HUMANITIES"),
          p(tags$b("R"),": CIVIL RIGHTS, SOCIAL ACTION and ADVOCACY"),
          p(tags$b("S"),": COMMUNITY IMPROVEMENT and CAPACITY BUILDING"),
          p(tags$b("I"),": CRIME and LEGAL-RELATED"),
          p(tags$b("G"),": DISEASES, DISORDERS and MEDICAL DISCIPLINES"),
          p(tags$b("B"),": EDUCATION"),
          p(tags$b("J"),": EMPLOYMENT"),
          p(tags$b("C"),": ENVIRONMENT"),
          p(tags$b("K"),": FOOD, AGRICULTURE and NUTRITION"),
          p(tags$b("E"),": HEALTH CARE"),
          p(tags$b("L"),": HOUSING and SHELTER"),
          p(tags$b("P"),": HUMAN SERVICES"),
          p(tags$b("Q"),": INTERNATIONAL, FOREIGN AFFAIRS and NATIONAL SECURITY"),
          p(tags$b("H"),": MEDICAL RESEARCH"),
          p(tags$b("F"),": MENTAL HEALTH and CRISIS INTERVENTION"),
          p(tags$b("Y"),": MUTUAL and MEMBERSHIP BENEFIT"),
          p(tags$b("T"),": PHILANTHROPY, VOLUNTARISM and GRANTMAKING FOUNDATIONS"),
          p(tags$b("M"),": PUBLIC SAFETY, DISASTER PREPAREDNESS and RELIEF"),
          p(tags$b("W"),": PUBLIC and SOCIETAL BENEFIT"),
          p(tags$b("N"),": RECREATION and SPORTS"),
          p(tags$b("X"),": RELIGION-RELATED"),
          p(tags$b("U"),": SCIENCE and TECHNOLOGY"),
          p(tags$b("V"),": SOCIAL SCIENCE"),
          p(tags$b("Z"),": UNKNOWN"),
          p(tags$b("O"),": YOUTH DEVELOPMENT"),
          br(),
          p("There are additional subcategories for many of the above NTEE codes. While these subcategories are not
            presently included in the analysis, they may be provided upon request."),
          br(), br(), br(),
          h4(tags$b("Other analysis projects:")),
          a("GitHub Page", href="https://github.com/rwk506", style = "font-size:13pt;"),
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
          br(),
          h4(tags$b("References:")),
          br(),
          
          #### DATA
          p(tags$b("Data from IRS")), 
          p("Source: ", a("IRS Form 990 Data on AWS", href="https://aws.amazon.com/public-datasets/irs-990/")),
          p("Original data on the NPOs has been taken from the IRS Form 990 data, which is publicly available on Amazon
            Web Services. From an enormous effort on the part of DataKind and as part of the DataKind NYC DataDive in 
            March 2017, this data has been cleaned and processed into its present form."), 
          p(a("IRS Form 990 Example", href="https://www.irs.gov/pub/irs-pdf/f990.pdf")),
          p(a("IRS Form 990 Instructions", href="https://www.irs.gov/pub/irs-pdf/i990.pdf")),
          br(),
          
          #### NTEE
          p(tags$b("NTEE code information")),
          p(a("NTEE codes", href="http://nccs.urban.org/classification/national-taxonomy-exempt-entities")),
          p("The National Taxonomy of Exempt Entities is used by the IRS to classify non-profit organizations and facilitate
            collection, analysis, comparison of NPOs in a consistent manner."), br(),
          
          #### Additional Information
          p(tags$b("Additional Information")), 
          p("Additional resources that may be useful when interpreting and understanding the analysis presented here."), 
          p(a("DataKind", href="http://www.datakind.org/")),
          p(a("DataKind NYC DataDive", href="https://www.eventbrite.com/e/givingtuesday-datadive-presented-by-92y-datakind-and-the-bill-melinda-gates-foundation-registration-29290486634?utm_campaign=order_confirmation_email&utm_medium=email&ref=eemailordconf&utm_source=eb_email&utm_term=eventname#")),
          p(a("Tax Form 990 Wiki", href="https://en.wikipedia.org/wiki/Form_990")),
          p(a("National Center for Charitable Statistics", href="http://nccsweb.urban.org/knowledgebase/")),
          br(),
          br(),
          br(), 
          br(),
          h4(tags$b("Other analysis projects:")),
          a("GitHub Page", href="https://github.com/rwk506", style = "font-size:13pt;"),
          br(),
          a("Webpage", href="http://www.astro.ufl.edu/~rawagnerkaiser/Home.html", style = "font-size:13pt;"),  #style = "font-family: 'times'"
          br(),
          br()
        )
        
      )
    ))
  ))