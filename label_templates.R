#--------------------------------------------
# Label templates 
#--------------------------------------------

# inndata_selected <- inndata_selected()
# QRcode <- toJSON(inndata_selected[1,]) # data to QR code
# printString_l1 <- paste("occurrenceID:",inndata_selected$occurrenceID[1])
# printString_l2 <- paste("recordNumber:",inndata_selected$recordNumber[1])
# textSize <- input$textsize
# 
# QRcode <- toJSON(inndata[1,]) # data to QR code
# textSize <- input$textsize
#QR <- inndata_selected()
#QR <- toJSON(inndata[1,]) # data to QR code
f_QR_only <- function(QR) {
  par(mar=c(4,4,4,4))
  image(qrencode_raster(QR), 
        asp=1, col=c("white", "black"), axes=FALSE, 
        xlab="", ylab="",bty="l")
  box(which = "outer", lty = "solid")
}

f_label <- function(QR,str_1) {
  par(mar=c(4,4,4,4))
  image(qrencode_raster(QR), 
        asp=1, col=c("white", "black"), axes=FALSE, 
        xlab="", ylab="",bty="l")
  box(which = "outer", lty = "solid")
  mtext(str_1,side=1,line = 1,cex=input$textsize)
}

f_with_text <- function() {
  inndata_selected <- inndata_selected()
  QRcode <- toJSON(inndata_selected[1,]) # data to QR code
  textSize <- input$textsize
  printString_s1 <- paste("occurrenceID:",inndata_selected$occurrenceID[1])
  printString_s2 <- paste("recordNumber:",inndata_selected$recordNumber[1])
  par(mar=c(4,4,4,4))
  image(qrencode_raster(QRcode), 
        asp=1, col=c("white", "black"), axes=FALSE, 
        xlab="", ylab="",bty="l")
  mtext(printString_s1,side=1,line = 1,cex=input$textsize)
  mtext(printString_s2,side=2,line = 1,cex=input$textsize)
  box(which = "outer", lty = "solid")
}

