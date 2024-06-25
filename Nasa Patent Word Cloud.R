#helpful guides --------------------
https://guides.library.upenn.edu/penntdm/r


library(dplyr)
library(paletteer)

install.packages("wordcloud")
library(wordcloud)
install.packages("RColorBrewer")
library(RColorBrewer)
install.packages("wordcloud2")
library(wordcloud2)

install.packages("tm")
library(tm)

nasa.patents = read.csv("/Users/kofi/Desktop/NASA PATENTS/NASA_Patents.csv")


patent.titles = nasa.patents$Title

nasa.corpus = Corpus(VectorSource(patent.titles))

nasa.corpus = tm_map(nasa.corpus, content_transformer(tolower))


dtm <- TermDocumentMatrix(nasa.corpus) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words) %>%
filter(! word %in% c("and", "for", "method", "system", "using", "with", "from", "the"))


set.seed(1234) # for reproducibility 

#get orange theme
orange= paletteer_c("ggthemes::Orange", 30)



#WORD CLOUD HERE
wordcloud(words = df$word, freq = df$freq, min.freq = 1, 
max.words=200, random.order=FALSE, rot.per=0.35, color = orange
)


code --help
