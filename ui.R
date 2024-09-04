ui = fluidPage(
  
  title = 'World Cup 2026 - Belgium', # what appears on browser tab
  theme = shinytheme('cyborg'), # one of 16 themes from https://rstudio.github.io/shinythemes/
  uiOutput('bkgrd'), # background image
  
  useShinyjs(),
  
  # activate shiny animate----
  withAnim(),
  
  uiOutput('uiBelgium')
  
)
