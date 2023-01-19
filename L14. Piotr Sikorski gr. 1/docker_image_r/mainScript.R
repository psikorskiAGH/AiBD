library(magrittr)
library(ggplot2)
library(GGally)
library(cluster)


# === ZADANIE 1 === #
print(" === ZADANIE 1 === ")

# 1. Lista 10 elementów
lista <- c(1:10)
sprintf("1) [%s]", toString(lista))

# 2. 
lista %<>% log2 %>% sin %>% sum %>% sqrt
sprintf("2) %f", lista)

# 3.
data(iris)

# 4.
print("4)")
head(iris)

# 5.
print("5)")
agg = aggregate(. ~ Species, iris, mean)
agg

print("")
print("")
print("")


# === ZADANIE 2 === #
print(" === ZADANIE 2 === ")

# plt = ggplot(data = pet_len_setosa, aes(x = c(1:length(pet_len_setosa))))
plt <- ggplot(data = iris, aes(x = Petal.Length, fill=Species)) + 
    geom_vline(data=agg[c("Petal.Length")], aes(xintercept = Petal.Length)) +
    geom_histogram( color="#e9ecef", alpha=0.4, position = 'identity') +
    scale_fill_manual(values=c("#aa0000", "#00aa00", "#0000aa")) +
    labs(fill="") +
    ggtitle("Rozkład długości płatków kwiatów irysa wg gatunku")
ggsave("/output/2_histogram_iris.jpg", plot = plt)

plt <- ggpairs(data=iris, aes(color=Species)) +
    ggtitle("Wynik funkcji 'ggpairs()'")
ggsave("/output/2_ggpairs.jpg", plot = plt)

print("")
print("")


# === ZADANIE 3 === #
print(" === ZADANIE 3 === ")

x = iris[1:4]
y = iris[5]

max_klastry = 7
wartosci_klastrow = c()
for (i in 1:max_klastry) {
    v <- kmeans(x, i)$withins ^ 2 %>% sum
    wartosci_klastrow <- append(wartosci_klastrow, v)
}
df <- data.frame(Iteracja =1:length(wartosci_klastrow), Wartosci.klastrow = wartosci_klastrow)

plt <- ggplot(data = df, aes(x = Iteracja, y = Wartosci.klastrow)) +
    geom_line() +
    geom_point(aes(size=4)) +
    ggtitle("Wartości 'withins' klastrów jako suma kwadratów")
ggsave("/output/3_wartosci_klastrow.jpg", plot = plt)

jpeg('/output/3_cluster.jpg')
clusplot(x[, c("Sepal.Length", "Sepal.Width")],
    kmeans(x, 3)$cluster,
    lines = 0,
    shade = TRUE,
    color = TRUE,
    labels = 2,
    plotchar = FALSE,
    span = TRUE,
    main = paste("Cluster iris"),
    xlab = 'Sepal.Length',
    ylab = 'Sepal.Width'
)
dev.off()

plt <- ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width)) + 
    geom_point(aes(color=Species, size=4)) +
    ggtitle("Oryginalny podział irysów na grupy")
ggsave("/output/3_cluster_orig.jpg", plot = plt)
