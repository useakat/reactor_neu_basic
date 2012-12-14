      program get_cl
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Dec.14 2012
C     ****************************************************
      implicitnone
C     CONSTANTS     
C     ARGUMENTS
      character*10 cmean,csigma
      real*8 rmean,rsigma
C     GLOBAL VARIABLES
C     LOCAL VARIABLES 
      real*8 z(2),error,xmin,xmax,cl
      integer nmax,iflag
C     EXTERNAL FUNCTIONS
      real*8 DeltaChi2CL
      external DeltaChi2CL
C     ----------
C     BEGIN CODE
C     ----------
      call getarg(1,cmean)
      call getarg(2,csigma)
      read (cmean,*) rmean
      read (csigma,*) rsigma

      z(1) = rmean
      z(2) = rsigma
      error = 1d-3
      nmax = 10

      xmin = max(rmean-3*rsigma,0d0)
      xmax = rmean+3*rsigma
      call simp3d(DeltaChi2CL,xmin,xmax,z,cl,error,nmax,iflag)
      if (iflag.eq.1) then
         write(6,*) "ERROR:get_cl: simp3d does not converge. ",
     &        "Stop get_cl..."
         stop
      endif

      open(1,file="cl.dat",status="replace")
      write(1,*) rmean,rsigma,cl
      close(1)

      end


      real*8 function DeltaChi2CL(x,mean,sigma)
      implicit none
      real*8 x,mean,sigma
      real*8 rNormalDist,SigmaProb
      external rNormalDist,SigmaProb

      DeltaChi2CL = rNormalDist(x,mean,sigma)*SigmaProb(dsqrt(x))

      return
      end
