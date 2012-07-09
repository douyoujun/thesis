rm(list=ls())
#建立一个计算邻近存活细胞数目的函数，并使边缘的细胞仍有八个邻居
neighbours <- function(A,i,j,n) {
  left <- ifelse(j ==  1,n,j-1)
  right <- ifelse(j == n, 1, j+1)
  up <- ifelse(i == 1, n, i-1)
  down <- ifelse(i == n, 1, i+1)
  nbrs <- sum(A[up,left] == 1,A[up,right] == 1,A[up,j] == 1,A[i,left] == 1, A[i,right] == 1,A[down,left] == 1,A[down,right] == 1,A[down,j] == 1)
  return(nbrs)
}
n <- 50  #方阵的行数
A <- matrix(round(runif(n^2)),n,n) #初始化二维世界方阵
finished <- FALSE
while (!finished) {  #重复进行演化，你需要用ESC退出
  plot(c(1,n),c(1,n),type='n',xlab='',ylab='') #绘图
  for(i in 1:n) {
    for (j in 1:n) {
      if (A[i,j]==1) {
        points(i,j,pch=16,col='red')
      }
    }
  }
  B <- A #将上期的信息存入本期矩阵B，并按照条件修改B
  for (i in 1:n) {
    for (j in 1:n) {
      nbrs <- neighbours(A,i,j,n)
      if (A[i,j]==1) {
        if ((nbrs ==2) | (nbrs==3)){
          B[i,j] <- 1
        } else {
          B[i,j] <- 0
        }
      } else {
        if (nbrs ==3) {
          B[i,j] <- 1
        } else {
          B[i,j] <- 0
        }
      }
    }
  }
  A <- B #将变化后的B矩阵存回到A中
} 