
vars <- setdiff(names(happy), "Country name")
vars_w <- setdiff(names(happy_w), "CountryName")
fluidPage(
tabsetPanel(
  tabPanel("K-Means",
    pageWithSidebar(
    headerPanel('Country Happiness k-means clustering'),
    sidebarPanel(
      selectInput('xcol', 'X Variable', vars),
      selectInput('ycol', 'Y Variable', vars, selected = vars[[2]]),
      numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
    ),
    mainPanel(
      plotOutput('plot1')
    )
  )),
  tabPanel("Regression",
           pageWithSidebar(
             headerPanel('Country Happiness Regression Analysis'),
             sidebarPanel(
               selectInput('xcol2', 'X Variable', vars_w),
               selectInput('ycol2', 'Y Variable', vars_w, selected = vars_w[[2]])),
             
             mainPanel(
               verbatimTextOutput(outputId = "RegOut"),
               plotlyOutput(outputId = "regline"),
               plotOutput(outputId = "regplots"),
               plotOutput('plot2')
             )
             )
           ),
  tabPanel("Data Explore", 
           pageWithSidebar(
             headerPanel('Country Happiness Explore by World Region'),
             sidebarPanel(
               selectInput('xcol3', 'X Variable', vars_w),
               selectInput('ycol3', 'Y Variable', vars_w, selected = vars_w[[2]])),
             
             mainPanel(
               plotOutput('plot3')
             )
           )
           
  ),
  tabPanel("Description", 
           titlePanel("Description of Analysis & Methodology, and Data Set"),
           h3("Mathematical Analysis & Methodlogy"),
           h5("K-Means"),
           p("K-means is a clustering algorithm that tries to group similar items into clusters. 'K' is the number of groups. K-means operates by first selecting the k value then dividing the data along central line(s), then finding the average of each subset of data to develop a centroid to cluster the data around. K-means seemed approporptriate for this data set to determine if there were any groups in the data that were not labeled."),
           h5("Regression"),
           p("The linear regression performed as part of this analysis was employed to determine the relationship between any of the country charteristcs included in the country happiness data set. The independent variables in this evaluation include Logged GDP per capita, Social support, Healthy life expectancy, Freedom to make life choices, Generosity, Perceptions of corruption. The dependent variable is Ladder score. But this interface also allows one to play around and investigate the relationships between any of the variables. Perhaps the most useful result to note is the p-value - the smaller it is the more signifcant the correlation between variables is; any p-value < 0.001 is considered signficant."),
           h5("Region of World Explore"),
           p("Lastly, out of curiousity I created a graph to just display the data by region of the world, so the user could more clearly see if there are regions of the world that tend to have similar characteristics or to be happier than others."),
           h3("Data Set Selection"),
           p("I was just curious about the relationship between happiness of citizens and a countries attributes. Maybe some useful information one could adapt to their own life. I did find it interesting how Generosity did not appear to be coorelated with happiness, especially as there are many studies about the positive impact altruism has on well being.  And how Sub-Saharan African tend to rank low on most everything. ")
           )
))