      subroutine minfunc(npar,grad,dchisq,z,iflag,futil)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS AUG 27  2012
C     
C     ****************************************************
      implicitnone

C     CONSTANTS
      include 'const.inc'
C     ARGUMENTS 
      integer npar,iflag
      real*8 grad,dchisq
C     GLOBAL VARIABLES
      real*8 zz(10)
      common /zz/ zz
C     LOCAL VARIABLES 
      integer i
      integer nevent,nbins,evform_th,evform_dat,nmin,nout
      parameter (nout=6)
      real*8 x(0:1000),z_dat(20),event_th(1000),z(20)
      real*8 nevent_th,ans,erro,event_dat(1000),nevent_dat,error(10)
      real*8 Emin,Emax,rootEmin,rootEmax,Eres
C     EXTERNAL FUNCTIONS
      real*8 hfunc1D_th,hfunc1D_dat,dchi2,futil
      external hfunc1D_th,hfunc1D_dat,dchi2,futil
C     ----------
C     BEGIN CODE
C     ----------
      nevent = 0

      z_dat(1) = 0.852d0
      z_dat(2) = 0.1d0
      z_dat(3) = 7.5d-5
      z_dat(4) = 2.35d-3
      z_dat(5) = zz(1) ! L [km]
      z_dat(6) = zz(2)     ! NH/IH
      z_dat(7) = 1d9*avog   ! N_target
      z_dat(8) = 18d0  ! Power [GW]
      z_dat(9) = 5     ! Exposure time [year]
      z(5) = zz(1)
      z(6) = -1*zz(2)
      z(7) = z_dat(7)
      z(8) = z_dat(8)
      z(9) = z_dat(9)
      error(1) = 0.025d0
      error(2) = 0.01d0
      error(3) = 0.2d-5
      error(4) = 0.1d-3
      Emin = 1.01d0   ! Emin > 1.80473
      Emax = 7.2d0
      Eres = 0.05d0
      nbins = int( ( dsqrt(Emax) -dsqrt(Emin) ) / Eres )

      do i = 0,nbins
c         x(i) = rootEmin +(rootEmax -rootEmin)/dble(nbins)*i
         x(i) = dsqrt(Emin) +Eres*i
      enddo
      evform_th = 2
      call MakeHisto1D(nout,hfunc1D_th,z,nevent,nbins,x,evform_th
     &     ,event_th,nevent_th)
      evform_dat = 2
      call MakeHisto1D(nout,hfunc1D_dat,z_dat,nevent,nbins,x
     &     ,evform_dat,event_dat,nevent_dat)

      open(1,file="event_dat.dat",status="replace")
      open(2,file="event_th.dat",status="replace")
      do i = 1,nbins
         write(1,*) x(i),event_dat(i)
         write(2,*) x(i),event_th(i)
      enddo
      close(1)
      close(2)

      dchisq = dchi2(nout,event_dat,event_th,nbins,npar,z,z_dat,error)

      return
      end
