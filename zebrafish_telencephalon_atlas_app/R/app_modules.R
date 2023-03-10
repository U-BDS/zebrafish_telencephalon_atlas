# app modules
#-----------------------------------------global UI options---------------------------------------------------
options(spinner.type=1,spinner.color="#00651D", spinner.size=2)

#-----------------------------------------other UI variables--------------------------------------------------
# integrated group choices
integrated_groups <- c("All", "age") #all other is just "All"

# footer of saved figs
caption_label <- "Source: Summer Thyme Lab"

# plots available
all_plots <- c("UMAP","FeaturePlot","Violin", "DotPlot")

#-------------------------------------------UI-----------------------------------------------------------------

sh_layout_UI <- function(id, group_choices, plot_choices, cluster_names) {
  ns <- NS(id)
  
  sidebarLayout(
    sidebarPanel(width = 3,
                 checkboxGroupInput(inputId = ns("plots"),
                                    label = "Choose which plot(s) to display",
                                    choices = plot_choices,
                                    selected = c("UMAP","FeaturePlot","Violin"),
                                    inline = TRUE),
                 hr(),
                 conditionalPanel(
                   condition = "input.plots.indexOf('UMAP') > -1",
                   
                   checkboxInput(inputId = ns("umap_label"),
                                 label = "Display UMAP label",
                                 value = TRUE),
                   
                   checkboxInput(inputId = ns("umap_legend"),
                                 label = "Display UMAP legend",
                                 value = FALSE),
                   hr(),
                   ns = ns),
                 
                 conditionalPanel(
                   condition = "input.plots.indexOf('Violin') > -1 || input.plots.indexOf('FeaturePlot') > -1",
                   textInput(inputId = ns("gene"),
                             label = HTML("Violin or FeaturePlot option: <br/> choose a gene"),
                             placeholder = "snap25a") %>%
                     shinyhelper::helper(icon = "info-circle",
                                         colour ="#00651D",
                                         type = "markdown",
                                         content = "Gene_name_help"
                     ),
                   
                   actionButton(inputId = ns("go"),
                                label = "Update gene!",
                                icon("dna")
                   ),
                   hr(),
                   ns = ns),
                 
                 conditionalPanel(
                   condition = "input.plots.indexOf('DotPlot') > -1",
                   
                   fileInput(
                     inputId = ns("upload"),
                     label = HTML("DotPlot option: <br/> upload CSV file of gene names"),
                     multiple = FALSE,
                     accept = ".csv",
                     width = "400px"
                   ) %>%
                     shinyhelper::helper(
                       icon = "info-circle",
                       colour ="#00651D",
                       type = "markdown",
                       content = "csv_file_info"
                     ),
                   
                   checkboxInput(inputId = ns("header"),
                                 label = "Indicate if your file has a header",
                                 value = TRUE),
                   
                   hr(),
                   ns = ns),
                 
                 selectInput(inputId = ns("group"),
                             label = "Choose all or split by age",
                             choices = group_choices,
                             selected = "All",
                             multiple = FALSE),
                 
                 radioButtons(inputId = ns("plot_type"),
                              label = "Output type for downloading plot",
                              choices = c("png","pdf"),
                              selected = "png",
                              inline = TRUE),
                 
                 hr(),
                 
                 # conditional panels based on user choices
                 
                 conditionalPanel(
                   condition = "input.plot_type.indexOf('png') > -1",
                   sliderInput(inputId = ns("png_width"),
                               label = "Width (pixels) for downloading PNG plot",
                               value = 800,
                               min = 400,
                               max = 2000,
                               step = 100,
                               round = TRUE),
                   
                   sliderInput(inputId = ns("png_height"),
                               label = "Height (pixels) for downloading PNG plot",
                               value = 800,
                               min = 400,
                               max = 2000,
                               step = 100,
                               round = TRUE),
                   hr(),
                   ns = ns),
                 
                 conditionalPanel(
                   condition = "input.plot_type.indexOf('pdf') > -1",
                   sliderInput(inputId = ns("pdf_width"),
                               label = "Width (inches) for downloading PDF plot",
                               value = 8,
                               min = 4,
                               max = 20,
                               step = 1,
                               round = TRUE),
                   
                   sliderInput(inputId = ns("pdf_height"),
                               label = "Height (inches) for downloading PDF plot",
                               value = 8,
                               min = 4,
                               max = 20,
                               step = 1,
                               round = TRUE),
                   hr(),
                   ns = ns),
                 
                 conditionalPanel(
                   condition = "input.plots.indexOf('FeaturePlot') > -1",
                   numericInput(inputId = ns("expression"),
                                label = HTML("FeaturePlot option: <br/> set a max scale cutoff"),
                                value = NA,
                                min = 0) %>%
                     shinyhelper::helper(icon = "exclamation-circle",
                                         colour ="#00651D",
                                         type = "markdown",
                                         content = "Featureplot_cutoff_help"
                     ),
                   
                   actionButton(inputId = ns("reset"),
                                label = "Reset scale",
                                icon("redo")
                   ),
                   hr(),
                   ns = ns),
                 
                 conditionalPanel(
                   condition = "input.plots.indexOf('Violin') > -1",
                   
                   checkboxInput(inputId = ns("pt_size"), 
                                 label = "Violin plot option: display single-cells as points", 
                                 value = FALSE),
                   
                   hr(),
                   ns = ns),
                 
                 conditionalPanel(
                   condition = "input.plots.indexOf('Violin') > -1 || input.plots.indexOf('DotPlot') > -1",
                   
                   checkboxGroupInput(inputId = ns("cluster"),
                                      label = "Violin or DotPlot option: choose all or show specific clusters",
                                      choices = cluster_names,
                                      selected = cluster_names),
                   
                   actionButton(inputId = ns("cluster_selection"),
                                label = "Plot selected clusters",
                                icon("check")
                   ) %>%
                     shinyhelper::helper(icon = "info-circle",
                                         colour ="#00651D",
                                         type = "markdown",
                                         content = "Plot_selected_clusters"
                     ),
                   
                   actionButton(inputId = ns("reset_clusters"),
                                label = "Clear all cluster choices",
                                icon("redo")
                   ),
                   
                   actionButton(inputId = ns("select_all_clusters"),
                                label = "Check all cluster choices",
                                icon("check-double")
                   ),
                   hr(),
                   ns = ns),
                 
    ),
    # downloadButton have their own conditional dependent upon output as well
    # to ensure the button doesn't show up when no gene is selected or if an error is shown
    mainPanel(width = 9,
              conditionalPanel(
                condition = "input.plots.indexOf('UMAP') > -1",
                plotOutput(ns("UMAP")) %>% 
                  shinycssloaders::withSpinner(),
                ns = ns),
              conditionalPanel(
                condition = "input.plots.indexOf('FeaturePlot') > -1",
                plotOutput(ns("FeaturePlot")) %>% 
                  shinycssloaders::withSpinner(),
                ns = ns),
              conditionalPanel(
                condition = "output.FeaturePlot && input.plots.indexOf('FeaturePlot') > -1",
                downloadButton(ns("FeaturePlot_downl"), label = "Download FeaturePlot"),
                ns = ns),
              conditionalPanel(
                condition = "input.plots.indexOf('Violin') > -1",
                plotOutput(ns("Violin")) %>% 
                  shinycssloaders::withSpinner(),
                ns = ns),
              conditionalPanel(
                condition = "output.Violin && input.plots.indexOf('Violin') > -1",
                downloadButton(ns("Violin_downl"), label = "Download Violin"),
                ns = ns),
              conditionalPanel(
                condition = "input.plots.indexOf('DotPlot') > -1",
                plotOutput(ns("DotPlot"), height = "95%") %>% # set height for custom height in server
                  shinycssloaders::withSpinner(),
                ns = ns),
              conditionalPanel(
                condition = "output.DotPlot && input.plots.indexOf('DotPlot') > -1",
                downloadButton(ns("DotPlot_downl"), label = "Download DotPlot"),
                ns = ns)
    )
  )
}


#-------------------------------------------SERVER---------------------------------------------------------------------

sh_layout_server <- function(id, dataset, UMAP_label, UMAP_colors, assay = "RNA", group_choices = "All") {
  moduleServer(
    id,
    function(input, output, session) {
      
      # only display group choices for dataset that contains anything beyond one choice (e.g.: integrated data)
      # The element will be shown if the condition evaluates to TRUE and hidden otherwise.
      observe({
        shinyjs::toggle(id = "group", condition = !all((group_choices == "All")))
      })
      
      output$UMAP <- renderPlot({
        if (input$umap_legend == TRUE) {
          DimPlot(object = dataset,
                 reduction = "umap",
                 label = input$umap_label,
                 cols = UMAP_colors,
                 label.size = 5) + ggtitle(label = UMAP_label)
        } else {
          DimPlot(object = dataset,
                  reduction = "umap",
                  label = input$umap_label,
                  cols = UMAP_colors,
                  label.size = 5) + NoLegend() + ggtitle(label = UMAP_label)
        }
      })
      
      #------------------------------------------ cluster selection ---------------------------------------------------------
      
      #NOTE ignoreNULL = F to ensure that when there is no selection at launch, the user only needs to click on Update gene
      update_cluster <- eventReactive(input$cluster_selection, {input$cluster},
                                      ignoreNULL = FALSE)
      
      # option to clear or select all checkboxes from clusters
      
      observeEvent(input$reset_clusters, {
        updateCheckboxGroupInput(session, "cluster",
                                 choices = levels(dataset),
                                 selected = NULL)
      })
      
      observeEvent(input$select_all_clusters, {
        updateCheckboxGroupInput(session, "cluster",
                                 choices = levels(dataset),
                                 selected = levels(dataset))
      })
      #-----------------------------------------------------------------------------------------------------------------------
      
      update_gene <- eventReactive(input$go, {gene_input_check(input$gene,dataset,assay)})
      
      # make plots under reactive to avoid code repetition when saving plots
      
      featureplot <- reactive({
        #change assay as needed for input:
        
        if (input$group == "All") {
          FeaturePlot(object = change_assay(dataset = dataset, assay = assay),
                      features = update_gene(),
                      max.cutoff = input$expression,
                      split.by = NULL)
        } else {
          FeaturePlot(object = change_assay(dataset = dataset, assay = assay),
                      features = update_gene(),
                      max.cutoff = input$expression,
                      split.by = input$group)
        }
      })
      
      output$FeaturePlot <- renderPlot({
        featureplot()
      })
      
      output$FeaturePlot_downl <- downloadHandler(
        filename = function() { paste0(gene_input_check(input$gene,dataset,assay),"_FeaturePlot.", input$plot_type) },
        
        content = function(file) {
          
          height <- ifelse(input$plot_type == "png", input$png_height, input$pdf_height)
          width <- ifelse(input$plot_type == "png", input$png_width, input$pdf_width)
          
          plot_save <- featureplot() + labs(caption = caption_label) + theme(plot.caption = element_text(size=18, face="bold"))
          
          plot_png_pdf(file_name = file, plot = plot_save, height = height, width = width, image_format = input$plot_type)
          
        }
      )
      
      observeEvent(input$reset, {shinyjs::reset("expression")})
      
      violin <- reactive({
        
        #evaluate violin options
        if (input$group != "All") {
          split_group <- input$group
          colors <- col_split
        } else {
          split_group <- NULL
          colors <- NULL
        }
        
        if (input$pt_size == FALSE) {
          size <- 0
        } else {
          size <- NULL # default pt.size
        }
        
        
        VlnPlot(object = dataset, split.by = split_group,
                features = update_gene(), idents = update_cluster(),
                pt.size = size, assay = assay, cols = colors) + NoLegend()
      })
      
      
      output$Violin <- renderPlot({
        violin()
      })
      
      
      output$Violin_downl <- downloadHandler(
        filename = function() { paste0(gene_input_check(input$gene,dataset,assay),"_Violin.", input$plot_type) },
        
        content = function(file) {
          
          height <- ifelse(input$plot_type == "png", input$png_height, input$pdf_height)
          width <- ifelse(input$plot_type == "png", input$png_width, input$pdf_width)
          
          plot_save <- violin() + labs(caption = caption_label) + theme(plot.caption = element_text(size=18, face="bold"))
          
          plot_png_pdf(file_name = file, plot = plot_save, height = height, width = width, image_format = input$plot_type)
        }
      )
      
      doplot <- reactive({
        
        file_upload <- input$upload
        ext <- tools::file_ext(file_upload$datapath)
        
        req(file_upload)
        validate(need(ext == "csv", "Please upload a csv file"))
        
        # validate entries / checks input csv
        user_query_upload <- process_upload(input_path = file_upload$datapath,
                                            header = input$header,
                                            dataset = dataset,
                                            assay = assay)
        
        #evaluate violin options
        if (input$group != "All") {
          split_group <- input$group
          colors <- col_split
        } else {
          split_group <- NULL
          colors <- colfunc(2)
        }
        
        DotPlot_ordered(dataset = dataset, split_type = split_group,
                        features = user_query_upload, idents = update_cluster(),
                        colors = colors, assay = assay)
      })
      
      height_dotplot <- reactive({ifelse(input$group == "All", 1000, 1600)})
      
      observe({
        output$DotPlot <- renderPlot({
          doplot()
        }, height = height_dotplot())
      })
      
      output$DotPlot_downl <- downloadHandler(
        filename = function() { paste0("DotPlot.", input$plot_type) },
        
        content = function(file) {
          
          height <- ifelse(input$plot_type == "png", input$png_height, input$pdf_height)
          width <- ifelse(input$plot_type == "png", input$png_width, input$pdf_width)
          
          plot_save <- doplot() + labs(caption = caption_label) + theme(plot.caption = element_text(size=18, face="bold"))
          
          plot_png_pdf(file_name = file, plot = plot_save, height = height, width = width, image_format = input$plot_type)
        }
      )
    }
  )
}
