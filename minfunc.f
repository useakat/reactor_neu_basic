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
      integer nevent,nbins,evform_th,evform_dat,nmin,nout,snmax,hmode
      integer maxnbin,imode
      parameter (nout=6, maxnbin=100000)
      real*8 x(0:maxnbin),z_dat(20),event_th(maxnbin),z(20)
      real*8 nevent_th,ans,erro,event_dat(maxnbin),nevent_dat,error(10)
      real*8 Emin,Emax,rootEmin,rootEmax,Eres,serror
      real*8 hevent_th(maxnbin),hevent_dat(maxnbin),xmin,xmax
C     EXTERNAL FUNCTIONS
      real*8 hfunc1D,dchi2,futil
      external hfunc1D,dchi2,futil
C     ----------
C     BEGIN CODE
C     ----------
      imode = int(zz(8))

      z_dat(1) = 0.852d0
      z_dat(2) = 0.1d0
      z_dat(3) = 7.5d-5
      z_dat(4) = 2.35d-3

      z_dat(5) = zz(1)                  ! L [km]
      z_dat(6) = zz(2)                  ! NH/IH
      z_dat(7) = zz(4)*zz(5)*1d9*avog   ! N_target
      z_dat(8) = zz(3)                  ! Power [GW]
      z_dat(9) = zz(6)*y2s              ! Exposure time [s]
      z_dat(10) = 0                     ! hfunc1D mode, 0: dN/d[sqrt(E)] 1:d(flux*Xsec)/d[sqrt(E)]
      z(5) = z_dat(5)
      z(6) = -1*z_dat(6)
      z(7) = z_dat(7)
      z(8) = z_dat(8)
      z(9) = z_dat(9)
      z(10) = z_dat(10)
      
      error(1) = 0.025d0
      error(2) = 0.01d0
      error(3) = 0.2d-5
      error(4) = 0.1d-3

      Emin = 1.81d0   ! Emin > 1.80473
      Emax = 8d0
      Eres = zz(7)
      xmin = dsqrt(Emin-0.8d0)
      xmax = dsqrt(Emax-0.8d0)

      serror = 1d-2
      snmax = 3
      nevent = 0

      if (imode.eq.0) then  ! For Delta Chi^2 minimization
         hmode = 1 ! 0:continuous 1:simpson 2:center-value 
         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +Eres/2d0*i
         enddo
         evform_dat = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         evform_th = 2
         call MakeHisto1D(nout,hfunc1D,z,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &        ,nevent_th)
         dchisq = dchi2(nout,event_dat,event_th,nbins,npar,z,z_dat
     &        ,error)  

      elseif (imode.eq.1) then  ! For Flux*Xsec distribution
         z_dat(5) = 1d0   ! L [km] 
         z_dat(10) = 1    ! hfunc1D mode, 0: dN/d[sqrt(E)] 1:d(flux*Xsec)/d[sqrt(E)]  

         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +Eres/2d0*i
         enddo

         evform_dat = 2   ! 1:integer 2:real*8
         hmode = 0        ! 0:continuous 1:simpson 2:center-value 
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="FluxXsec.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         hmode = 1        ! 0:continuous 1:simpson 2:center-value 
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="FluxXsec_h.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         hmode = 2        ! 0:continuous 1:simpson 2:center-value 
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="FluxXsec_h2.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

      elseif (imode.eq.2) then
         z_dat(10) = 0    ! hfunc1D mode, 0: dN/d[sqrt(E)] 1:d(flux*Xsec)/d[sqrt(E)]  

         hmode = 0       ! 0:continuous 1:simpson 2:center-value 
         evform_dat = 2   ! 1:integer 2:real*8
         nbins = 10000
         do i = 0,nbins
            x(i) = xmin +( xmax -xmin ) / dble(nbins)*i
         enddo
         z_dat(6) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="evdinh.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)
         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="evdiih.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         hmode = 1       ! 0:continuous 1:simpson 2:center-value 
         evform_dat = 1   ! 1:integer 2:real*8
         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +Eres/2d0*i
         enddo
         z_dat(6) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="edh6nh.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)
         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="edh6ih.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

      endif

      return
      end
