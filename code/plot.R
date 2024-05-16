
library(openxlsx)
library(readxl)
library(ggplot2)
library(gridExtra)  

####Figure1####
#figure1a
prsoverall <-read_excel("E:/data/Dataset.xlsx",sheet="figure1a")
prsoverall2<-prsoverall[prsoverall$X_GROUP %in% c (0,2,3,5),]

prsoverall2$group[prsoverall2$X_GROUP==3]<-"Low genetic risk,0-2 factors"
prsoverall2$group[prsoverall2$X_GROUP==5]<-"Low genetic risk,4 factors"
prsoverall2$group[prsoverall2$X_GROUP==0]<-"High genetic risk,0-2 factors"
prsoverall2$group[prsoverall2$X_GROUP==2]<-"High genetic risk,4 factors"

plot1a<-ggplot(prsoverall2, aes(x=X_XCONT1, y=X_PREDICTED)) +
  geom_line(aes(colour=group,linetype=group),linewidth=1) +
  geom_ribbon(aes(fill=group,x=X_XCONT1,ymin=X_LCLM,ymax=X_UCLM),alpha=0.2)+
  scale_colour_manual(values=c("#B2182B","#2166AC","grey","black"))+
  scale_linetype_manual(values=c("solid","dashed","longdash","solid"))+
  scale_fill_manual(values=c("#B2182B","#2166AC","grey","black"))+
  labs(title="", x="Follow-up time,years", y="Estimated change in cognitive score")+
  theme_bw() + 
  theme(text=element_text(size =10),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        axis.line.x = element_line(size=0.5,color = "black"), 
        axis.line.y = element_line(size=0.5,color = "black"),  
        legend.text = element_text(size = 10),
        legend.position ="top",
        legend.key.height = unit(15, "pt"),
        legend.key.width = unit(25, "pt"),
        legend.background = element_rect(fill = NA,size=5),
        legend.title = element_text(color=NA),
        panel.border = element_blank(), 
        axis.line=element_line(size=0.5, colour="black"),
        panel.grid.minor.x=element_blank(),
        panel.grid.minor.y=element_blank(),
        panel.grid.major.x = element_line(color = "#FFFFFF", size=0.1),
        panel.grid.major.y = element_line(color = "#FFFFFF", size=0.1),
        plot.margin=unit(rep(1,4),'lines')) + 
  geom_hline(aes(yintercept=0), colour="black", linetype="dashed") +
  guides(colour=guide_legend(nrow=2))+
  ggtitle("a participants with genetic information") +
  scale_x_continuous(breaks=seq(0,20,2),
                     limits=c(0,20),expand=c(0,0)) + 
  scale_y_continuous(breaks=seq(-5,1,1),
                     limits=c(-5,1),expand=c(0,0))

#figure1b,low genetic risk
low<-read_excel("E:/data/Dataset.xlsx",sheet="figure1b")
lownew<-low[low$X_GROUP=="0"|low$X_GROUP=="2",]
lownew$X_GROUP<-as.factor(lownew$X_GROUP)

plot1b<-ggplot(lownew, aes(x=X_XCONT1, y=X_PREDICTED,group=X_GROUP)) +
  geom_line(aes(colour=X_GROUP,linetype=X_GROUP),size=1) +
  geom_ribbon(aes(ymin=X_LCLM, ymax=X_UCLM,fill=X_GROUP),alpha=0.2)+
  scale_linetype_manual(values=c("solid","dotdash"))+
  scale_fill_manual(values=c("#B2182B","#2166AC"))+
  scale_colour_manual(values=c("#B2182B","#2166AC"))+
  labs(title="", x="Follow-up time,years", y="")+
  theme_bw() + 
  theme(text=element_text(size =10),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        axis.line.x = element_line(size=0.5,color = "black"),       
        axis.line.y = element_line(size=0.5,color = "black"),  
        legend.text = element_text(size = 10),
        legend.position ="top",
        legend.key.height = unit(15, "pt"),
        legend.key.width = unit(25, "pt"),
        legend.background = element_rect(fill = NA,size=5),
        legend.title = element_text(color=NA),
        panel.border = element_blank(), 
        axis.line=element_line(size=0.5, colour="black"),
        panel.grid.minor.x=element_blank(),
        panel.grid.minor.y=element_blank(),
        panel.grid.major.x = element_line(color = "#FFFFFF", size=0.1),
        panel.grid.major.y = element_line(color = "#FFFFFF", size=0.1),
        plot.margin=unit(rep(1,4),'lines')) + 
  geom_hline(aes(yintercept=0), colour="black", linetype="dashed") +
  ggtitle("b low genetic risk") +
  scale_x_continuous(breaks=seq(0,20,2),
                     limits=c(0,20),expand=c(0,0)) + 
  scale_y_continuous(breaks=seq(-5,1,1),
                     limits=c(-5,1),expand=c(0,0))

#figure1c,high genetic
high<-read_excel("E:/Dataset.xlsx",sheet="figure1c")
highnew<-high[high$X_GROUP=="0" |high$X_GROUP=="2",]
highnew$X_GROUP<-as.factor(highnew$X_GROUP)

plot1c<-ggplot(highnew, aes(x=X_XCONT1, y=X_PREDICTED,group=X_GROUP)) +
  geom_line(aes(colour=X_GROUP,linetype=X_GROUP),size=1) +
  geom_ribbon(aes(ymin=X_LCLM, ymax=X_UCLM,fill=X_GROUP),alpha=0.2)+
  scale_linetype_manual(values=c("solid","dotdash"))+
  scale_fill_manual(values=c("#B2182B","#2166AC"))+
  scale_colour_manual(values=c("#B2182B","#2166AC"))+
  labs(title="", x="Follow-up time,years", y="")+
  theme_bw() + 
  theme(text=element_text(size =10),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        axis.line.x = element_line(size=0.5,color = "black"),       
        axis.line.y = element_line(size=0.5,color = "black"),  
        legend.text = element_text(size = 10),
        legend.position ="top",
        legend.key.height = unit(15, "pt"),
        legend.key.width = unit(25, "pt"),
        legend.background = element_rect(fill = NA,size=5),
        legend.title = element_text(color=NA),
        panel.border = element_blank(), 
        axis.line=element_line(size=0.5, colour="black"),
        panel.grid.minor.x=element_blank(),
        panel.grid.minor.y=element_blank(),
        panel.grid.major.x = element_line(color = "#FFFFFF", size=0.1),
        panel.grid.major.y = element_line(color = "#FFFFFF", size=0.1),
        plot.margin=unit(rep(1,4),'lines')) + 
  geom_hline(aes(yintercept=0), colour="black", linetype="dashed") + 
  ggtitle("c high genetic risk") +
  scale_x_continuous(breaks=seq(0,20,2),
                     limits=c(0,20),expand=c(0,0)) + 
  scale_y_continuous(breaks=seq(-5,1,1),
                     limits=c(-5,1),expand=c(0,0))

#output
pdf("E:/result/figure1.pdf",height =6,width =14)
multiplot(p1a,p1b,p1c,cols=3) 
dev.off() 


####Figure2####
sheets <- excel_sheets("E:/Dataset.xlsx")  
all_sheets_data <- list()  
all_sheets_data <- lapply(sheets, function(sheet) {  
  read_excel("E:/Dataset.xlsx", sheet = sheet)  
})  

sheet_names <- c("figure2a", "figure2b", "figure2c", "figure2d","figure2e","figure2f")
plot<-list()

sheet_to_y_label <- list(  
  "figure2a" = "Estimated change in orientation score",  
  "figure2b" = "Estimated change in attention and calculation score",
  "figure2c" = "Estimated change in visual construction score",  
  "figure2d" = "Estimated change in language score",  
  "figure2e" = "Estimated change in naming foods score",   
  "figure2f" = "Estimated change in recall score"  
)  


plots <- lapply(sheet_names, function(sheet) {
  
    data1 <-read_excel("E:/Dataset.xlsx",sheet=sheet)
    
    data2<-data1[data1$X_GROUP %in% c (0,2,3,5),]
    
    data2$group[data2$X_GROUP==3]<-"Low genetic risk,0-2 factors"
    data2$group[data2$X_GROUP==5]<-"Low genetic risk,4 factors"
    data2$group[data2$X_GROUP==0]<-"High genetic risk,0-2 factors"
    data2$group[data2$X_GROUP==2]<-"High genetic risk,4 factors"
    
    y_label<-sheet_to_y_label[[sheet]]
    
    plot<-ggplot(data2, aes(x=X_XCONT1, y=X_PREDICTED)) +
      geom_line(aes(colour=group,linetype=group),linewidth=1) +
      scale_colour_manual(values=c("#B2182B","#2166AC","grey","black"))+
      scale_linetype_manual(values=c("solid","dashed","longdash","solid"))+
      labs(title=paste("Plot for:",sheet), x="", y=y_label)+
      theme_bw() + 
      theme(text=element_text(size =10),
            axis.text.x = element_text(size = 10),
            axis.text.y = element_text(size = 10),
            axis.line.x = element_line(size=0.5,color = "black"), 
            axis.line.y = element_line(size=0.5,color = "black"),  
            legend.text = element_text(size = 10),
            legend.position ="top",
            legend.key.height = unit(15, "pt"),
            legend.key.width = unit(25, "pt"),
            legend.background = element_rect(fill = NA,size=5),
            legend.title = element_text(color=NA),
            panel.border = element_blank(), 
            axis.line=element_line(size=0.5, colour="black"),
            panel.grid.minor.x=element_blank(),
            panel.grid.minor.y=element_blank(),
            panel.grid.major.x = element_line(color = "#FFFFFF", size=0.1),
            panel.grid.major.y = element_line(color = "#FFFFFF", size=0.1),
            plot.margin=unit(rep(1,4),'lines')) + 
      geom_hline(aes(yintercept=0), colour="black", linetype="dashed") +
      guides(colour=guide_legend(nrow=2))+
      scale_x_continuous(breaks=seq(0,20,2),
                         limits=c(0,20),expand=c(0,0)) + 
      scale_y_continuous(breaks=seq(-4,1,1),
                         limits=c(-4,1),expand=c(0,0))
    return(plot)
})

do.call(grid.arrange, c(plots, ncol = 3)) 

