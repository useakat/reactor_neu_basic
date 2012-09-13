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
      integer maxnbin,imode,minflag,ierr,ierr1,ierr2,iswitch_smear
      parameter (nout=6, maxnbin=20000)
      real*8 x(0:maxnbin),z_dat(40),event_th(maxnbin),z(40)
      real*8 nevent_th,ans,erro,event_dat(maxnbin),nevent_dat,error(10)
      real*8 Emin,Emax,rootEmin,rootEmax,Eres,serror,rdx
      real*8 hevent_th(maxnbin),hevent_dat(maxnbin),xmin,xmax
      real*8 z_min(40),event_fit(maxnbin),nevent_fit(maxnbin),hevent_fit(maxnbin)
      real*8 event2_dat(maxnbin),event2_th(maxnbin)
C     EXTERNAL FUNCTIONS
      real*8 hfunc1D,dchi2,futil
      external hfunc1D,dchi2,futil
C     ----------
C     BEGIN CODE
C     ----------
      minflag = 0
      imode = int(zz(8))

      z_dat(1) = zz(9)
      z_dat(2) = zz(11)
      z_dat(3) = zz(13)
      z_dat(4) = zz(15)
      z_dat(5) = zz(17)
      error(1) = zz(10)
      error(2) = zz(12)
      error(3) = zz(14)
      error(4) = zz(16)
      error(5) = zz(18)

      z_dat(6) = zz(2)                  ! NH/IH
      z_dat(7) = zz(4)*zz(5)*1d9*avog   ! N_target
      z_dat(8) = zz(3)                  ! Power [GW]
      z_dat(9) = zz(6)*y2s              ! Exposure time [s]
      z_dat(10) = 20                     ! hfunc1D mode, 0: dN/d[sqrt(E)] 1:d(flux*Xsec)/d[sqrt(E)]
      z_dat(11) = zz(1)                  ! L [km]
      z(6) = -1*z_dat(6)
      z(7) = z_dat(7)
      z(8) = z_dat(8)
      z(9) = z_dat(9)
      z(10) = z_dat(10)
      z(11) = z_dat(11)

      serror = zz(21)
      snmax = zz(22)
      Emin = zz(19)  ! Emin > 1.80473
      Emax = zz(20)
      Eres = zz(7)

      nevent = 0
      iswitch_smear = 1
      rdx = 0.005

CCCCCCCCCCCCCCCCCCCCCCCC  For Delta Chi^2 minimization  CCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCC                                CCCCCCCCCCCCCCCCCCCCCCCCCCC 

      if (imode.eq.0) then 
         z_dat(10) = 20 ! N vs. sqrt(E)
         hmode = 1 ! 0:continuous 1:simpson 2:center-value 
         xmin = dsqrt(Emin-0.8d0)
         xmax = dsqrt(Emax-0.8d0)

         nbins = int( ( xmax -xmin ) / rdx ) ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +rdx*i
         enddo
c         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
c         do i = 0,nbins
c            x(i) = xmin +Eres/2d0*i
c         enddo
         evform_dat = 2
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr1) 
         call smearing(event_dat,nbins,rdx,Eres,event2_dat,iswitch_smear)         
        
         evform_th = 2
         call MakeHisto1D(nout,hfunc1D,z,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &        ,nevent_th,ierr2)
         call smearing(event_th,nbins,rdx,Eres,event2_th,iswitch_smear)
cc         if ( (ierr1.ne.0).or.(ierr2.ne.0) ) then
c            dchisq = 1d10
c         else
            dchisq = dchi2(nout,event2_dat,event2_th,nbins,npar,z,z_dat
     &           ,error)  
c         endif

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
     &        ,nevent_dat,ierr)
         open(1,file="FluxXsec.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         hmode = 1        ! 0:continuous 1:simpson 2:center-value 
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="FluxXsec_h.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         hmode = 2        ! 0:continuous 1:simpson 2:center-value 
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="FluxXsec_h2.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

CCCCCCCCCCCCCCCCCCCCCCCCCC  dN/dE plots  CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCC               CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

      elseif (imode.eq.2) then  
         z_dat(10) = 20    ! N vs. sqrt(E)
         
         hmode = 0              ! 0:continuous 1:simpson 2:center-value 
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
     &        ,nevent_dat,ierr)
         open(1,file="evdinh.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)
         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
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
     &        ,nevent_dat,ierr)
         open(1,file="edh6nh.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)
         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="edh6ih.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

CCCCCCCCCCCCCCCCCCCCCCCCC  Best fit plots and data  CCCCCCCCCCCCCCCCCCCCCCCCCCCC
         nbins = 10000
         do i = 0,nbins
            x(i) = xmin +( xmax -xmin ) / dble(nbins)*i
         enddo
         open(2,file='dchi2min_bestfit2nh.dat',status='old',err=200)
         do 
            read(2,*,end=100) z_min(11),z_min(1),z_min(2),z_min(3)
     &           ,z_min(4),z_min(5)
            if ((z_min(11).ge.z_dat(11)).and.(z_min(11).lt.z_dat(11)+0.9d0))
     &           then
               minflag = 1
               do i = 6,11
                  z_min(i) = z(i)
               enddo
               goto 100
            endif
         enddo
 100     close(2)
         hmode = 0
         z_min(6) = -1
c        z_dat(6) = 1
         call MakeHisto1D(nout,hfunc1D,z_min,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="evdinhmin.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)
         
         hmode = 1
         xmin = dsqrt(Emin-0.8d0)
         xmax = dsqrt(Emax-0.8d0)
         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +Eres/2d0*i
         enddo
         z_dat(6) = 1
         evform_dat = 2
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr1)
         z_dat(6) = -1
         evform_th = 2
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &        ,nevent_th,ierr2)
c         z_min(6) = -1
         z_dat(6) = 1
         evform_th = 2
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_th,serror,snmax,hmode,event_fit,hevent_fit
     &        ,nevent_fit,ierr2)
         open(1,file="event_min2nh.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i-1)**2+0.8d0,event_dat(i),event_th(i),event_fit(i)
         enddo
         close(1)
 200  continue

      nbins = 10000
      do i = 0,nbins
         x(i) = xmin +( xmax -xmin ) / dble(nbins)*i
      enddo
      open(2,file='dchi2min_bestfit2ih.dat',status='old',err=400)
      do 
         read(2,*,end=300) z_min(11),z_min(1),z_min(2),z_min(3)
     &        ,z_min(4),z_min(5)
         if ((z_min(11).ge.z_dat(11)).and.(z_min(11).lt.z_dat(11)+0.9d0))
     &        then
            minflag = 1
            do i = 6,11
               z_min(i) = z(i)
            enddo
            goto 300
         endif
      enddo
 300  close(2)
      z_min(6) = 1
c      z_dat(6) = -1
      call MakeHisto1D(nout,hfunc1D,z_min,nevent,nbins,x
     &     ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &     ,nevent_dat,ierr)
      open(1,file="evdiihmin.dat",status="replace")
      do i = 1,nbins
         write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
      enddo
      close(1)
      
      hmode = 1
      xmin = dsqrt(Emin-0.8d0)
      xmax = dsqrt(Emax-0.8d0)
      nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
      do i = 0,nbins
         x(i) = xmin +Eres/2d0*i
      enddo
      z_dat(6) = 1
      evform_dat = 2
      call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &     ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &     ,nevent_dat,ierr1)
      do i =1,nbins
      enddo
      z_dat(6) = -1
      evform_th = 2
      call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &     ,evform_th,serror,snmax,hmode,event_th,hevent_th
     &     ,nevent_th,ierr2)
c      z_min(6) = 1
      z_dat(6) = -1
      evform_th = 2
      call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &     ,evform_th,serror,snmax,hmode,event_fit,hevent_fit
     &     ,nevent_fit,ierr2)
      open(1,file="event_min2ih.dat",status="replace")
      do i = 1,nbins
         write(1,*) x(i-1)**2+0.8d0,event_dat(i),event_th(i),event_fit(i)
      enddo
      close(1)
 400  continue
      
      

CCCCCCCCCCCCCCCCCCCCCC  F vs. L/E distributions  CCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCC                           CCCCCCCCCCCCCCCCCCCCCC

      elseif (imode.eq.3) then
         xmax = z_dat(11)/Emin
         xmin = z_dat(11)/Emax
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
     &        ,nevent_dat,ierr)
         open(1,file="FluxXsec_loe.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         z_dat(10) = 13 
         z_dat(6) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="FluxXsecPeeNH_loe.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         z_dat(10) = 13 
         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
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
     &        ,nevent_dat,ierr)
         open(1,file="PeeNH_loe.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
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
     &        ,nevent_dat,ierr)
         open(1,file="PeeNH.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         z_dat(6) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="PeeIH.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

      endif

      return
      end
