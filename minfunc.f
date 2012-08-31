      subroutine minfunc(npar,grad,dchisq,z,iflag,futil)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS AUG 27  2012
C     
C     ****************************************************
      implicitnone

C     CONSTANTS

C     ARGUMENTS 
      integer npar,iflag
      real*8 grad,dchisq
C     GLOBAL VARIABLES
      real*8 zz(10)
      common /zz/ zz
C     LOCAL VARIABLES 
      integer i
      integer nevent,nbins,evform_th,evform_dat,nmin,nout
      parameter (nout=6,nbins=10)
      real*8 x(0:nbins),z_dat(20),event_th(nbins),z(20)
      real*8 nevent_th,ans,erro,event_dat(nbins),nevent_dat,error(10)
      real*8 Emin,Emax,rootEmin,rootEmax
C     EXTERNAL FUNCTIONS
      real*8 hfunc1D_th,hfunc1D_dat,dchi2,futil
      external hfunc1D_th,hfunc1D_dat,dchi2,futil
C     ----------
C     BEGIN CODE
C     ----------
      nevent = 10000

      z_dat(1) = 0.852d0
      z_dat(2) = 0.1d0
      z_dat(3) = 7.5d-5
      z_dat(4) = 2.35d-3
      z_dat(5) = zz(1)
      z_dat(6) = 1
      z(5) = zz(1)
      z(6) = -1
      error(1) = 0.025d0
      error(2) = 0.01d0
      error(3) = 0.2d-5
      error(4) = 0.1d-3
      Emin = 2d0
      Emax = 7d0
      rootEmin = dsqrt(Emin)
      rootEmax = dsqrt(Emax)

      do i = 0,nbins
         x(i) = rootEmin +(rootEmax -rootEmin)/dble(nbins)*i
      enddo

c      write(*,*) "MakeHisto 1"      
      evform_th = 2
      call MakeHisto1D(nout,hfunc1D_th,z,nevent,nbins,x,evform_th
     &     ,event_th,nevent_th)
c      write(*,*) "MakeHisto 2"      
      evform_dat = 2
      call MakeHisto1D(nout,hfunc1D_dat,z_dat,nevent,nbins,x
     &     ,evform_dat,event_dat,nevent_dat)
      dchisq = dchi2(nout,event_dat,event_th,nbins,npar,z,z_dat,error)
c      write(*,*) dchisq
      return
      end
