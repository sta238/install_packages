library(shiny)


ae_nums <- c("1", "2", "3", "4", "5")
ae_sltns_nums <- c("1", "2", "3", "4")

ae_links <- paste0(
  "https://r.datatools.utoronto.ca/hub/user-redirect/git-pull?",
  "repo=https%3A%2F%2Fgithub.com%2Fsta238%2Fae",
  ae_nums,
  "&urlpath=shiny%2Fae",
  ae_nums,
  "%2F&branch=main"
)

ae_sltns_links <- paste0(
  "https://r.datatools.utoronto.ca/hub/user-redirect/git-pull?",
  "repo=https%3A%2F%2Fgithub.com%2Fsta238%2Fae",
  ae_sltns_nums,
  "_solutions&urlpath=shiny%2Fae",
  ae_sltns_nums,
  "_solutions%2F&branch=main"
)

server <- function(input, output) {
  output$result <- renderText({
    withProgress(message = 'Checking required packages', value = 0, {
      if (!require(learnr)) {
        incProgress(NULL, detail = "Installing learnr")
        incProgress(install.packages("learnr"), detail = "Installing learnr")
      }
      if (!require(kableExtra)) {
        incProgress(NULL, detail = "Installing kableExtra")
        incProgress(install.packages("kableExtra"), detail = "Installing kableExtra")
      }
      if (!require(patchwork)) {
        incProgress(NULL, detail = "Installing patchwork")
        incProgress(install.packages("patchwork"), detail = "Installing patchwork")
      }
    })
    if (require(learn) & require(kableExtra) & require(patchwork)) {
      "`learnr`, `kableExtra`, and `patchwork` installed."
    }
  })
}

ui <- shinyUI(fluidPage(
  hr(),
  div(em(textOutput('result'))),
  hr(),
  fluidRow(
    column(
      6,
      h2("Analysis Exercises"),
      HTML(
        paste0("<div><ul>",
               paste0("<li><a href='", ae_links, "' target='_blank'>AE", 
                      ae_nums, "</a></li>"),
               "</ul></div>")
      )     
    ),
    column(
      6,
      h2("Solutions"),
      HTML(
        paste0("<div><ul>",
               paste0("<li><a href='", ae_sltns_links, "' target='_blank'>AE", 
                      ae_sltns_nums, "_solutions</a></li>"),
               "</ul></div>")
      )     
    )
  )
))

shinyApp(ui = ui, server = server)
