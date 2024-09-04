server = function(input, output, session) {
  
  # >>>>>>>>>>>>>>>>>>>>>----
  # reactives----
  wc = reactiveValues(
    be = 0, # hide/show belgium app (0 or 1)
    tb = 0, # selected tab (1 to 5)
    ln = 1, # selected language
    co = 0, # hide/show city opt (0 or 1)
    gm = 0, # selected game (1 to 3)
    tm = 0, # selected teammate (1 to 6)
    pl = 0, # selected player (1 to 11)
    ho = 0, # search for hotels (0 or 1)
    re = 0, # search for rests (0 or 1)
    ex = 0, # search for places (0 or 1)
    hd = 0, # hotel detail
    don = c(0, 0, 0), # storing top 3 donation amounts
    xd = NULL, # details of exploring option
  )
  
  # background iamges----
  output$bkgrd = renderUI(
    if (wc$tb != 0) {
      setBackgroundImage(src = 'black.jpeg')
    } else {
      setBackgroundImage(src = 'home_2.jpg')
    }
  )
  
  # >>>>>>>>>>>>>>>>>>>>>----
  # ui belgium----
  output$uiBelgium = renderUI(
    if (wc$be == 0) {
      div(
        id = 'flag',
        style = paste0(
          'display:flex; justify-content:center; ',
          'overflow:hidden; ',
          'height:100vh;'
        ),
        tags$button(
          id = 'homeBtn',
          class = 'btn action-button',
          style = 'background-color:rgba(0,0,0,0); padding:0; margin:0;',
          img(
            src = 'start_screen.jpg',
            width = '1750px' # <-- adjust as needed to make flag fit well within screen
          )
        ), 
        
           #Welcome text ----
           div(style = "position: absolute; font-size: 140px; letter-spacing: 3.2rem;
            left: 7.5%;
            bottom:-4%",  
               tags$span(style = 'color:yellow;', 'W'),
               tags$span(style = 'color:yellow;', 'E'),
               tags$span(style = 'color:red;', 'L'),
               tags$span(style = 'color:red;', 'C'),
               tags$span(style = 'color:red;', 'O'),
               tags$span(style = 'color:black;', 'M'),
               tags$span(style = 'color:black;', 'E!')),
      
           # animated ball ----
           div(style = "position: absolute;
            left: 57%;
            bottom: 1%",  
               img(
                 src = 'ball_anim.gif',
                 width = '130px',
                 height = '130px',
               )
           ),
        
            #Welcomes in different languages ----
            div(style = "position: absolute; font-size: 55px; letter-spacing: 0.2rem; background-color:Black;
                left: 7%;
                bottom:88%",  
            tags$span(style = 'color:white; backround-color:Black;', 'WELKOM!')),
            div(style = "position: absolute; font-size: 55px; letter-spacing: 0.2rem; background-color:Black;
                left: 41%;
                bottom:88%",  
            tags$span(style = 'color:white; backround-color:Black;', 'BIENVENUE!')),
            div(style = "position: absolute; font-size: 55px; letter-spacing: 0.2rem; background-color:Black;
                left: 72%;
                bottom:88%",  
            tags$span(style = 'color:white; backround-color:Black;', 'WILLKOMMEN!')),

      )
    } else {
      div(
        style = 'padding:0 15px 0 15px;',
        uiOutput('uiHeader'),
        uiOutput('uiBody'),
        uiOutput('uiFooter')
      )
    }
  )
  
  observeEvent(
    input$homeBtn, 
    {
      startAnim(session, 'flag', 'slideOutUp')
      delay(800, {wc$be = 1})
    }
  )
  
  # _ui header----
  output$uiHeader = renderUI(
    {
      div(
        # style = 'height:5vh;',
        fluidRow(  tags$style(HTML("
                    .btn-group .btn .fa-wine-glass {
                      color: yellow;
                    }
                    .btn-group .btn .wine-glass-empty {
                      color: white;
                    }
                    .btn-outline {
                     border-width: 7px;
                    }
                  ")),
          # __ui logo----
          column(
            width = 1,
            style = 'padding-top:10px;',
            tags$button(
              id = 'logo',
              class = 'btn action-button',
              style = 'background-color:rgba(0,0,0,0); padding:0; margin:0;',
              img(
                src = 'be_emblem.png',
                width = '50%'
              )
            )
          ),
          column(
            width = 11,
            fluidRow(
              # __ui countdown----
              column(
                width = 7,
                style = 'padding:2px;',
                h4(  switch(wc$ln, 'Time until the next ', 'Il est temps jusqu au prochain ', 'Zeit bis zum nächsten ', 'Tijd tot de volgende '),
                     tags$span(style = 'color:red;', switch(wc$ln, 'Red Devils', 'Diables Rouges', 'Rote Teufel', 'Rode Duivels')),
                     paste0(switch(wc$ln, 'match: ','jeu: ','spiel: ', 'spel: '), as.numeric(difftime(as.Date("2026-06-13"), Sys.Date(), units = "days")),
                            switch(wc$ln, ' days',' jours',' Tage', ' dagen'))
                            
                )
              ),
              
              # __ui city----
              column(
                width = 3,
                align = 'center',
                uiOutput('uiCityOpt')
              ),
              # __ui lang----
              column(
                width = 2,
                align = 'right',
                style = 'padding:10px 0 0 0;',
                tags$button(
                  id = 'lang1',
                  class = 'btn action-button',
                  style = paste0(
                    'background-color:rgba(0,0,0,0); ',
                    'padding:0; margin:0; ',
                    'border-radius:10px;'
                  ),
                  img(
                    src = 'flags/us.png',
                    width = '20px'
                  )
                ),
                tags$button(
                  id = 'lang2',
                  class = 'btn action-button',
                  style = paste0(
                    'background-color:rgba(0,0,0,0); ',
                    'padding:0; margin:0; ',
                    'border-radius:10px;'
                  ),
                  img(
                    src = 'flags/fr.png',
                    width = '20px'
                  )
                ),
                tags$button(
                  id = 'lang3',
                  class = 'btn action-button',
                  style = paste0(
                    'background-color:rgba(0,0,0,0); ',
                    'padding:0; margin:0; ',
                    'border-radius:10px;'
                  ),
                  img(
                    src = 'flags/de.png',
                    width = '20px'
                  )
                ),
                tags$button(
                  id = 'lang4',
                  class = 'btn action-button',
                  style = paste0(
                    'background-color:rgba(0,0,0,0); ',
                    'padding:0; margin:0; ',
                    'border-radius:10px;'
                  ),
                  img(
                    src = 'flags/nl.png',
                    width = '20px'
                  )
                )
              )
            ),
            # __ui tabs----
            fluidRow(
              # ___tab1 team----
              column(
                width = 2,
                style = 'padding:2px;',
                actionBttn(
                  inputId = 'tab1',
                  label = switch(wc$ln, 'Team', 'Équipe', 'Mannschaft', 'Elftal'),
                  style = ifelse(wc$tb == 1, 'simple', 'bordered'),
                  color = 'warning',
                  size = 'md',
                  block = TRUE,
                  icon = icon('users'),
                  class = "btn-outline"
                )
              ),
              # ___tab2 matches----
              column(
                width = 2,
                style = 'padding:2px;',
                actionBttn(
                  inputId = 'tab2',
                  label = switch(wc$ln, 'Matches', 'Parties', 'Fußballspiele', 'Wedstrijden'),
                  style = ifelse(wc$tb == 2, 'simple', 'bordered'),
                  color = 'warning',
                  size = 'md',
                  block = TRUE,
                  icon = icon('futbol'),
                  class = "btn-outline"
                )
              ),
              # ___tab3 lodging----
              column(
                width = 2,
                style = 'padding:2px;',
                actionBttn(
                  inputId = 'tab3',
                  label = switch(wc$ln, 'Lodging', 'Hébergement', 'Unterkunft', 'Accommodatie'),
                  style = ifelse(wc$tb == 3, 'simple', 'bordered'),
                  color = 'warning',
                  size = 'md',
                  block = TRUE,
                  icon = icon('bed'),
                  class = "btn-outline"
                )
              ),
              # ___tab4 dining----
              column(
                width = 2,
                style = 'padding:2px;',
                actionBttn(
                  inputId = 'tab4',
                  label = switch(wc$ln, 'Dining', 'À manger', 'Essen', 'Dineren'),
                  style = ifelse(wc$tb == 4, 'simple', 'bordered'),
                  color = 'warning',
                  size = 'md',
                  block = TRUE,
                  icon = icon('utensils'),
                  class = "btn-outline"
                )
              ),
              # ___tab5 exploring----
              column(
                width = 2,
                style = 'padding:2px;',
                actionBttn(
                  inputId = 'tab5',
                  label = switch(wc$ln, 'Exploring', 'Exploration', 'Erkunden', 'Ontdekken'), 
                  style = ifelse(wc$tb == 5, 'simple', 'bordered'),
                  color = 'warning',
                  size = 'md',
                  block = TRUE,
                  icon = icon('location-dot'),
                  class = "btn-outline"
                )
              ),
              column(
                width = 1,
                offset = 1,
                style = 'padding:2px;',
                actionBttn(
                  inputId = 'tab6',
                  label = NULL,
                  style = ifelse(wc$tb == 6, 'simple', 'bordered'),
                  color = 'danger',
                  size = 'md',
                  block = TRUE,
                  icon = icon('user'),
                  class = "btn-outline"
                )
              )
            )
          )
        )
      )
    }
  )
  
  # _ui city opt----
  output$uiCityOpt = renderUI(
    if (wc$co == 1) {
      div(
        style = 'padding:5px 0 0 0;',
        # materialSwitch(
        #   inputId = 'cityOpt',
        #   label = NULL,
        #   status = 'danger'
        # )
        radioGroupButtons(
          inputId = 'cityOpt',
          label = NULL,
          choices = c('Foxborough' = 1, 'Miami' = 2),
          selected = 1,
          individual = TRUE,
          justified = TRUE,
          size = 'sm',
          checkIcon = list(
            yes = tags$i(
              class = 'fa fa-circle',
              style = 'color: steelblue'
            ),
            no = tags$i(
              class = 'fa fa-circle-o',
              style = 'color: steelblue'
            )
          )
        )
      )
    }
  )
  
  # >>>>>>>>>>>>>>>>>>>>>----
  # button clicks----
  observeEvent(input$logo, {wc$tb = 0; wc$co = 0})
  observeEvent(input$tab1, {wc$tb = 1; wc$co = 0})
  observeEvent(input$tab2, {wc$tb = 2; wc$co = 0})
  observeEvent(input$tab3, {wc$tb = 3; wc$co = 1})
  observeEvent(input$tab4, {wc$tb = 4; wc$co = 1})
  observeEvent(input$tab5, {wc$tb = 5; wc$co = 1})
  observeEvent(input$tab6, {wc$tb = 6; wc$co = 0})
  
  observeEvent(input$donate, {wc$tb = 9; wc$co = 0})
  
  observeEvent(input$lang1, {wc$ln = 1})
  observeEvent(input$lang2, {wc$ln = 2})
  observeEvent(input$lang3, {wc$ln = 3})
  observeEvent(input$lang4, {wc$ln = 4})
  
  # >>>>>>>>>>>>>>>>>>>>>----
  # ui body----
  output$uiBody = renderUI(
    if (wc$tb == 1) {uiOutput('uiPlayers')}
    else if (wc$tb == 2) {uiOutput('uiMatches')}
    else if (wc$tb == 3) {uiOutput('uiLodging')}
    else if (wc$tb == 4) {uiOutput('uiDining')}
    else if (wc$tb == 5) {uiOutput('uiExploring')}
    else if (wc$tb == 6) {uiOutput('uiAbout')}
    else if (wc$tb == 9) {uiOutput('uiDonate')}
    else {
      # div(
      #   style = 'min-height:80vh; left: 20%; background-repeat:no-repeat; background-image:url("home.jpg");',
      #   # h1(paste0('Tab ', wc$tb))
      # )
    }
  )
  
  # >>>>>>>>>>>>>>>>>>>>>----
  # ui players----
  output$uiPlayers = renderUI(
    {
      z = dbGetQuery(
        con, 'SELECT * FROM players WHERE is_playing_11 ORDER BY position, player_name;'
      )
      div(
        fluidRow(
          column(
            width = 6,
            div(
              style = 'padding:10px 5% 40px 5%;',
              div(
                align = 'center',
                # _forwards----
                div(
                  # style = 'padding:0 20% 0 20%;',
                  div(
                    lapply(
                      5:8,
                      function(i) {
                        tags$button(
                          id = paste0('plyr', i),
                          class = 'btn action-button',
                          style = 'background-color:rgba(0,0,0,0); padding:0; margin:0 20px 0 20px; border-radius:10px;',
                          img(
                            src = paste0('plyrs/', z$player_id[i], '.jpg'),
                            width = '80px',
                            style = 'border-radius:10px; margin:5px 0 5px 0;'
                          )
                        )
                      }
                    )
                  ),
                  # hr(style = 'margin:10px 0 10px 0;'),
                  # _midfielders----
                  div(
                    lapply(
                      10:11,
                      function(i) {
                        tags$button(
                          id = paste0('plyr', i),
                          class = 'btn action-button',
                          style = 'background-color:rgba(0,0,0,0); padding:0; margin:0 20px 0 20px; border-radius:10px;',
                          img(
                            src = paste0('plyrs/', z$player_id[i], '.jpg'),
                            width = '80px',
                            style = 'border-radius:10px; margin:5px 0 5px 0;'
                          )
                        )
                      }
                    )
                  ),
                  # hr(style = 'margin:10px 0 10px 0;'),
                  # _defenders----
                  div(
                    lapply(
                      1:4,
                      function(i) {
                        tags$button(
                          id = paste0('plyr', i),
                          class = 'btn action-button',
                          style = 'background-color:rgba(0,0,0,0); padding:0; margin:0 20px 0 20px; border-radius:10px;',
                          img(
                            src = paste0('plyrs/', z$player_id[i], '.jpg'),
                            width = '80px',
                            style = 'border-radius:10px; margin:5px 0 5px 0;'
                          )
                        )
                      }
                    )
                  ),
                  # hr(style = 'margin:10px 0 10px 0;'),
                  # _goalkeepers----
                  div(
                    lapply(
                      9:9,
                      function(i) {
                        tags$button(
                          id = paste0('plyr', i),
                          class = 'btn action-button',
                          style = 'background-color:rgba(0,0,0,0); padding:0; margin:0 20px 0 20px; border-radius:10px;',
                          img(
                            src = paste0('plyrs/', z$player_id[i], '.jpg'),
                            width = '80px',
                            style = 'border-radius:10px; margin:5px 0 5px 0;'
                          )
                        )
                      }
                    )
                  )
                )
              )
            )
          ),
          column(
            width = 6,
            style = 'padding:10px 0 0 0;',
            uiOutput('uiPlyrInfo')
          )
        )
      )
    }
  )
  
  # __events plyr buttons----
  # observeEvent(input$plyr1, {wc$pl = 1; cardFlip()})
  observeEvent(input$plyr1, {wc$pl = 1})
  observeEvent(input$plyr2, {wc$pl = 2})
  observeEvent(input$plyr3, {wc$pl = 3})
  observeEvent(input$plyr4, {wc$pl = 4})
  observeEvent(input$plyr5, {wc$pl = 5})
  observeEvent(input$plyr6, {wc$pl = 6})
  observeEvent(input$plyr7, {wc$pl = 7})
  observeEvent(input$plyr8, {wc$pl = 8})
  observeEvent(input$plyr9, {wc$pl = 9})
  observeEvent(input$plyr10, {wc$pl = 10})
  observeEvent(input$plyr11, {wc$pl = 11})
  
  # __ui plyr info----
  output$uiPlyrInfo = renderUI(
    if (wc$pl == 0) {
      div(
        id = 'cardback',
        img(
          src = 'cardback.jpg'
          #height = '680px',
          #width = '730px'
        )
      )
    } else {
      z = dbGetQuery(
        con, 'SELECT * FROM players WHERE is_playing_11 ORDER BY position, player_name;'
      )
      div(
        style = paste0(
          'padding:15px; ',
          'background-color:rgba(200,0,0,0.3); ',
          'border-radius: 10px; '
          # 'background-image:url("plyrs/', z$player_id[wc$pl], '.jpg"); ',
          # 'background-repeat:no-repeat; ',
          # 'height:1400px;',
          # 'width:400px;'
        ),
        fluidRow(
          column(
            width = 3,
            img(
              src = paste0('plyrs/', z$player_id[wc$pl], '.jpg'),
              width = '100%'
            )
          ),
          column(
            width = 9,
            h4(
              img(src = 'flags/be.png', width = '50px'),
              z$player_name[wc$pl]
            ),
            fluidRow(
              column(
                width = 6,
                h4(z$position[wc$pl]),
                h4(z$dob[wc$pl]),
                h1(
                  z$total_match[wc$pl],
                  tags$span(style = 'font-size:22px;', 'appearances')
                )
              ),
              column(
                width = 6,
                lapply(
                  1:4,
                  function(i) {
                    div(
                      style = paste0(
                        'background-color:white; border-radius:10px; ',
                        'padding:3px; margin:2px 0 0 0;'
                      ),
                      fluidRow(
                        column(
                          width = 9,
                          h6(
                            style = 'color:black;',
                            c('Minutes played', 'Goals scored', 'Assists', 'Yellow cards')[i]
                          )
                        ),
                        column(
                          width = 3,
                          align = 'right',
                          h6(
                            style = 'color:red;',
                            c(
                              z$total_minutes[wc$pl],
                              z$total_goal[wc$pl],
                              z$total_assist[wc$pl],
                              z$total_red[wc$pl]
                            )[i]
                          )
                        )
                      )
                    )
                  }
                )
              )
            )
          )
        ),
        fluidRow(
          # column(
          #   width = 6,
          #   highchartOutput('statChart1', width = '90%')
          # ),
          column(
            width = 12,
            highchartOutput('statChart2', width = '90%')
          )
        )
      )
    }
  )
  
  cardFlip = function() {
    startAnim(session, 'cardback', 'flipInY')
    delay(800, {wc$be = 1})
  }
  
  # ___stat chart 1----
  # output$statChart1 = renderHighchart(
  #   {
  #     z = dbGetQuery(
  #       con, 'SELECT * FROM players WHERE is_playing_11 ORDER BY position, player_name;'
  #     )[wc$pl,12:18]
  #     hchart(z, hcaes(y = overall), type = 'bar') 
  #   } 
  # )
  
  output$statChart1 = renderHighchart(
    {
      z = dbGetQuery(
        con, 'SELECT * FROM players WHERE is_playing_11 ORDER BY position, player_name;'
      )[wc$pl, 12:18]
      
      hchart(
        z, 
        hcaes(y = overall), 
        type = 'bar'
      ) |> 
        hc_plotOptions(
          bar = list(
            color = '#FF0000' # Set bar color to red
          )
        ) %>%
        hc_xAxis(
          labels = list(style = list(color = '#FFFFFF')) # Optional: Set x-axis label text color to white
        ) %>%
        hc_yAxis(
          labels = list(style = list(color = '#FFFFFF')) # Optional: Set y-axis label text color to white
        )
    }
  )
  
  
  
  # # ___stat chart 2----
  # output$statChart2 = renderHighchart(
  #   {
  #     z = dbGetQuery(
  #       con, 'SELECT * FROM players WHERE is_playing_11 ORDER BY position, player_name;'
  #     )[wc$pl,12:18]
  #     hchart(
  #       object = z, 
  #       mapping = hcaes(y = pace, shooting, passing, dribbling, defending, physical), 
  #       type = 'area',
  #       animation = list(
  #         defer = 1000,
  #         duration = 1000,
  #         easing = 'easeOutBounce'
  #       )
  #     ) |> 
  #       hc_chart(polar = TRUE)
  #   } 
  # )
  
  output$statChart2 = renderHighchart(
    {
      z = dbGetQuery(
        con, 'SELECT * FROM players WHERE is_playing_11 ORDER BY position, player_name;'
      )[wc$pl, 12:18]
      
      # Convert data to long format if needed for polar chart
      z_long = z %>%
        pivot_longer(cols = c(pace, shooting, passing, dribbling, defending, physical), 
                     names_to = 'attribute', values_to = 'value')
      
      hchart(
        object = z_long, 
        mapping = hcaes(x = attribute, y = value), # Mapping for polar chart
        type = 'area', # 'line' is generally used for polar charts; adjust type if needed
        animation = list(
          defer = 1000,
          duration = 1000,
          easing = 'easeOutBounce'
        )
      ) |> 
        hc_chart(polar = TRUE) %>%
        hc_xAxis(
          title = list(enabled = FALSE),
          categories = c('Pace', 'Shooting', 'Passing', 'Dribbling', 'Defending', 'Physical'),
          labels = list(style = list(color = '#FFFFFF', fontSize = '14px')) # Set x-axis label text color to white
        ) %>%
        hc_yAxis(
          title = list(enabled = FALSE),
          labels = list(enabled = FALSE,
                        style = list(color = '#FFFFFF')) # Set y-axis label text color to white
        ) %>%
        hc_plotOptions(
          line = list(
            color = '#FF0000' # Set line color to red
          )
        )%>%
        hc_tooltip(
          headerFormat = '', # Remove 'Series 1'
          pointFormat = '<b>{point.y}' # Display attribute and value
        )
    }
  )
  
  
  # >>>>>>>>>>>>>>>>>>>>>----
  # ui matches----
  output$uiMatches = renderUI(
    {
      z = dbGetQuery(
        con, 'SELECT * FROM matches;'
      )
      div(
        align = 'center',
        h4(
          style = 'color:gold;',
          'The Group C Stage Games for Team Belgium'
        ),
        # _top panels----
        div(
          style = 'padding:10px 80px 10px 80px;',
          fluidRow(
            style = 'margin:0;',
            # __game buttons----
            lapply(
              1:3,
              function(i) {
                column(
                  width = 4,
                  tags$button(
                    id = paste0('game', i),
                    class = 'btn action-button',
                    style = 'background-color:rgba(0,0,0,0); padding:0; margin:0;',
                    div(
                      style = paste0(
                        'padding:5px 20px 5px 20px; ',
                        'background-color:rgba(255,255,255,0.5); ',
                        'border-radius:10px;'
                      ),
                      h6(
                        style = 'color:white;',
                        paste('Game', i)
                      ),
                      fluidRow(
                        column(
                          width = 5,
                          align = 'right',
                          img(
                            src = paste0('flags/', c('be', 'be', 'zw')[i], '.png'),
                            width = '40%'
                          )
                        ),
                        column(
                          width = 2,
                          align = 'center',
                          h6(style = 'color:white;', 'vs')
                        ),
                        column(
                          width = 5,
                          align = 'left',
                          img(
                            src = paste0('flags/', c('kr', 'pe', 'be')[i], '.png'),
                            width = '40%'
                          )
                        )
                      )
                    )
                  )
                )
              }
            )
          )
        ),
        hr(style = 'margin:10px 0 10px 0;'),
        # _bottom panels----
        fluidRow(
          # __map----
          column(
            width = 8,
            div(
              style = paste0(
                'padding:10px; ',
                'background-color:rgba(255,255,255,0.5); ',
                'border-radius:10px;'
              ),
              leafletOutput(
                outputId = 'gameMap',
                height = '50vh'
              )
            )
          ),
          # __detail----
          column(
            width = 4,
            uiOutput(
              outputId = 'gameDetail'
            )
          )
        )
      )
    }
  )
  
  # _events game buttons----
  observeEvent(input$game1, {wc$gm = 1})
  observeEvent(input$game2, {wc$gm = 2})
  observeEvent(input$game3, {wc$gm = 3})
  
  # _game map----
  output$gameMap = renderLeaflet(
    {
      z = dbGetQuery(
        con,
        'SELECT * FROM matches JOIN venues USING (venue_id) JOIN locations USING (locn_id);'
      )
      if (wc$gm > 0) {
        z = filter(z, match_id == c(5,30,49)[wc$gm])
      }
      z |> 
        leaflet() |> 
        addTiles() |> 
        addAwesomeMarkers(
          lat = ~lat,
          lng = ~lng,
          popup = ~venue_name,
          icon = awesomeIcons(
            markerColor = 'red',
            icon = 'star'
          )
        )
    }
  )
  
  # _game detail----
  output$gameDetail = renderUI(
    if (wc$gm > 0) {
      div(
        style = paste0(
          'padding:10px; ',
          'background-color:rgba(255,255,255,0.5); ',
          'border-radius:10px;'
        ),
        div(
          style = paste0(
            'height:50vh; ',
            'padding:10px; ',
            'background-color:rgba(0,0,0,0.8); ',
            'border-radius:10px;'
          ),
          h4(paste('Game', wc$gm)),
          div(
            style = 'background-color:rgba(1,1,1,0.5); padding:5px;',
            h5(style = 'color:white;', c('Belgium', 'Belgium', 'Zimbabwe')[wc$gm]),
            h6(style = 'color:white;', 'vs'),
            h5(style = 'color:white;', c('South Korea', 'Peru', 'Belgium')[wc$gm])
          ),
          h5(c('Boston Stadium', 'Boston Stadium', 'Miami Stadium')[wc$gm]),
          h6(c('Foxborough', 'Foxborough', 'Miami Gardens')[wc$gm]),
          h6(c('2026-06-13', '2026-06-19', '2026-06-24')[wc$gm]),
          actionBttn(
            inputId = 'buyTix',
            label = 'Buy Tickets',
            style = 'simple',
            color = 'success',
            size = 'md',
            block = TRUE,
            icon = icon('ticket')
          )
        )
      )
    }
  )
  
  # _event buy tix----
  observeEvent(
    input$buyTix, 
    {
      showModal(
        modalDialog(
          h3(paste0('Buy Game Tickets for Game ', wc$gm)),
          fluidRow(
            column(
              width = 6,
              radioGroupButtons(
                inputId = 'qtyTix',
                label = 'Qty',
                choices = 1:4,
                selected = 1
              )
            ),
            column(
              width = 6,
              pickerInput(
                inputId = 'catTix',
                label = 'Category',
                choices = c('Field Level' = 1, 'Upper Level' = 2, 'Luxury Box' = 3),
                selected = 1
              )
            )
          ),
          footer = tagList(
            actionButton('submitTix', 'Buy Now'),
            modalButton('Cancel')
          )
        )
      )
    }
  )
  
  # _event submit tix----
  observeEvent(
    input$submitTix,
    {
      removeModal()
      sendSweetAlert(
        title = 'GOOOOOOOOOOAL!',
        text = 'You\'ve scored some tickets to the game!',
        type = 'success'
      )
    }
  )
  
  
  
  # >>>>>>>>>>>>>>>>>>>>>----
  # ui lodging----
  output$uiLodging = renderUI(
    {
      div(
        align = 'center',
        h4(
          style = 'color:gold;',
          'Discover the Perfect Stay for an Unforgettable Experience'
        ),
        div(
          style = 'padding:0 15% 0 15%;',
          checkboxGroupButtons(
            inputId = 'hotelOpts',
            label = NULL,
            choices = c('Star-Ratings', 'Check-in & Out', 'Price', 'Commute', 'Breakfast'),
            selected = NULL,
            justified = TRUE,
            checkIcon = list(
              yes = tags$i(
                class = 'fa fa-check-square', 
                style = 'color: steelblue'
              ),
              no = tags$i(
                class = 'fa fa-square-o', 
                style = 'color: steelblue'
              )
            )
          ),
          actionBttn(
            inputId = 'submitHotel',
            label = 'Find Hotels',
            style = 'simple',
            color = 'danger',
            size = 'sm',
            icon = icon('search')
          )
        ),
        uiOutput('uiHotelResults'),
        uiOutput('uiHotelDetail')
      )
    }
  )
  
  # Modal for Star-Ratings
  observeEvent(input$hotelOpts, {
    if ('Star-Ratings' %in% input$hotelOpts) {
      showModal(
        modalDialog(
          title = "Set Star Ratings",
          sliderInput("starRating", "Minimum Star Rating", min = 1, max = 5, value = 4, step = 0.5),
          footer = tagList(
            actionButton("submitStarRating", "Submit"),
            modalButton("Cancel")
          )
        )
      )
    }
  })
  
  # Modal for Check-in & Out
  observeEvent(input$hotelOpts, {
    if ('Check-in & Out' %in% input$hotelOpts) {
      showModal(
        modalDialog(
          title = "Set Check-in & Check-out Time",
          textInput("checkinTime", "Check-in Time (e.g., 2:00 PM)", value = "2:00 PM"),
          textInput("checkoutTime", "Check-out Time (e.g., 11:00 AM)", value = "11:00 AM"),
          footer = tagList(
            actionButton("submitCheckinCheckout", "Submit"),
            modalButton("Cancel")
          )
        )
      )
    }
  })
  
  # Modal for Price
  observeEvent(input$hotelOpts, {
    if ('Price' %in% input$hotelOpts) {
      showModal(
        modalDialog(
          title = "Set Price Range",
          numericInput("minPrice", "Minimum Price", value = 100, min = 0, step = 10),
          numericInput("maxPrice", "Maximum Price", value = 500, min = 0, step = 10),
          footer = tagList(
            actionButton("submitPrice", "Submit"),
            modalButton("Cancel")
          )
        )
      )
    }
  })
  
  # Modal for Commute
  observeEvent(input$hotelOpts, {
    if ('Commute' %in% input$hotelOpts) {
      showModal(
        modalDialog(
          title = "Set Commute Time",
          sliderInput("commuteTime", "Commute Time (in minutes)", min = 0, max = 60, value = 10, step = 5),
          footer = tagList(
            actionButton("submitCommute", "Submit"),
            modalButton("Cancel")
          )
        )
      )
    }
  })
  
  # Modal for Breakfast
  observeEvent(input$hotelOpts, {
    if ('Breakfast' %in% input$hotelOpts) {
      showModal(
        modalDialog(
          title = "Breakfast Options",
          checkboxGroupInput("breakfastOptions", "Choose Breakfast Options", 
                             choices = list("Included" = "Yes", "Not Included" = "No"),
                             selected = "Yes"),
          footer = tagList(
            actionButton("submitBreakfast", "Submit"),
            modalButton("Cancel")
          )
        )
      )
    }
  })
  
  # Store breakfast preference
  breakfastPreference <- reactiveVal(NULL)
  
  # Submit action for breakfast
  observeEvent(input$submitBreakfast, {
    removeModal()
    breakfastPreference(input$breakfastOptions)
    showNotification(paste("Breakfast option set to", paste(input$breakfastOptions, collapse = ", ")))
  })
  
  # _event submit hotel----
  observeEvent(input$submitHotel, {wc$ho = 1})
  
  # _ui hotel results----
  output$uiHotelResults = renderUI({
    req(breakfastPreference())
    
    if (wc$ho == 1) {
      z = dbGetQuery(
        con, 'SELECT * FROM hotels JOIN locations USING (locn_id);'
      )
      if (input$cityOpt == 1) {
        messages <- c("Hilton Garden Inn Foxborough Patriot Place",
                      "Renaissance Boston Patriot Place Hotel")
        div(
          h4(
            style = 'color:red;',
            'Top 2 choices based on your search.'
          ),
          div(
            style = 'padding:0 15% 0 15%;',
            fluidRow(
              lapply(
                1:2,
                function(i) {
                  column(
                    width = 6,
                    div(
                      tags$button(
                        id = paste0('hotelF', i),
                        class = 'btn action-button',
                        style = 'background-color:rgba(0,0,0,0); padding:0; margin:0;',
                        img(
                          src = paste0('hotels/fox_h', i, c('.webp', '.png')[i]),
                          height = '200px',
                          style = 'border-radius:10px;'
                        )
                      ),
                      h4(messages[i])
                    )
                  )
                }
              )
            )
          )
        )
      } else if (input$cityOpt == 2 || ("Yes" %in% breakfastPreference())) {
        messages <- c("SpringHill Suites Fort Lauderdale Miramar",
                      "WoodSpring Suites Miramar")
        div(
          h4(
            style = 'color:red;',
            'Top 2 choices based on your search.'
          ),
          div(
            style = 'padding:0 15% 0 15%;',
            fluidRow(
              lapply(
                14:15,
                function(i) {
                  column(
                    width = 6,
                    div(
                      tags$button(
                        id = paste0('hotelM', i),
                        class = 'btn action-button',
                        style = 'background-color:rgba(0,0,0,0); padding:0; margin:0;',
                        img(
                          src = paste0('hotels/mia_h', i, c('.png', '.png')[i-13]),
                          height = '200px',
                          style = 'border-radius:10px;'
                        )
                      ),
                      h4(messages[i-13])
                    )
                  )
                }
              )
            )
          )
        )
      }
    }
  })
  
  # _events hotel buttons----
  observeEvent(input$hotelF1, {wc$hd = 1})
  observeEvent(input$hotelF2, {wc$hd = 2})
  observeEvent(input$hotelM14, {wc$hd = 3})
  observeEvent(input$hotelM15, {wc$hd = 4})
  
  # _ui hotel detail----
  output$uiHotelDetail = renderUI(
    if (wc$hd > 0) {
      z = dbGetQuery(
        con,
        paste0(
          'SELECT * FROM hotels JOIN locations USING (locn_id) ',
          'WHERE locn_id = \'', 
          ifelse(as.numeric(input$cityOpt) == 1, ifelse(wc$hd == 1, 'fox_h1', 'fox_h2'), ifelse(wc$hd == 3, 'mia_h14', 'mia_h15')), '\';'
        )
      )
      div(
        align = 'left',
        style = 'padding:0 15% 0 15%;',
        div(
          style = 'background-color:rgba(255,255,255,0.5); padding:10px; border-radius:10px;',
          fluidRow(
            column(
              width = 6,
              leafletOutput('hotelMap')
            ),
            column(
              width = 6,
              h5(style = 'color:black; font-weight:bold;',z$hotel_name),
              h6(tags$span(style = 'color:White;', 'Star rating:'), tags$span(style = 'color:gold;', strrep('★', z$star_rating))),
              h6(paste0('User-rating: ', z$user_rating)),
              h6(paste0('Check-in time: ', z$check_in)),
              h6(paste0('Check-out time: ', z$check_out)),
              h6(paste0('Budget: $', z$budget)),
              h6(paste0('Breakfast: ', ifelse(z$breakfast, 'Yes', 'No'))),
              h6(paste0('Proximity to Stadium (in mins): ', z$proximity_to_stadium)),
              h6(paste0('Phone Number: ', z$phone)),
              h6(a("Website", href= z$website)),
              hr(),
              p(
                style = 'color:gold;',
                paste0(
                  'Courtesy of the Belgium National Football Team: ',
                  'The Belgium Team has partnered with this hotel to offer a ',
                  'complimentary shuttle service so you can travel to and from ',
                  'the stadium in style!'
                )
              )
            )
          )
        )
      )
    }
  )
  
  # _hotel map----
  output$hotelMap = renderLeaflet(
    {
      z = dbGetQuery(
        con,
        paste0(
          'SELECT * FROM hotels JOIN locations USING (locn_id) ',
          'WHERE locn_id = \'', 
          ifelse(as.numeric(input$cityOpt) == 1, ifelse(wc$hd == 1, 'fox_h1', 'fox_h2'), ifelse(wc$hd == 3, 'mia_h14', 'mia_h15')), '\';'
        )
      )
      leaflet(
        data = z
      ) |> 
        addProviderTiles(providers$CartoDB.Positron) |> 
        addAwesomeMarkers(
          lat = c(42.09103, 25.95854)[as.numeric(input$cityOpt)],
          lng = c(-71.26435, -80.23966)[as.numeric(input$cityOpt)],
          popup = c('Boston Stadium', 'Miami Stadium')[as.numeric(input$cityOpt)],
          icon = awesomeIcons(
            markerColor = 'blue',
            icon = 'star'
          )
        ) |> 
        addAwesomeMarkers(
          lat = ~lat,
          lng = ~lng,
          popup = ~hotel_name,
          icon = awesomeIcons(
            markerColor = 'orange',
            icon = 'circle'
          )
        ) |> 
        setView(
          lat = c(42.09103, 25.95854)[as.numeric(input$cityOpt)],
          lng = c(-71.26435, -80.23966)[as.numeric(input$cityOpt)],
          zoom = ifelse(as.numeric(input$cityOpt) == 1, 15, 11)
        )
    }
  )
  
  # Submit actions for each modal
  observeEvent(input$submitStarRating, {
    removeModal()
    showNotification(paste("Star Rating set to", input$starRating, "stars"))
  })
  
  observeEvent(input$submitCheckinCheckout, {
    removeModal()
    showNotification(paste("Check-in Time:", input$checkinTime, "Check-out Time:", input$checkoutTime))
  })
  
  observeEvent(input$submitPrice, {
    removeModal()
    showNotification(paste("Price Range set from $", input$minPrice, "to $", input$maxPrice))
  })
  
  observeEvent(input$submitCommute, {
    removeModal()
    showNotification(paste("Commute Time set to", input$commuteTime, "minutes"))
  })
  
  observeEvent(input$submitBreakfast, {
    removeModal()
    showNotification(paste("Breakfast option set to", paste(input$breakfastOptions, collapse = ", ")))
  })
  
  # >>>>>>>>>>>>>>>>>>>>>----
  # ui dining----
  output$uiDining = renderUI(
    {
      div(
        align = 'center',
        div(
          style = 'padding:10px 25% 0 25%;',
          radioGroupButtons(
            inputId = 'restCostOpt',
            label = NULL,
            choices = c("Any range" = "%", '$', '$$', '$$$'),
            selected = "%",
            individual = TRUE,
            justified = TRUE,
            checkIcon = list(
              yes = tags$i(
                class = 'fa fa-circle', 
                style = 'color: red'
              ),
              no = tags$i(
                class = 'fa fa-circle-o', 
                style = 'color: red'
              )
            )
          ),
          radioGroupButtons(
            inputId = 'restCuisOpt',
            label = NULL,
            choices = c("I am not picky" = "%", 'Italian', 'Seafood', 'American', 'Cafe', 'Caribbean'),
            selected = "%",
            individual = TRUE,
            justified = TRUE,
            checkIcon = list(
              yes = tags$i(
                class = 'fa fa-circle', 
                style = 'color: steelblue'
              ),
              no = tags$i(
                class = 'fa fa-circle-o', 
                style = 'color: steelblue'
              )
            )
          ),
          radioGroupButtons(
            inputId = 'beerOpt',
            choices = c('Has Good Beer!' = 1, 'Indifferent to beer' = 2),
            selected = 2,
            individual = TRUE,
            justified = TRUE,
            size = 'sm',
            checkIcon = list(
              yes = icon('wine-glass'), 
              no = icon('wine-glass-empty')
            )
          ),
          actionBttn(
            inputId = 'submitRest',
            label = 'Find Restaurants',
            style = 'simple',
            color = 'danger',
            size = 'sm',
            icon = icon('search')
          )
        ),
        uiOutput('uiRestResults'), uiOutput('uiDisclaimer')
      )
    }
  )
  
  # _event submit rest----
  observeEvent(input$submitRest, {wc$re = 1})
  
  # _ui rest results----
  output$uiRestResults = renderUI(
    if (wc$re == 1) {
      z = dbGetQuery(
        con, 
        paste0(
          'SELECT * FROM restaurants ',
          'WHERE price_range ILIKE \'', input$restCostOpt, '\' ',
          'AND rest_type ILIKE \'', input$restCuisOpt, '\' ',
          'AND locn_id LIKE \'', switch(as.numeric(input$cityOpt), 'f%', 'm%'), '\' ',
          'AND has_beer = \'', switch(as.numeric(input$beerOpt), 'True', 'False'), '\' ',
          'ORDER BY user_rating DESC;'
        )
      )
      n = nrow(z)
      if (n > 0) {
        div(
          style = 'padding:10px 0 0 0;',
          fluidRow(
            column(
              width = 4,
              leafletOutput('restMap')
            ),
            column(
              width = 8,
              lapply(
                1:n,
                function(i) {
                  div(
                    style = paste0(
                      'padding:3px; margin:3px 0 3px 0; ',
                      'border:solid white 2px; border-radius:10px; ',
                      'min-height:100px; ',
                      'background-color:rgba(50,50,50,0.8);'
                    ),
                    fluidRow(
                      column(1, h6(style = "color:Orange",icon('location-dot'), i)),
                      column(3, h6(style = "color:Red", z$rest_name[i])),
                      column(3, h6(z$description[i])),
                      column(2, h6(style = "color:Gold", icon('star'), paste0(z$user_rating[i]), br(), paste0(' (', z$no_ratings[i], ' reviews)'))),
                      column(1, tags$a(href = z$website[i], target = '_blank', img(src = 'link.png', width = '30px'))),
                      column(2, h6(z$phone[i]))
                    )
                  )
                }
              )
            )
          )
        )
      } else {
        h4('No results. Search again.')
      }
    }
  )
  
  # _rest map----
  output$restMap = renderLeaflet(
    {
      z = dbGetQuery(
        con, 
        paste0(
          'SELECT * FROM restaurants JOIN locations USING(locn_id)',
          'WHERE price_range ILIKE \'', input$restCostOpt, '\' ',
          'AND rest_type ILIKE \'', input$restCuisOpt, '\' ',
          'AND locn_id LIKE \'', switch(as.numeric(input$cityOpt), 'f%', 'm%'), '\' ',
          'AND has_beer = \'', switch(as.numeric(input$beerOpt), 'True', 'False'), '\' ',
          'ORDER BY user_rating DESC;'
        )
      )
      leaflet(
        data = z
      ) |> 
        addProviderTiles(providers$CartoDB.Positron) |> 
        addAwesomeMarkers(
          lat = c(42.09107, 25.95881)[as.numeric(input$cityOpt)],
          lng = c(-71.26392, -80.23783)[as.numeric(input$cityOpt)],
          popup = c('Boston Stadium', 'Miami Stadium')[as.numeric(input$cityOpt)],
          icon = awesomeIcons(
            markerColor = 'blue',
            icon = 'star'
          )
        ) |> 
        addAwesomeMarkers(
          lat = ~lat,
          lng = ~lng,
          popup = ~rest_name,
          icon = awesomeIcons(
            markerColor = 'orange',
            text = 1:nrow(z)
          )
        ) |> 
        setView(
          lat = c(42.09107, 25.95881)[as.numeric(input$cityOpt)],
          lng = c(-71.26392, -80.23783)[as.numeric(input$cityOpt)],
          zoom = 15
        )
    }
  )
  
  # >>>>>>>>>>>>>>>>>>>>>----
  # ui exploring----
  output$uiExploring = renderUI(
    {
      div(
        align = 'center',
        div(
          style = 'padding:10px 25% 0 25%;',
          radioGroupButtons(
            inputId = 'explOpt',
            label = NULL,
            choices = c('Points of Interest' = 1, 'Short Trips' = 2),
            selected = character(0),
            individual = TRUE,
            justified = TRUE,
            checkIcon = list(
              yes = tags$i(
                class = 'fa fa-circle', 
                style = 'color: green'
              ),
              no = tags$i(
                class = 'fa fa-circle-o', 
                style = 'color: green'
              )
            )
          ),
          actionBttn(
            inputId = 'submitExpl',
            label = 'Find Places',
            style = 'simple',
            color = 'primary',
            size = 'sm',
            icon = icon('search')
          )
        ),
        uiOutput('uiExplResults')
      )
    }
  )
  
  # _event submit expl----
  observeEvent(input$submitExpl, {wc$ex = 1})
  
  # _ui expl results----
  
  output$uiExplResults = renderUI(
    if (wc$ex == 1) {
      c = as.numeric(input$cityOpt)
      x = as.numeric(input$explOpt)
      {
        div(
          style = 'padding:10px 0 0 0;',
          fluidRow(
            column(
              width = 4,
              leafletOutput('explMap')
            )
                  
                )
                
              )
      }
    }
    else if (wc$ex == 2) {
      c = as.numeric(input$cityOpt)
      x = as.numeric(input$explOpt)
      {
        div(
          style = 'padding:10px 0 0 0;',
          fluidRow(
            column(
              width = 4,
              leafletOutput('explMap')
            ),
            column(
              width = 8,
              div(
                style = paste0(
                  'padding:10px; ',
                  'background-color:rgba(0,0,0,0.7); ',
                  'border-radius:10px;'
                ),
                h3(
                  style = 'color:gold;',
                  switch(x, wc$xd$poi_name, wc$xd$destination_name)
                ),
                fluidRow(
                  column(
                    width = 6,
                    img(
                      src = paste0('expl/', wc$xd$locn_id, switch(x, '.png', '.jpg')),
                      width = '100%'
                    )
                  ),
                  column(
                    width = 6,
                    h4(style = 'color:white; text-align:left;', wc$xd$description), hr(),
                    switch(x, (h5(style = 'color:Gold; font-size:22px; text-align:left;', paste0('★', wc$xd$user_rating, ' (', wc$xd$no_ratings, ' reviews)')     )), ''),
                    br(),
                    h4(style = "text-align:left;", paste0('Proximity to stadium: ', switch(x, wc$xd$proximity_to_stadium, wc$xd$time), ' minutes')),
                    br(),
                    switch(x, '', (h4(style = "text-align:left;", paste0('Proximity to stadium: ', wc$xd$distance, ' miles')))),
                    h4(style = "text-align:left;", switch(x, a("Website", href= wc$xd$website), ''))
                  ),
                  
                )
                
              )
            )
          )
        )
      }
    }
  )
  
  # _expl map----
  output$explMap = renderLeaflet(
    {
      c = as.numeric(input$cityOpt)
      x = as.numeric(input$explOpt)
      z = dbGetQuery(
        con, 
        paste0(
          'SELECT * FROM ', switch(x, 'poi ', 'shorttrips '),
          'JOIN locations USING (locn_id) ',
          'WHERE locn_id LIKE \'', switch(c, 'f%', 'm%'), '\' ',
          'ORDER BY ', switch(x, '8', '5'), ';'
        )
      )
      leaflet(
        data = z
      ) |> 
        addProviderTiles(providers$CartoDB.Positron) |> 
        addAwesomeMarkers(
          lat = c(42.09107, 25.95881)[c],
          lng = c(-71.26392, -80.23783)[c],
          popup = c('Boston Stadium', 'Miami Stadium')[c],
          icon = awesomeIcons(
            markerColor = 'blue',
            icon = 'star'
          )
        ) |> 
        addAwesomeMarkers(
          lat = ~lat,
          lng = ~lng,
          popup = ~switch(x, poi_name, destination_name),
          icon = awesomeIcons(
            markerColor = 'orange',
            text = 1:nrow(z)
          )
        ) |> 
        setView(
          lat = c(42.09107, 25.95881)[c],
          lng = c(-71.26392, -80.23783)[c],
          zoom = switch(x, 11, 7)
        )
    }
  )
  
  # _event expl map marker click----
  observeEvent(
    input$explMap_marker_click,
    {
      x = as.numeric(input$explOpt)
      z = dbGetQuery(
        con, 
        paste0(
          'SELECT * FROM locations ',
          'JOIN ', switch(x, 'poi ', 'shorttrips '), 
          'USING (locn_id) ',
          'WHERE ', 
          'lat = ', input$explMap_marker_click$lat,
          ' AND lng = ', input$explMap_marker_click$lng, ';'
        )
      )
      refrExplMap(z)
      wc$xd = z
      wc$ex = 2
    }
  )
  
  # _refr map function----
  refrExplMap = function(z) {
    leafletProxy(mapId = 'explMap') |> 
      setView(
        lat = z$lat,
        lng = z$lng,
        zoom = 14
      )
  }
  
  # >>>>>>>>>>>>>>>>>>>>>----
  # ui donate----
  output$uiDonate = renderUI(
    {
      div(
        h3(style = 'color:gold;','Support your favorite Belgian player by donating and get a chance to win merchandise!*'),
        align = 'center',
        div(
          style = 'padding:1px 1% 0 1%;',
          fluidRow(
            column(
              width = 4,
              style = 'padding:50px 0 0 0;',
              img(
                src = 'support.jpg',
                width = '100%'
              )
            ),
            column(
              width = 6,
              uiOutput('uiDonateChart')
            ),
            column(
              width = 2,
              lapply(
                1:3,
                function(i) {
                  div(
                    style = 'padding:10px 0 10px 0;',
                    align = 'center',
                    img(
                      src = paste0('prize', i, '.png'),
                      height = '150px'
                    )
                  )
                }
              )
            )
          ),
          div(
            style = 'position:fixed; left: 2%; bottom:20px;',
            actionBttn(
              inputId = 'donate_popup',
              label = "--   Donate",
              style = 'jelly',
              color = 'warning',
              size = 'md',
              icon = icon('heart')
            )
          ),
          div( 
            style = 'position:fixed; left: 38%; bottom:10px; font-size: 16px;',
            "*All donations are transfered to RBFA's 'Because We Care' Fund",
               br(),
              "For more information, please read",
              a("here", href="https://www.rbfa.be/en/participate/because-we-care-conferences/because-we-care-conference-2-14122023")
          ),  
          )
        )
    }
  )
  
  # _ui donate chart----
  output$uiDonateChart = renderUI(
    {
      don = dbGetQuery(
        con, "SELECT player_id, player_name, donation_amount 
                FROM players 
               WHERE player_name IN ('Kevin De Bruyne', 'Romelu Lukaku', 'Jeremy Doku')
               ORDER BY player_name DESC;"
      )
      
      div(
        align = 'left',
        style = paste0(
          'padding:50px 0 0 0;'
        ),
        div(
          style = paste0(
            'border-left:solid yellow 3px; ',
            'border-bottom:solid yellow 3px; ',
            'border-right:dashed yellow 3px;'
          ),
          lapply(
            1:3,
            function(i) {
              div(
                style = 'padding:40px 0 40px 0;',
                tags$span(style = 'color:#FCC200; font-size:18px;', switch(i, 'Romelu Lukaku - win autographed jersey' , 
                                                                           'Kevin De Bruyne - win autographed photo with Jean Claude Van Damme', 
                                                                           'Jeremy Doku - win rare trading card')),
                progressBar(
                  id = paste0('bar', i),
                  value = don$donation_amount[i],
                  total = 10000,
                  title = NULL,
                  status = 'warning',
                  size = 'lg'
                )
              )
            }
          )
        )
      )
    }
  )
  
  
  # _event donate amount----
  observeEvent(
    input$donate_popup, 
    {
      showModal(
        modalDialog(
          h3(paste0('Donate to win Prizes!')),
          fluidRow(
            column(
              width = 6,
              textInput("donateAmount", "Amount to donate", "10")
            ),
            column(
              width = 6,
              pickerInput(
                inputId = 'donateCat',
                label = 'Choose player to support',
                choices = c('Romelu Lukaku' = 1, 'Kevin De Bruyne' = 2, 'Jeremy Doku' = 3),
                selected = 1
              )
            )
          ),
          footer = tagList(
            actionButton('submitDonation', 'Donate Now'),
            modalButton('Cancel')
          )
        )
      )
    }
  )
  
  # _event submit donation----
  observeEvent(
    input$submitDonation,
    {
      x = dbGetQuery(
        con, "SELECT player_id, player_name, donation_amount 
                FROM players 
               WHERE player_name IN ('Romelu Lukaku', 'Kevin De Bruyne', 'Jeremy Doku')
               ORDER BY player_name DESC;"
      )
      
      removeModal()
      sendSweetAlert(
        title = 'THANK YOU!',
        text = paste0('Donated ', input$donateAmount, " dollars to support ", x$player_name[as.integer(input$donateCat)]),
        type = 'success'
      )
      stmt <- paste0('UPDATE players
                  SET donation_amount =',
                  (x$donation_amount[as.integer(input$donateCat)]+as.integer(input$donateAmount)),
                  "WHERE player_name = '", x$player_name[as.integer(input$donateCat)] ,"';")
      dbExecute(con, stmt)
      
      #refresh the Donate chart
      output$uiDonateChart = renderUI(
        {
          don = dbGetQuery(
            con, "SELECT player_id, player_name, donation_amount 
                FROM players 
               WHERE player_name IN ('Kevin De Bruyne', 'Romelu Lukaku', 'Jeremy Doku')
               ORDER BY player_name DESC;"
          )
          
          div(
            align = 'left',
            style = paste0(
              'padding:50px 0 0 0;'
            ),
            div(
              style = paste0(
                'border-left:solid yellow 3px; ',
                'border-bottom:solid yellow 3px; ',
                'border-right:dashed yellow 3px;'
              ),
              lapply(
                1:3,
                function(i) {
                  div(
                    style = 'padding:40px 0 40px 0;',
                    tags$span(style = 'color:#FCC200; font-size:18px;', switch(i, 'Romelu Lukaku - win autographed jersey' , 
                                                                               'Kevin De Bruyne - win autographed photo with Jean Claude Van Damme', 
                                                                               'Jeremy Doku - win rare trading card')),
                    progressBar(
                      id = paste0('bar', i),
                      value = don$donation_amount[i],
                      total = 10000,
                      title = NULL,
                      status = 'warning',
                      size = 'lg'
                    )
                  )
                }
              )
            )
          )
        }
      )
      
    }
  )
  
  # >>>>>>>>>>>>>>>>>>>>>----
  # ui about----
  output$uiAbout = renderUI(
    {
      div(
        style = 'padding:10px 5% 0 5%;',
        div(
          align = 'center',
          h3(
            style = 'color:Gold;',
            'Our Team'
          ),
          hr(),
          # _teammate images----
          div(
            style = 'padding:0 5% 0 5%;',
            fluidRow(
              lapply(
                1:5,
                function(i) {
                  column(
                    width = 2,
                    offset = 1 * (i == 1),
                    align = 'center',
                    tags$button(
                      id = paste0('mate', i),
                      class = 'btn action-button',
                      style = 'background-color:rgba(0,0,0,0); padding:0; margin:0;',
                      img(
                        src = paste0('member', i, '.jpg'),
                        width = '100%',
                        style = 'border-radius:10px;'
                      )
                    ),
                    h6(
                      style = 'color:white; margin:20px 0 5px 0;',
                      teammate$first[i]
                    ),
                    h6(
                      style = 'color:white; margin:0;',
                      teammate$last[i]
                    )
                  )
                }
              )
            ),
            uiOutput('uiMate')
          )
        )
      )
    }
  )
  
  # # _ui mate----
  # output$uiMate = renderUI(
  #   if (wc$tm > 0) {
  #     div(
  #       style = paste0(
  #         'padding:5px 5px 5px 5px; ',
  #         'margin-top:15px; ',
  #         'background-color:rgba(0,0,0,0.8); ',
  #         'border-radius:10px;'
  #       ),
  #       h4(
  #         style = 'color:white;',
  #         paste(teammate$first[wc$tm], teammate$last[wc$tm], '\'s Bio')
  #       ),
  #       p(
  #         style = 'color:white; text-align:left;',
  #         paste(
  #           teammate$info[wc$tm],
  #           teammate$info[wc$tm],
  #           teammate$info[wc$tm]
  #         )
  #       )
  #     )
  #   }
  # )
  # 
  # # _events mate----
  # observeEvent(input$mate1, {wc$tm = 1})
  # observeEvent(input$mate2, {wc$tm = 2})
  # observeEvent(input$mate3, {wc$tm = 3})
  # observeEvent(input$mate4, {wc$tm = 4})
  # observeEvent(input$mate5, {wc$tm = 5})
        
  # >>>>>>>>>>>>>>>>>>>>>----
  # ui footer----
  output$uiFooter = renderUI(
    {
      div(
        style = 'position:fixed; bottom:20px;',
        actionBttn(
          inputId = 'donate',
          label = NULL,
          style = 'jelly',
          color = 'warning',
          size = 'md',
          icon = icon('heart')
        )

      )
    }
  )
  
  
  # ui drink disclaimer----
  output$uiDisclaimer = renderUI(
    {
      div(
        style = 'position:fixed; bottom:20px; left:700px; font-size:16px',
        if (input$beerOpt==1){'*Disclaimer: Team 7 does not condone excessive consumption of alcohol. Please drink responsibly!*'}
      )
    }
  )
  
}
