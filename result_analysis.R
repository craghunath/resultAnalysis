library("pdftools")
library("magrittr")
library("stringr")
library("dplyr")

#'p' = physics
#'c' = chemistry
#'m' = mathematics
#'C' = computer science
#'e' = electronics
#'s' = statistics
#'b' = botany
#'z' = zoology
#'B' = bio technology
#'E' = economics
#'P' = pshycology

# ---------------------------------------Part 1 : Execute prior to all ----------------------------------------------
txt <- pdf_text("/path/input_file_17bgs_1sem.pdf")
#-----------------------------------------------
reg <- str_extract_all(string = txt%>%unlist, pattern = "\\d{2}\\w{8}") %>% unlist() %>% gsub(pattern = "\\d{5}$", replacement = "") %>% table() %>% sort(decreasing = T)
month <- sub(pattern = "Exam Month[: ]+", replacement = "", x = str_extract(string = txt[[1]], pattern = "Exam Month[: ]+[A-z]{3,10}"))
year <- sub(pattern = "Exam Year[ ]+", replacement = "", x = str_extract(string = txt[[1]], pattern = "Exam Year[ ]+\\d{4}"))
sems <- sub(pattern = "[ ]+", replacement = "", x = str_extract(string = txt[[1]], pattern = "Sem[ ]+\\d{1}"))

pat <- "Reg(.*?)---"
lt <- unlist(regmatches(txt, gregexpr(pat, txt)))
lt <- lt[grepl( (reg%>%names)[[1]], unlist(lt))] 
# ---------------------------------------Part 1 : Execute prior to all ----------------------------------------------
brk.indx1 <- str_count( sub('Paper Code :','',str_extract(lt[[1]], 'Paper Code :[\\w ]+')), boundary("word") )
brk.indx2 <- gsub('Total Marks: +| +$','',str_extract(lt[[1]], 'Total Marks:[\\w\\* ]+')) %>% str_split(pattern = " +") %>% unlist %>% length()
brk.indx3 <- gsub('I\\.A\\.Marks : +| +$','',str_extract(lt[[1]], 'I\\.A\\.Marks :[\\w\\* ]+')) %>% str_split(pattern = " +") %>% unlist %>% length()
#sbjN in function sbj_dist() will suffice the need and cuts the requirement to alter sbjs for different subjects
brk1 <- brk.indx2 - brk.indx1
brk2 <- brk.indx3 - brk.indx1
# -------------------------------------------------------------------------------------}Part
in1 <- c("Register No\\. |Paper Code :|I\\.A\\.Marks :|Total Marks:|-+", " A ", "  +[A-Z ]+\\!", "CERTIANITY.+\n", "Name +:", " 00 ", "  +$")#( \\* )
ous <- c("", " 00 ", "CERTIANITY", "    ", "      ", " A ", "")
for (i in 1: 1:(in1 %>% length) ) {
    lt <- lapply(lt,gsub,pattern = in1[[i]], replacement = ous[[i]], perl = TRUE)
}

fresh <- str_split(lt,"  +")
ln.tst <- sapply(fresh, length) %>% unique %>% length()
#length of the total entities in the result of single person, only two different lengths are there in the whole result ECO students dont have labs
#-----------subject_codes-------------------------------------------

#-----------1SEM---------------}
sbcd01 <- list(   'p' = c("SP1C1S","SP1P1S"),  'c' = c("SC1C1S","SC1P1S"),  'm' = c("SM1C1S","SM1P1S"),  'C' = c("SC2C1S","SC2P1S"),  'e' = c("SE1C1S","SE1P1S"),  's' = c("SS2C1S","SS2P1S"),  'b' = c("SB1C1S","SB1P1S"),  'z' = c("S22C1S","S22P1S"),  'B' = c("ST1C1S","ST1P1S"),  'E' = c("AE1C1S"),   'P' = c("SP2C1S","SP2P1S") )
#-----------2SEM---------------}	
sbcd02 <- list(   'p' = c("SP1C2S","SP1P2S"),  'c' = c("SC1C2S","SC1P2S"),  'm' = c("SM1C2S","SM1P2S"),  'C' = c("S2CC1S","SC2P2S"),  'e' = c("SE1C2S","SE1P2S"),  's' = c("SS2C2S","SS2P2S"),  'b' = c("SB1C2S","SB1P2S"),  'z' = c("SZ2C2S","SZ2P2S"),  'B' = c("ST1C2S","ST1P2S"),  'E' = c("AE1C2S"),   'P' = c("SP2C2S","SP2P2S") )
#-----------3SEM---------------}
sbcd03 <- list(   'p' = c("SP1C3S","SP1P3S"),  'c' = c("SC3C3S","SC3P3S"),  'm' = c("SM1C3S","SM1P3S"),  'C' = c("SCSC3S","SCSP3S"),  'e' = c("SE1C3S","SE1P3S"),  's' = c("SS2C31","SS2P31"),  'b' = c("SB1C3S","SB1P3S"),  'z' = c("SZ2C3S","SZ2P3S"),  'B' = c("ST1C3S","ST1P3S"),  'E' = c("AE1C3S"),   'P' = c("SP2C3S","SP2P3S") )
#-----------4SEM---------------}
sbcd04 <- list(   'p' = c("SP1C4S","SP1P4S"),  'c' = c("SC3C4S","SC3P4S"),   'm' = c("SM1C4S","SM1P4S"),  'C' = c("SCSC4S","SCSP4S"),  'e' = c("SE1C4S","SE1P4S"), 's' = c("SS2C41","SS2P41"), 'b' = c("SB1C4S","SB1P4S"), 'z' = c("SZ2C4S","SZ2P4S"), 'B' = c("ST1C4S","ST1P4S"), 'E' = c("AE1C4S"), 'P' = c("SP2C4S","SP2P4S") )
#-----------55SEM---------------}
sbcd55 <- list(   'p' = c("SP1C51","SP1P51"), 'c' = c("SC1C51","SC1P51"), 'm' = c("SM1C51","SM1P51"), 'C' = c("SC2C51","SC2P51"), 'e' = c("SE1C51","SE1P51"), 's' = c("SS2C51","SS2P51"), 'b' = c("SB1C51","SB1P51"), 'z' = c("SZZC51","SZZP51"), 'B' = c("ST1C51","ST1P51"), 'E' = c("AE1C51"), 'P' = c("SP2C51","SP2P51") )
#-----------56SEM---------------}
sbcd56 <- list(   'p' = c("SP1C52","SP1P52"), 'c' = c("SC1C52","SC1P52"), 'm' = c("SM1C52","SM1P52"), 'C' = c("SC2C52","SC2P52"), 'e' = c("SE1C52","SE1P52"), 's' = c("SS2C52","SS2P52"), 'b' = c("SB1C52","SB1P52"), 'z' = c("SZZC52","SZZP52"), 'B' = c("ST1C52","ST1P52"), 'E' = c("AE1C52"), 'P' = c("SP2C52","SP2P52") )
#-----------67SEM---------------}
sbcd67 <- list(   'p' = c("SP1C61","SP1P61"), 'c' = c("SC1C61","SC1P61"), 'm' = c("SM1C61","SM1P61"), 'C' = c("SC2C61","SC2P61"), 'e' = c("SE1C61","SE1P61"), 's' = c("SS2C61","SS2P61"), 'b' = c("SB1C61","SB1P61"), 'z' = c("SZZC61","SZZP61"), 'B' = c("ST1C61","ST1P61"), 'E' = c("AE1C61"), 'P' = c("SP2C61","SP2P61") )
#-----------68SEM---------------}
sbcd68 <- list(   'p' = c("SP1C62","SP1P62"), 'c' = c("SC1C62","SC1P62"), 'm' = c("SM1C62","SM1P62"), 'C' = c("SC2C62","SC2P62"), 'e' = c("SE1C62","SE1P62"), 's' = c("SS2C62","SS2P62"), 'b' = c("SB1C62","SB1P62"), 'z' = c("SZZC62","SZZP62"), 'B' = c("ST1C62","ST1P62"), 'E' = c("AE1C62"), 'P' = c("SP2C62","SP2P62") )

#------------------------------------------------------}
#------------------------------------------------------
sbcd <- sbcd01 #switch(EXPR = sems, "Sem1" = sbcd01, "Sem2" = sbcd02, "Sem3" = sbcd03, "Sem4" = sbcd04 )
#------
actul <- function(sbx){ #sbx temparory
  
    #---------------------------------
    # 
    sbj_lst <- lapply(fresh, function(xx) str_split(xx[[3]], boundary("word")) %>%unlist%>%unique )
    sbj_indx <- grep( pattern = sbcd[[sbx]][[1]], sbj_lst ) #eval(parse(text = stringr::str_c('sbcd','$',sbx, '[1]') ))
    lmt.dat <- fresh[sbj_indx]
    
    sbj_dist <- function(x){
        
        sbj_lstr <- str_split(x[[3]], boundary("word"))%>%unlist%>%unique
        sbjN <- sbj_lstr%>%length 
        pos <- sapply(sbcd[[sbx]], function(vv) grep(pattern = vv,x = sbj_lstr) ) 
        if (sbx == 'E'){
            y <- gsub( pattern = '\\*',replacement = '1000', c(x[3+brk1+pos], '0', x[3+brk1+pos+brk2+sbjN], '0' ) ) %>% gsub(pattern = 'A', replacement = '0' )
        }
        else{
            y <- gsub( pattern = '\\*',replacement = '1000', c(x[3+brk1+pos], x[3+brk1+pos+brk2+sbjN]) ) %>% gsub(pattern = 'A', replacement = '0' )
        }
        
        y1 <- c(x[[1]], x[[2]], y)
        return(y1)
    }
    
    mrk.df <- sapply(lmt.dat, sbj_dist)%>%t%>%as.data.frame( stringsAsFactors = FALSE )
    colnames(mrk.df) <- c( "RegNo", "Name", "Th70", "Pr35", "ThIA30", "PrIA15")
    mrk.df <- mrk.df %>% mutate( Pr50 = as.integer(Pr35)+as.integer(PrIA15), Th100 = as.integer(Th70)+as.integer(ThIA30), Th150 = as.integer(Th70)+as.integer(ThIA30)+as.integer(Pr35)+as.integer(PrIA15) )
    if( sbx == 'E'){
        mrk.df <- mrk.df %>%
            mutate(
                Class = case_when(
                    Th70 < 40 | ThIA30 < 20 ~ "F",
                    Th150 < 75 & Th150 > 59  ~ "III",
                    Th150 < 90 & Th150 > 74  ~ "II",
                    Th150 < 105 & Th150 > 89 ~ "I",
                    Th150 < 120 & Th150 > 104 ~ "DIST",
                    Th150 < 135 & Th150 > 119 ~ "EXMP",
                    Th150 < 151 & Th150 > 134 ~ "OUT",
                    Th150 > 150 ~ "SPL",
                    TRUE ~ "SPL"
                )
            )
    }
    else{
        mrk.df <- mrk.df %>%
            mutate(
                Class = case_when(
                    Th100 < 40 | Pr50 < 20 ~ "F",
                    Th150 < 75 & Th150 > 59  ~ "III",
                    Th150 < 90 & Th150 > 74  ~ "II",
                    Th150 < 105 & Th150 > 89 ~ "I",
                    Th150 < 120 & Th150 > 104 ~ "DIST",
                    Th150 < 135 & Th150 > 119 ~ "EXMP",
                    Th150 < 151 & Th150 > 134 ~ "OUT",
                    Th150 > 150 ~ "SPL",
                    TRUE ~ "SPL"
                )
            )
    }
    
    cth <- mrk.df$Class %>% table
    cls <- c("OUT","EXMP","DIST","I","II","III","F","SPL")
    pth <- dplyr::intersect(cls, (cth%>%names) )
    pthpos <- sapply(pth, function(xn) which( cls == xn) )
    miscls <- cls[-(pthpos%>%unlist)]
    pcth <- rep(0, (miscls%>%length) )
    names(pcth) <- miscls
    
    #pth <- rep(c(na = 0 ), 8 - (cth%>%length))
    cth <- c( cth, pcth  ) ##, Total = (cth%>%sum)
    cth <- cth[ sapply(cls, function(x1) which( cth%>%names == x1 ) ) ]
    tot <- (cth[-8]%>%sum)
    cth <- c(cth, Total = tot, 'Pass%' = round( (tot-cth[[7]])*100/tot , 2) )
    return(  cth )  #%>%rbind(Subj = sbx)
    
}

if(ln.tst > 2 ) {result <- ln.tst} else  result <- sapply((sbcd%>%names), actul)%>%t #actul('s') 



write.csv(result , file(str_c("/path/","sample_output_",(reg%>%names)[[1]],"BGS_Sem",sems,month,year,".csv")))






