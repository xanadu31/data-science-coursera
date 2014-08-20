library(shiny)
library(UsingR)
library(ggplot2)


fit<-lm(child~parent, data=galton)


child.height<-function(father.height,mother.height, child.gender){
  if(child.gender == "male"){
    as.vector(predict(fit,data.frame(parent=mean(c(father.height,mother.height)))))
  }else{
    as.vector(predict(fit,data.frame(parent=mean(c(father.height,mother.height))))/1.08)
  }
}

shinyServer(
  function(input, output) {
    output$father.height <- renderText(paste("Father' height:", {input$father.height}, "inch"))
    output$mother.height <- renderText(paste("Mothers' height:", {input$mother.height}, "inch"))
    output$child.height <- renderText(paste("Childs' height:", round(child.height(input$father.height,input$father.height, input$child.gender)),"inch"))
    
    output$plot <- renderPlot({
      p<-ggplot(galton,aes(x=parent,y=child))+
        geom_point(alpha = I(1/10))+
        geom_smooth(method="lm")

        p<-p+geom_point(
          data=data.frame(predictx=mean(c(input$father.height,input$mother.height)),predicty=child.height(input$father.height,input$father.height, input$child.gender)),
          aes(predictx,predicty),colour="red",size=10
        )

      print(p)
      
    })
  }
)