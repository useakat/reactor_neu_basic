        SUBROUTINE hSIMP1D(F,X0,X1,Z,ANS,ERROR,NMAX,NFLAG)                   
C--------THIS SUBROUTIN INTEGRATES A FUNCTION F FROM X0 TO X1 AND RETURN
C--------THE INTEGRAL AS ANS BY USING THE SIMPSON'S FORMULA.  ALLOWED   
C--------ERROR AND A MAXIMUM NUMBER OF ITERATION NMAX SHOULD BE         
C--------SPECIFIED. (THE MAXIMUM DIVISION NUMBER IS 2*2**NMAX).         
C--------NFLAG=1 IF THE INTEGRAL DOES NOT CONVERGE.                     
C--------NFLAG=0 IF THE INTEGRAL CONVERGES.                             
c        IMPLICIT REAL*8 (A-H,O-Z)
      implicit none

      integer nmax,nflag
      real*8 x0,x1,z(40),ans,error

      integer i
      integer n,l
      real*8 h,sum0,sum1,sum2,s

      real*8 f
      external f

      NFLAG = 0
      N = 2
      H = ( X1-X0 ) / 2d0
      
      SUM0 = F(X1,Z) +F(X0,Z)
      SUM1 = F(X0+H,Z)
      
      SUM2 = 0d0
      S = H / 3d0*( SUM0 +4d0*SUM1 )
      
      DO L = 1,NMAX
         H = H/2d0
         N = N*2
         SUM2 = SUM1 +SUM2
         SUM1 = 0d0
         DO I = 1,N,2
            SUM1 = SUM1 +F(X0+H*I,Z)
         enddo
         ANS = H/3d0*( SUM0 +4d0*SUM1 +2d0*SUM2 )
         IF(ABS(ANS-S).LE.ABS(ANS*ERROR)) RETURN
         S = ANS
      enddo
      NFLAG = 1
         
      RETURN
      END
      
