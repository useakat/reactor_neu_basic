      program get_cl
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Dec.14 2012
C     ****************************************************
      implicitnone
C     CONSTANTS     
C     ARGUMENTS
      character*20 cmean,csigma2,cmean_error,csigma2_error
      real*8 rmean,rsigma2,rmean_error,rsigma2_error,sigma_cut
C     GLOBAL VARIABLES
C     LOCAL VARIABLES 
      real*8 z(2),error,xmin,xmax,cl,clsigma,cl2,cl3,cl_perror,cl_merror
      integer nmax,iflag
C     EXTERNAL FUNCTIONS
      real*8 DeltaChi2CL,DeltaChi2Sigma,SigmaProb
      external DeltaChi2CL,DeltaChi2Sigma,SigmaProb
C     ----------
C     BEGIN CODE
C     ----------
      call getarg(1,cmean)
      call getarg(2,csigma2)
      call getarg(3,cmean_error)
      call getarg(4,csigma2_error)
      read (cmean,*) rmean
      read (csigma2,*) rsigma2
      read (cmean_error,*) rmean_error
      read (csigma2_error,*) rsigma2_error

      error = 1d-8
      nmax = 20
      sigma_cut = 7

      z(1) = rmean
      z(2) = dsqrt(rsigma2)
      xmin = max(z(1)-sigma_cut*z(2),0d0)
      xmax = z(1)+sigma_cut*z(2)
      if ( (z(2).lt.1d-5).or.((xmax-xmin).lt.1d-5) ) then
         cl = SigmaProb(dsqrt(z(1)))
      else
         call simp3d(DeltaChi2CL,xmin,xmax,z,cl,error,nmax,iflag)
      endif

      z(1) = rmean +rmean_error
      z(2) = dsqrt(rsigma2 -rsigma2_error)
      xmin = max(z(1)-sigma_cut*z(2),0d0)
      xmax = z(1)+sigma_cut*z(2)
      if ( (z(2).lt.1d-5).or.((xmax-xmin).lt.1d-5) ) then
         cl = SigmaProb(dsqrt(z(1)))
      else
         call simp3d(DeltaChi2CL,xmin,xmax,z,cl2,error,nmax,iflag)
      endif
      cl_perror = dabs(cl2 -cl)

      z(1) = rmean -rmean_error
      z(2) = dsqrt(rsigma2 +rsigma2_error)
      xmin = max(z(1)-sigma_cut*z(2),0d0)
      xmax = z(1)+sigma_cut*z(2)
      if ( (z(2).lt.1d-5).or.((xmax-xmin).lt.1d-5) ) then
         cl = SigmaProb(dsqrt(z(1)))
      else
         call simp3d(DeltaChi2CL,xmin,xmax,z,cl3,error,nmax,iflag)
      endif
      cl_merror = dabs(cl3 -cl)

      if (iflag.eq.1) then
         write(6,*) "ERROR:get_cl: simp3d does not converge. ",
     &        "Stop get_cl..."
         stop
      endif

      open(1,file="cl.dat",status="replace")
      write(1,*) rmean,dsqrt(rsigma2),cl,cl_perror,cl_merror
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

      real*8 function DeltaChi2Sigma(x,mean,sigma)
      implicit none
      real*8 x,mean,sigma
      real*8 rNormalDist,SigmaProb
      external rNormalDist,SigmaProb

      DeltaChi2Sigma = rNormalDist(x,mean,sigma)*dsqrt(x)

      return
      end
