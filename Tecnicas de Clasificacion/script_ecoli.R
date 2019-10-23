

ecoli.df = read.csv("/Users/vmarinas14/Victor/Cunef/Tecnicas de Clasificacion/tema 2/ecoli.txt", header=FALSE, sep="")
head(ecoli.df)
fix(ecoli.df)
names(ecoli.df)=c("seq","mcg","gvh","lip", "chg","aac","alm1","alm2", "class")

# We can use the xtabs function to summarise the number of cases in each class.

xtabs( ~ class, data = ecoli.df)

# As noted in the comments the package that I used was the tree package:

install.packages("tree")
library(tree)
library(rpart)

# The complete classification tree using all variables is fitted to the data initially 
# and then we will try to prune the tree to make it smaller.

ecoli.tree1 = rpart(class ~ mcg + gvh + lip + chg + aac + alm1 + alm2,
                   data = ecoli.df)

###ecoli.tree1 = tree(class ~ mcg + gvh + lip + chg + aac + alm1 + alm2,  MEJOR PRIMERA OPOCION
                    ## data = ecoli.df)
summary(ecoli.tree1)

# The tree function is used in a similar way to other modelling functions in R. 
# The misclassification rate is shown as part of the summary of the tree. 
# This tree can be plotted and annotated with these commands:

plot(ecoli.tree1)
text(ecoli.tree1, all = T)

# To prune the tree we use cross-validation to identify the point to prune.

cv.tree(ecoli.tree1)

# This suggests a tree size of 6 and we can re-fit the tree:

ecoli.tree2 = prune.misclass(ecoli.tree1, best = 6)
summary(ecoli.tree2)

plot(ecoli.tree2)
text(ecoli.tree2, all = T)
