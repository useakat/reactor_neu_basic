      real*8 function SigmaProb(x)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS AUG 25 2012
C     ****************************************************
      implicit none
C     GLOBAL VARIABLES
C     CONSTANTS
C     ARGUMENTS 
      real*8 x
C     LOCAL VARIABLES 
      real*8 z(2),error,ans
      integer nmax,nflag
C     EXTERNAL FUNCTIONS
      real*8 rNormalDist
      external rNormalDist
C     ----------
C     BEGIN CODE
C     ----------
      z(1) = 0d0
      z(2) = 1d0
      error = 1d-8
      nmax = 10
      
      call simp3d(rNormalDist,-x,x,z,ans,error,nmax,nflag)
      SigmaProb = ans

      return
      end
