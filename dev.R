#STACK
pdt = proc.time()
x <- stack(df1$filename)
proc.time() - pdt

#BRICK
pdt = proc.time()
z <- brick(x)
proc.time() - pdt

#STACK SUM
pdt = proc.time()
x1 <- x * 0.02
proc.time() - pdt

#brick SUM
pdt = proc.time()
z1 <- z * 0.02
proc.time() - pdt

