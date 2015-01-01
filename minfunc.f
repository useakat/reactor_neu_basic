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
      real*8 zz(50)
      common /zz/ zz
      integer ifirst
      real*8 final_bins
      common /first/ final_bins,ifirst
      real*8 fs212_2(2),fs213_2(2),fdm21_2(2),fdm31_2(2),fovnorm(2)
      real*8 fovnorm_geo(2),fEres_a(2),fEres_b(2)
      common /parm0/ fs212_2,fs213_2,fdm21_2,fdm31_2,fovnorm,fovnorm_geo,fEres_a,fEres_b
C     LOCAL VARIABLES 
      integer i,j
      integer nevent,nbins,evform_th,evform_dat,nmin,nout,snmax,hmode,ndiv
      integer maxnbin,imode,minflag,ierr,ierr1,ierr2,iswitch_smear,nnbins
      parameter (nout=6, maxnbin=20000)
      integer ifluc,nreactor
      real*8 x(0:maxnbin),z_dat(50),event_th(maxnbin),z(50)
      real*8 nevent_th,ans,erro,event_dat(maxnbin),nevent_dat,error(10)
      real*8 Emin,Emax,rootEmin,rootEmax,Eres_a,serror,rdx
      real*8 hevent_th(maxnbin),hevent_dat(maxnbin),xmin,xmax
      real*8 z_min(50),event_fit(maxnbin),nevent_fit(maxnbin),hevent_fit(maxnbin)
      real*8 event2_dat(maxnbin),event2_th(maxnbin),radchi2,rint_adchi2
      real*8 Eres_b,rdbin
      real*8 dmm13min,dmm13max,ndmm13,parm0(10)
      common /event_dat/ event2_dat,nevent_dat,nbins
C     EXTERNAL FUNCTIONS
      real*8 hfunc1D,dchi2,futil,adchi2,chi2_2
      real*8 gran,Evis,ddx,binfactor
      external hfunc1D,dchi2,futil,adchi2,chi2_2,gran
      integer nthdiv,multi_flag
      common /multi/ multi_flag
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
      z_dat(6) = zz(26)
      z_dat(7) = zz(22)
      z_dat(8) = zz(24)
c      z_dat(9) = zz(20)

      parm0(1) = fs212_2(1)
      parm0(2) = fs213_2(1)
      parm0(3) = fdm21_2(1)
      parm0(4) = fdm31_2(1)
      parm0(5) = fovnorm(1)
      parm0(6) = fovnorm_geo(1)
      parm0(7) = fEres_a(1)
      parm0(8) = fEres_b(1)
c      parm0(9) = zz(20)

      error(1) = fs212_2(2)
      error(2) = fs213_2(2)
      error(3) = fdm21_2(2)
      error(4) = fdm31_2(2)
      error(5) = fovnorm(2)
      error(6) = fovnorm_geo(2)
      error(7) = fEres_a(2)
      error(8) = fEres_b(2)
c      error(9) = zz(21)

      z_dat(11) = zz(2)                  ! NH/IH
      z_dat(12) = zz(4)*zz(5)*1d9*avog   ! N_target
      z_dat(13) = zz(3)                  ! Power [GW]
      z_dat(14) = zz(6)*y2s              ! Exposure time [s]
      z_dat(15) = 20                     ! hfunc1D mode, 0: dN/d[sqrt(E)] 1:d(flux*Xsec)/d[sqrt(E)]
c      z_dat(15) = 100                   ! hfunc1D mode, 0: dN/d[sqrt(E)] 1:d(flux*Xsec)/d[sqrt(E]
      z_dat(16) = zz(1)                  ! L [km]
c      z_dat(17) = zz(39)  ! theta
c      z_dat(18) = zz(40)  ! nr
c      z_dat(19) = zz(41)  ! tokei
c      z_dat(20) = zz(42)  ! hokui
c      z_dat(21) = zz(43)  ! reactor_mode
c      z_dat(22) = zz(44)  ! reactor_type
c      z_dat(23) = zz(45)  ! ixsec
      z_dat(24) = zz(46)  ! iPee

      z(11) = zz(36)*z_dat(11)              
c      z(11) = z_dat(11)
      z(12) = z_dat(12)
      z(13) = z_dat(13)
      z(14) = z_dat(14)
      z(15) = z_dat(15)
      z(16) = z_dat(16)
      z(17) = z_dat(17)
c      z(18) = z_dat(18)
c      z(19) = z_dat(19)
c      z(20) = z_dat(20)
c      z(21) = z_dat(21)
c      z(22) = z_dat(22)
c      z(23) = z_dat(23)
      z(24) = z_dat(24)

      serror = zz(32)
      snmax = zz(33)
      Emin = zz(30)  ! Emin > 1.80473
      Emax = zz(31)
      ndiv = zz(35)
      ifluc = zz(37)

      nevent = 0
      rdx = zz(38)
      nnbins = 1000

      multi_flag = 0
CCCCCCCCCCCCCCCCCCCCCCCC  For Delta Chi^2 minimization  CCCCCCCCCCCCCCCCCCCCCCCCCCC
c      if (imode.eq.0) then 
c         if (zz(40).ge.1) then
c            multi_flag = 1 ! YongGwang reactors
c         elseif (zz(40).le.-1) then
c            multi_flag = 2 ! reactors in Korea
c         endif 
         if (ifluc.eq.0) then
            include 'inc/dchi2.inc' ! without statistical fluctuations
         elseif (ifluc.eq.1) then
            include 'inc/dchi2_stat.inc' ! with statistical fluctuations
         endif 
c      endif

      return
      end

