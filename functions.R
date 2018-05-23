#--------------------------------------------
# Function plot labels
#--------------------------------------------



f_plot_label <- function(QRcode,textSize,marg1,prst_s1,line_prst_s1,prst_s2,prst_s3,prst_s4) {
  par(mar=c(marg1,marg1,marg1,marg1))
  image(qrencode_raster(QRcode), 
        asp=1, col=c("white", "black"), axes=FALSE, 
        xlab="", ylab="",bty="l")
  if (!missing(prst_s1)) { 
    mtext(prst_s1,side=1,line = line_prst_s1,cex=textSize) 
  }
  if (!missing(prst_s2)) { 
    mtext(prst_s2,side=2,line = 1,cex=textSize) 
  }
  if (!missing(prst_s3)) { 
    mtext(prst_s3,side=3,line = 1,cex=textSize) 
  }
  if (!missing(prst_s4)) { 
    mtext(prst_s4,side=4,line = 1,cex=textSize) 
  }
  box(which = "outer", lty = "solid")
}

# ## function testing
# library(dplyr)
# library(qrencoder)
# library(jsonlite)
# source("dataIO.R")
# inndata_selected <- inndata#inndata_selected()
# inndata_to_QR <- inndata_selected %>% select(materialSampleID)
# QRcode <- toJSON(inndata_to_QR[1,]) # data to QR code
# textSize <- 1 #input$textsize
# marg1 <- 4
# marg2 <- 4
# marg3 <- 4
# marg4 <- 4
# prst_s1 <- paste("recordNumber:",inndata_selected$recordNumber[1])
# prst_s2 <- paste("collectionCode:",inndata_selected$collectionCode[1])
# prst_s3 <- paste("scienticName:",inndata_selected$scientificName[1])
# prst_s4 <- paste("catalogNumber:",inndata_selected$catalogNumber[1])
# prst_s4 <- paste("")
# f_plot_label(QRcode,textSize,marg1,prst_s1,line_prst_s1)#,prst_s2,prst_s3,prst_s4)
# f_plot_label(QRcode,textSize,marg1,prst_s1,line_prst_s1,prst_s2)#,prst_s3,prst_s4)
# f_plot_label(QRcode,textSize,marg1,prst_s1,line_prst_s1,prst_s2,prst_s3,prst_s4)
# #
# # save plot to jpg
# ggg <- tempdir()
# jpeg(filename = paste0(ggg,"/tmp.jpeg"),
#      width = 75, height = 75, units = "mm", pointsize = 12,
#      quality = 75,res=150,
#      bg = "white")
# f_plot_label(QRcode,textSize,prst_s1)
# dev.off()




