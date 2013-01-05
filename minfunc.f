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
      real*8 grad,dchisq,chisq_true,chisq_wrong
C     GLOBAL VARIABLES
      real*8 zz(40)
      common /zz/ zz
      integer ifirst
      real*8 final_bins
      common /first/ final_bins,ifirst
C     LOCAL VARIABLES 
      integer i,j
      integer nevent,nbins,evform_th,evform_dat,nmin,nout,snmax,hmode,ndiv
      integer maxnbin,imode,minflag,ierr,ierr1,ierr2,iswitch_smear,nnbins
      parameter (nout=6, maxnbin=20000)
      integer ifluc
      real*8 x(0:maxnbin),z_dat(40),event_th(maxnbin),z(40)
      real*8 nevent_th,ans,erro,event_dat(maxnbin),nevent_dat,error(10)
      real*8 Emin,Emax,rootEmin,rootEmax,Eres,serror,rdx
      real*8 hevent_th(maxnbin),hevent_dat(maxnbin),xmin,xmax
      real*8 z_min(40),event_fit(maxnbin),nevent_fit(maxnbin),hevent_fit(maxnbin)
      real*8 event2_dat(maxnbin),event2_th(maxnbin),radchi2,rint_adchi2
      real*8 Eres_nl,rdbin,EEres,EEres_nl
      real*8 dmm13min,dmm13max,ndmm13
      common /event_dat/ event2_dat,nbins
C     EXTERNAL FUNCTIONS
      real*8 hfunc1D,dchi2,futil,adchi2,chi2_2
      real*8 gran
      external hfunc1D,dchi2,futil,adchi2,chi2_2,gran
c      save event2_dat
C     ----------
C     BEGIN CODE
C     ----------
      minflag = 0
      imode = int(zz(8))

      z_dat(1) = zz(10)
      z_dat(2) = zz(12)
      z_dat(3) = zz(14)
      z_dat(4) = zz(16)
      z_dat(5) = zz(18)
      z_dat(6) = zz(20)
      z_dat(7) = zz(22)
      z_dat(8) = zz(24)
      error(1) = zz(11)
      error(2) = zz(13)
      error(3) = zz(15)
      error(4) = zz(17)
      error(5) = zz(19)
      error(6) = zz(21)
      error(7) = zz(23)
      error(8) = zz(25)

      z_dat(11) = zz(2)                  ! NH/IH
      z_dat(12) = zz(4)*zz(5)*1d9*avog   ! N_target
      z_dat(13) = zz(3)                  ! Power [GW]
      z_dat(14) = zz(6)*y2s              ! Exposure time [s]
      z_dat(15) = 20                     ! hfunc1D mode, 0: dN/d[sqrt(E)] 1:d(flux*Xsec)/d[sqrt(E)]
c      z_dat(15) = 100                   ! hfunc1D mode, 0: dN/d[sqrt(E)] 1:d(flux*Xsec)/d[sqrt(E]
      z_dat(16) = zz(1)                  ! L [km]
      z(11) = zz(36)*z_dat(11)              
c      z(11) = z_dat(11)
      z(12) = z_dat(12)
      z(13) = z_dat(13)
      z(14) = z_dat(14)
      z(15) = z_dat(15)
      z(16) = z_dat(16)

      serror = zz(32)
      snmax = zz(33)
      Emin = zz(30)  ! Emin > 1.80473
      Emax = zz(31)
      Eres = zz(7)
      Eres_nl = zz(34)
      ndiv = zz(35)
      ifluc = zz(37)

      nevent = 0
c      rdx = 0.01
c      rdx = 0.0075
      rdx = 0.005
c      rdx = 0.0025
c      rdx = 0.00125
      nnbins = 1000

CCCCCCCCCCCCCCCCCCCCCCCC  For Delta Chi^2 minimization  CCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCC                                CCCCCCCCCCCCCCCCCCCCCCCCCCC 

      if (imode.eq.0) then 
         if (ifluc.eq.0) then
            include 'inc/dchi2.inc'
         elseif (ifluc.eq.1) then
            include 'inc/dchi2_stat.inc'
         endif

CCCCCCCCCCCCCCCCCCCCC  basic distributions   CCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCC                  CCCCCCCCCCCCCCCCCC
      elseif (imode.eq.1) then
         include 'inc/FluxXsec_sqrtE.inc'

CCCCCCCCCCCCCCCCCCCCCCCCCC  dN/dE plots  CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCC               CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      elseif (imode.eq.2) then 
         include 'inc/EventDist.inc'

         open(2,file='dchi2min_bestfit2nh.dat',status='old',err=200)
         do
            read(2,*,end=100) z_min(16),z_min(1),z_min(2),z_min(3)
     &           ,z_min(4),z_min(5),z_min(6),z_min(7),z_min(8)
            if ((z_min(16).ge.z_dat(16)).and.(z_min(16).lt.z_dat(16)+0.9d0))
     &           then
               minflag = 1
               do i = 11,16
                  z_min(i) = z_dat(i)
               enddo
               goto 100
            endif
         enddo
 100     close(2)
c         write(6,*) "z_min"
c         write(6,*) z_min(1),z_min(2),z_min(3),z_min(4),z_min(5)
c     &        ,z_min(6),z_min(7)
c         write(6,*) "z_dat"
c         write(6,*) z_dat(1),z_dat(2),z_dat(3),z_dat(4),z_dat(5)
c     &        ,z_dat(6),z_dat(7)
         include 'inc/EventDist_BestFitPlot_nh.inc'
c         include 'inc/Analytic_dchi2_nh.inc'
c         include 'inc/BestFitData_nh.inc'
 200     continue

         open(2,file='dchi2min_bestfit2ih.dat',status='old',err=400)
         do 
            read(2,*,end=300) z_min(16),z_min(1),z_min(2),z_min(3)
     &           ,z_min(4),z_min(5),z_min(6),z_min(7),z_min(8)
            if ((z_min(16).ge.z_dat(16)).and.(z_min(16).lt.z_dat(16)+0.9d0))
     &           then
               minflag = 1
               do i = 11,16
                  z_min(i) = z_dat(i)
               enddo
               goto 300
            endif
         enddo
 300     close(2)
         include 'inc/EventDist_BestFitPlot_ih.inc'
c         include 'inc/Analytic_dchi2_ih.inc'
c         include 'inc/BestFitData_ih.inc'
 400  continue

CCCCCCCCCCCCCCCCCCCCCC  F vs. L/E distributions  CCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCC                           CCCCCCCCCCCCCCCCCCCCCC
      elseif (imode.eq.3) then
         xmax = z_dat(16)/Emin
         xmin = z_dat(16)/Emax
         nbins = 10000 ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +(xmax-xmin)/dble(nbins)*i
         enddo

CCCCCCCCCCCCCCCCCCCCCC  Flux*Xsec*Pee vs. L/E  CCCCCCCCCCCCCCCCCCCCCCCC
         z_dat(15) = 12   ! Flux*Xsec vs. L/E    
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

         z_dat(15) = 13 
         z_dat(11) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="FluxXsecPeeNH_loe.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         z_dat(15) = 13 
         z_dat(11) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="FluxXsecPeeIH_loe.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

CCCCCCCCCCCCCCCCCCCCCCCCCC  dPee/d(L/E)  CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

         z_dat(15) = 14    ! Pee vs. L/E
         evform_dat = 2   ! 1:integer 2:real*8
         hmode = 0        ! 0:continuous 1:simpson 2:center-value 
         z_dat(11) = 1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="PeeNH_loe.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

         z_dat(11) = -1
         call MakeHisto1D(nout,hfunc1D,z_dat,nevent,nbins,x
     &        ,evform_dat,serror,snmax,hmode,event_dat,hevent_dat
     &        ,nevent_dat,ierr)
         open(1,file="PeeIH_loe.dat",status="replace")
         do i = 1,nbins
            write(1,*) x(i),hevent_dat(i),event_dat(i),nevent_dat
         enddo
         close(1)

CCCCCCCCCCCCCCCCCCCCCC  distributions with various L CCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCC                              CCCCCCCCCCCCCCCCCCCCCCCCC
      elseif (imode.eq.5) then
         include 'inc/Pee.inc'
         include 'inc/N.inc'

      elseif (imode.eq.6) then 
         open(1,file="dchi2_dmm13.dat",status="replace")
         do j = 1,16
            z(j) = z_dat(j)
         enddo
         dmm13min = z_dat(4)*(1d0 -0.04d0)
         dmm13max = z_dat(4)*(1d0 +0.04d0)
         ndmm13 = 1000
         do j = 1,ndmm13
            z(4) = dmm13min +(dmm13max -dmm13min)/dble(ndmm13)*j
            include 'inc/dchi2.inc'
            write(1,*) z(4),dchisq
         enddo
         close(1)
      endif

      return
      end
