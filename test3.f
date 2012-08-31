      subroutine minfunc(npar,grad,chisq,z,iflag,futil)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS AUG 27  2012
C     
C     ****************************************************
      implicitnone

C     CONSTANTS

C     ARGUMENTS 
      integer npar,iflag
      real*8 grad,chisq
C     GLOBAL VARIABLES

C     LOCAL VARIABLES 
      integer i
      integer nevent,nbins,evform_th,evform_dat,nmin
      real*8 x(0:nbins),z_th(nparam),z_dat(nparam),event_th(nbins)
      real*8 nevent_th,ans,erro,event_dat(nbins),nevent_dat,chisq
      integer ierr,nout
C     EXTERNAL FUNCTIONS
      real*8 hfunc1D,chi2,futil
      external hfunc1D,chi2,futil
C     ----------
C     BEGIN CODE
C     ----------
      nout = 6
      nbins = 10
      nevent = 10000

      z_dat(1) = 2d0
      z_dat(2) = 1d0

      do i = 0,nbins
         x(i) = i
      enddo
      
      evform_th = 2
      call MakeHisto1D(nout,hfunc1D,z,nevent,nbins,x,evform_th
     &     ,event_th,nevent_th)
      evform_dat = 1
      call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x,evform_dat
     &     ,event_dat,nevent_dat)
      chisq = chi2(nout,event_dat,event_th,nbins)
c      write(*,*) event_dat
c      write(*,*) event_th
c      write(*,*) chisq

      end
