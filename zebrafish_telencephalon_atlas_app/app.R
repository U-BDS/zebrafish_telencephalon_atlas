# deploy app

source("./global.R")

#----------------------- app -------------------------------
message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: Initializing UI."))
ui <- function(){
  
  bootstrapPage("",
                useShinyjs(),
                navbarPage(title = "Maturing Zebrafish Telencephalon Atlas", #TODO: check-in on any name changes
                           theme = bslib::bs_theme(version = 5, bootswatch = "cosmo", primary = "#00651D"),
                           home_description,
                           tabPanel(title = "Integrated Telencephalon",
                                    sh_layout_UI(id = "integrated",
                                                 group_choices = integrated_groups,
                                                 plot_choices = all_plots,
                                                 cluster_names = cluster_names_forebrain_integrated
                                    )
                           ),
                           tabPanel(title = "6 dpf Telencephalon",
                                    sh_layout_UI(id = "dpf6",
                                                 group_choices = "All",
                                                 plot_choices = all_plots,
                                                 cluster_names = cluster_names_dpf6
                                    )
                           ),
                           tabPanel(title = "15 dpf Telencephalon",
                                    sh_layout_UI(id = "dpf15",
                                                 group_choices = "All",
                                                 plot_choices = all_plots,
                                                 cluster_names = cluster_names_dpf15
                                    )
                           ),
                           tabPanel(title = "Adult Telencephalon",
                                    sh_layout_UI(id = "adult",
                                                 group_choices = "All",
                                                 plot_choices = all_plots,
                                                 cluster_names = cluster_names_adult
                                    )
                           )
                ),
                tags$style(HTML(".irs--shiny .irs-bar {
                                background: #00651D;
                                border-top: 1px solid #00651D;
                                border-bottom: 1px solid #00651D;
                                }
                                .irs--shiny .irs-to, .irs--shiny .irs-from {
                                background-color: #00651D;
                                }
                                .irs--shiny .irs-single {
                                background: #00651D;
                                }")),
                tags$head(
                  tags$style(HTML(".shiny-output-error-validation {
                                  color: black;}"))))
}
message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: UI Initialized."))

message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: Initializing Session."))
# Reminder: objects inside server function are instantiated per session...
server <- function(input, output) {
  
  shinyhelper::observe_helpers(help_dir = "helpfiles", withMathJax = FALSE)
  
  sh_layout_server(id = "integrated", 
                   dataset = forebrain_integrated, 
                   UMAP_label = "Integrated Maturing Zebrafish Telencephalon",
                   UMAP_colors = colors,
                   group_choices = integrated_groups)
  
  sh_layout_server(id = "dpf6", 
                   dataset = dpf6, 
                   UMAP_label = "6 dpf Zebrafish Telencephalon",
                   UMAP_colors = colors_dpf6,
                   group_choices = "All")
  
  sh_layout_server(id = "dpf15", 
                   dataset = dpf15, 
                   UMAP_label = "15 dpf Zebrafish Telencephalon",
                   UMAP_colors = colors_df15,
                   group_choices = "All")
  
  sh_layout_server( id = "adult", 
                    dataset = adult, 
                    UMAP_label = "Adult Zebrafish Telencephalon",
                    UMAP_colors = colors_adult,
                    group_choices = "All")

}
message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: Session Initialized."))

shinyApp(ui = ui, server = server)
