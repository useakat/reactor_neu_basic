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
      real*8 zz(40)
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

      z_dat(1) = zz(9)
      z_dat(2) = zz(11)
      z_dat(3) = zz(13)
      z_dat(4) = zz(15)
      error(1) = zz(10)
      error(2) = zz(12)
      error(3) = zz(14)
      error(4) = zz(16)

      z_dat(5) = zz(1)                  ! L [km]
      z_dat(6) = zz(2)                  ! NH/IH
      z_dat(7) = zz(4)*zz(5)*1d9*avog   ! N_target
      z_dat(8) = zz(3)                  ! Power [GW]
      z_dat(9) = zz(6)*y2s              ! Exposure time [s]
      z_dat(10) = 20                     ! hfunc1D mode, 0: dN/d[sqrt(E)] 1:d(flux*Xsec)/d[sqrt(E)]
      z(5) = z_dat(5)
      z(6) = -1*z_dat(6)
      z(7) = z_dat(7)
      z(8) = z_dat(8)
      z(9) = z_dat(9)
      z(10) = z_dat(10)

      serror = zz(19)
      snmax = zz(20)
      Emin = zz(17)  ! Emin > 1.80473
      Emax = zz(18)
      Eres = zz(7)

      nevent = 0


CCCCCCCCCCCCCCCCCCCCCCCC  For Delta Chi^2 minimization  CCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCC                                CCCCCCCCCCCCCCCCCCCCCCCCCCC 

      if (imode.eq.0) then 
         z_dat(10) = 20 ! N vs. sqrt(E)
         hmode = 1 ! 0:continuous 1:simpson 2:center-value 
         xmin = dsqrt(Emin-0.8d0)
         xmax = dsqrt(Emax-0.8d0)
         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +Eres/2d0*i
         enddo
         evform_dat = 2
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         evform_th = 2
         call MakeHisto1D(nout,hfunc1D,z,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &        ,nevent_th)
         dchisq = dchi2(nout,event_dat,event_th,nbins,npar,z,z_dat
     &        ,error)  


CCCCCCCCCCCCCCCCCCCCC  F vs. sqrt(E) distributions   CCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCC                                CCCCCCCCCCCCCCCCCC

      elseif (imode.eq.1) then
         xmin = dsqrt(Emin-0.8d0)                           
         xmax = dsqrt(Emax-0.8d0)
         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +Eres/2d0*i
         enddo

         z_dat(10) = 21   ! Flux*Xsec vs.sqrt(E)
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

CCCCCCCCCCCCCCCCCCCCCCCCCC  dN/dE plots  CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCC               CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

      elseif (imode.eq.2) then  
         z_dat(10) = 20    ! N vs. sqrt(E)

         hmode = 0       ! 0:continuous 1:simpson 2:center-value 
         evform_dat = 2   ! 1:integer 2:real*8
         xmin = dsqrt(Emin-0.8d0)
         xmax = dsqrt(Emax-0.8d0)
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

CCCCCCCCCCCCCCCCCCCCCC  F vs. L/E distributions  CCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCC                           CCCCCCCCCCCCCCCCCCCCCC

      elseif (imode.eq.3) then
         xmax = z_dat(5)/Emin
         xmin = z_dat(5)/Emax
         nbins = 10000 ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +(xmax-xmin)/dble(nbins)*i
         enddo

CCCCCCCCCCCCCCCCCCCCCC  Flux*Xsec*Pee vs. L/E  CCCCCCCCCCCCCCCCCCCCCCCC

         z_dat(10) = 12   ! Flux*Xsec vs. L/E    
         evform_dat = 2   ! 1:integer 2:real*8
         hmode = 0        ! 0:continuous 1:simpson 2:center-value 
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="FluxXsec_loe.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         z_dat(10) = 13 
         z_dat(6) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="FluxXsecPeeNH_loe.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         z_dat(10) = 13 
         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="FluxXsecPeeIH_loe.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

CCCCCCCCCCCCCCCCCCCCCCCCCC  dPee/d(L/E)  CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

         z_dat(10) = 14    ! Pee vs. L/E
         evform_dat = 2   ! 1:integer 2:real*8
         hmode = 0        ! 0:continuous 1:simpson 2:center-value 
         z_dat(6) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="PeeNH_loe.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="PeeIH_loe.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)


CCCCCCCCCCCCCCCCCCCCCC  F vs. E distributions CCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCC                        CCCCCCCCCCCCCCCCCCCCCCCCC

      elseif (imode.eq.4) then
         xmax = Emax
         xmin = Emin
         nbins = 10000 ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +(xmax-xmin)/dble(nbins)*i   
         enddo

         z_dat(10) = 4    ! Pee vs. E
         evform_dat = 2   ! 1:integer 2:real*8
         hmode = 0        ! 0:continuous 1:simpson 2:center-value 
         z_dat(6) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="PeeNH.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat)
         open(1,file="PeeIH.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

      endif

      return
      end
