
adrien <- matrix(c(f16$Months, f16$ADRIEN), ncol=2)
adrien <- adrien[is.na(adrien[,2])==FALSE,]
plot(adrien, type="l")

plot.f16 <- function(f16, name) {
  values <- matrix(c(f16$Months, f16[,name]), ncol=2)
  values <- values[is.na(values[,2])==FALSE,]
  plot(values, type="l", main=name, xlab="months", ylab="mean features/utterance")
}


plot.f16(f16, "ADRIEN")
plot.f16(f16, "ANAE")
plot.f16(f16, "ANTOINE")
plot.f16(f16, "JULIE")
plot.f16(f16, "LEONARD")
plot.f16(f16, "MADELEINE")
plot.f16(f16, "THEOPHILE")
