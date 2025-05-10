library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)

server <- function(input, output, session) {
    tpm_data <- read.csv("TPMs_table_100genes.csv")
    
    #we need unique_genes to our 'choosing sidebar'
    unique_genes <- unique(tpm_data$GeneID)
    updateSelectInput(session, "genes", choices = unique_genes)
    
    #extra table that shows row in tpm_data of chosen gene 
    output$gene_data <- renderTable({
      req(input$genes) #stops running until user selects a gene
      subset(tpm_data, GeneID == input$genes)
    })
    
    #gene plot
    output$gene_plot <- renderPlot({
      req(input$genes)
      gene_row <- subset(tpm_data, GeneID == input$genes)
      
      #pivot all cols except GeneID
      gene_long <- gene_row %>%
        pivot_longer(cols = -GeneID, names_to = "Sample", values_to = "TPM")
      
      #barplot - bar for each sample; y axis - TPM  
      ggplot(gene_long, aes(x = Sample, y = TPM, fill = Sample)) +
        geom_bar(stat = "identity")+
        scale_fill_brewer(palette = "Blues")+
        labs(
          title = "Expression of gene in TPMs",
          x = "Sample",
          y = "TPM"
        )+
        theme_minimal()
    })
}
