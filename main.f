      program main
      implicitnone

      integer i,j,k
      integer ierr,npari,nparx,istat,ndiv,mode
      real*8 arg(10),pval(10),perr(10),plo(10),phi(10)
      real*8 chisqmin_true,fedm,errdef,Lmin,Lmax,Eres_a,Eres_b
      real*8 chisqmin_wrong,dchisqmin
      real*8 s213_2,dm21_2,dm31_2,s212_2,Emin,Emax,serror,snmax
      real*8 ovnorm,value,fscale(2)
      character*10 name(10),iname,cLmin,cLmax,cndiv,cP,cV,cR,cY,ctheta
      character*10 cEres_a,cEres_b,cmode,cLscan,cfluc,cbinsize
      character*10 cnreactor,cxx,cyy,creactor_mode,creactor_type,cxsec
      character*10 cPee
      integer iflag,iLscan,ifluc,nreactor,ireactor_mode,ireactor_type
      integer iPee,ixsec
      real*8 z(20),dchisq,grad,nevent_dat
      real*8 mean_nh,error_nh,mean_error_nh,error_error_nh
      real*8 mean_ih,error_ih,mean_error_ih,error_error_ih
      real*8 mean_dchi2min_nh,mean_dchi2min_ih,binsize,theta
      real*8 xx,yy,dchi_rej,dchi_acc,ovnorm_geo
      integer ndetermined,nmissed
      real*8 fs212_2(2),fs213_2(2),fdm21_2(2),fdm31_2(2),fovnorm(2)
      real*8 fovnorm_geo(2),fEres_a(2),fEres_b(2)
      common /parm0/ fs212_2,fs213_2,fdm21_2,fdm31_2,fovnorm,fovnorm_geo,fEres_a,fEres_b
      real*8 zz(50)
      common /zz/ zz
      integer ifirst
      real*8 final_bins
      common /first/ final_bins,ifirst
      integer nbins
      common /event_dat/ nbins
      external minfunc
ccc
ccc input arguments for main.f
ccc
      call getarg(1,cLmin)
      call getarg(2,cLmax) 
      call getarg(3,cndiv) 
      call getarg(4,cP) 
      call getarg(5,cV) 
      call getarg(6,cR) 
      call getarg(7,cY) 
      call getarg(8,cEres_a) 
      call getarg(9,cEres_b) 
      call getarg(10,cmode) 
      call getarg(11,cLscan) 
      call getarg(12,cfluc) 
      call getarg(13,cbinsize)
      call getarg(14,cxsec)
      call getarg(15,cPee)

cc convert charactor to integer or real*8
      read (cLmin,*) Lmin 
      read (cLmax,*) Lmax
      read (cndiv,*) ndiv 
      read (cP,*) zz(3) 
      read (cV,*) zz(4) 
      read (cR,*) zz(5) 
      read (cY,*) zz(6) 
      read (cEres_a,*) Eres_a 
      read (cEres_b,*) Eres_b 
      read (cmode,*) mode
      read (cLscan,*) iLscan
      read (cfluc,*) ifluc
      read (cbinsize,*) binsize
      read (cxsec,*) ixsec
      read (cPee,*) iPee

ccc Oscillation parameter settings
      s212_2 = 0.857d0  ! sin(theta_12)^2
      s213_2 = 0.0935d0 ! sin(theta_13)^2
      dm21_2 = 7.50d-5  ! delta_m^2_21 (=m^2_2 -m^2_1)
      dm31_2 = 2.32d-3  ! delta_m^2_31 (=m^2_3 -m^2_1)
c NOTE: dm32_2(=m^2_3 -m^2_2) is calculated as delta_m^2_31 -deltam^2_21
      ovnorm = 1d0  ! overall normalization factor of the detected reactor-neutrino event number
      ovnorm_geo = 1d0 ! overall normalization factor of the detected geo-neutrino event number

ccc System parameters for chi^2 fitting ! Users do not need to modify here.
c In the following, fparam(1) is an initial value of the parameter to find a chi^2 minimum
c               and fparam(2) is an uncertainty of the parameter. 
      fs212_2(1) = s212_2
      fs212_2(2) = 0.024d0
      fs213_2(1) = s213_2
      fs213_2(2) = 0.005d0 
      fdm21_2(1) = dm21_2
      fdm21_2(2) = 0.20d-5  
      fdm31_2(1) = dm31_2
      fdm31_2(2) = 0.1d-3
      fovnorm(1) = ovnorm
      fovnorm(2) = 0.03*fovnorm(1)  
      fovnorm_geo(1) = ovnorm_geo 
      fovnorm_geo(2) = 0.3*fovnorm_geo(1)  
      fEres_a(1) = Eres_a/100d0
      fEres_a(2) = 0.1*fEres_a(1)
      fEres_b(1) = Eres_b/100d0
      fEres_b(2) = 0.1*fEres_b(1)
c      fscale(1) = 0d0    
c      fscale(2) = 0.02d0

ccc Information for bining of reconstructed energy distributions
      Emin = 1.81d0 ! minimum neutrino energy to be used for a chi^2 fitting
      Emax = 8d0    ! maximum neutrino energy to be used for a chi^2 fitting

ccc Parameters for simpson numerical integration method. (used for making binned data (theoretical/experimental))
      serror = 0.001 ! precision for the numerical integration (relative precision). default: 0.001 (= 0.1%)
      snmax = 10    ! maximum number of iteration for numerical convergence.

ccc Setting parameters in z arrays to pass them to chi^2 fitting routine.
      zz(7) = Eres_a/100d0
      zz(8) = mode

      zz(10) = s212_2
      zz(11) = fs212_2(2)
      zz(12) = s213_2
      zz(13) = fs213_2(2)
      zz(14) = dm21_2
      zz(15) = fdm21_2(2)
      zz(16) = dm31_2
      zz(17) = fdm31_2(2)

      zz(18) = ovnorm
      zz(19) = fovnorm(2)
      zz(22) = Eres_a/100d0
      zz(23) = fEres_a(2)
      zz(24) = Eres_b/100d0
      zz(25) = fEres_b(2)
      zz(26) = ovnorm_geo
      zz(27) = fovnorm_geo(2)
c      zz(20) = fscale(1)
c      zz(21) = fscale(2)

      zz(30) = Emin
      zz(31) = Emax
      zz(32) = serror
      zz(33) = snmax
      zz(34) = Eres_b/100d0
      zz(35) = ndiv
      zz(37) = ifluc
      zz(38) = binsize
c      zz(39) = theta
c      zz(40) = nreactor
c      zz(41) = xx
c      zz(42) = yy
c      zz(43) = ireactor_mode
c      zz(44) = ireactor_type
      zz(45) = ixsec
      zz(46) = iPee

ccc initialization of random variables
c      call gran_init(time()) ! use machine time for initialization
      call gran_init(200) ! use a specific seed for initialization

ccc Write down informations of chi^2 fitting
      open(19,file='dchi2_result.txt',status='replace')
      write(19,'(a11,e12.5,a3,e9.2)') "sin212_2 = ",s212_2," +-"
     &     ,fs212_2(2)
      write(19,'(a11,e12.5,a3,e9.2)') "sin213_2 = ",s213_2," +-"
     &     ,fs213_2(2)
      write(19,'(a11,e12.5,a3,e9.2)') "dm21_2 = ",dm21_2," +-"
     &     ,fdm21_2(2)
      write(19,'(a11,e12.5,a3,e9.2)') "dm31_2 = ",dm31_2," +-"
     &     ,fdm31_2(2)
      write(19,'(a11,e12.5,a3,e9.2)') "ovnorm = ",ovnorm," +-"
     &     ,fovnorm(2)
c      write(19,'(a11,e12.5,a3,e9.2)') "fscale = ",fscale(1)," +-"
c     &     ,fscale(2)
      write(19,'(a11,e12.5,a3,e9.2)') "Eres_a = ",Eres_a/100d0," +-"
     &     ,fEres_a(2)
      write(19,'(a11,e12.5,a3,e9.2)') "Eres_b = ",Eres_b/100d0," +-"
     &     ,fEres_b(2)
      write(19,'(a11,e12.5,a3,e9.2)') "ovnorm_geo = 
     &     ",ovnorm_geo," +-",fovnorm_geo(2)
      write(19,*) ""
      write(19,*) "Ev Range:",Emin," -",Emax," [MeV]"
      write(19,*) ""
      write(19,*) "( Simpson Integration Parameters )"
      write(19,*) "Accuracy:",serror
      write(19,*) "Max division = 2^",snmax+1
      write(19,*) ""
      write(19,*) ""
      write(19,*) "[Delta-Chi2 analysis]"

c      if (mode.eq.0) then
      do k = 1,-1,-2            ! loop over mass hierarchies 1:NH -1:IH
         zz(2) = k  ! mass hierarchy
         if (k.eq.1) then
c            open(20,file='minorm_nh.dat',status='replace')
            open(21,file='dchi2min_nh.dat',status='replace')
            open(22,file='dchi2min_bestfit2nh.dat',status='replace')
c            open(23,file='dchi2_vsparam_nh.dat',status='replace')
            open(25,file='dchi2_dist_nh.dat',status='replace')
c            open(26,file='sensitivity_dist_nh.dat',status='replace')
c            open(27,file='dchi2_multi_nh.dat',status='replace')
c            open(28,file='dchi2_prob_nh.dat',status='replace')
c            open(29,file='dchi2_paramdist_nh.dat',status='replace')
            open(30,file='dchi2min_L_nh.dat',status='replace')
            write(19,*) "<NH case>"
         elseif (k.eq.-1) then
c            open(20,file='minorm_ih.dat',status='replace')
            open(21,file='dchi2min_ih.dat',status='replace')
            open(22,file='dchi2min_bestfit2ih.dat',status='replace')
c            open(23,file='dchi2_vsparam_ih.dat',status='replace')
c            open(25,file='dchi2_dist_ih.dat',status='replace')
c            open(26,file='sensitivity_dist_ih.dat',status='replace')
c            open(27,file='dchi2_multi_ih.dat',status='replace')
c            open(28,file='dchi2_prob_nh.dat',status='replace')
            open(29,file='dchi2_paramdist_ih.dat',status='replace')
            open(30,file='dchi2min_L_ih.dat',status='replace')
            write(19,*) "<IH case>"
         endif
c         ndetermined = 0
c         nmissed = 0
         
         do j = 0,ndiv  ! loop for many pseudo-experiments or baseline-length scan 
            ifirst = 0  ! check whether this is the first iteration of the loop

            zz(1) = Lmin +( Lmax -Lmin )/dble(ndiv)*j ! set baseline length L
            write(19,*) zz(1),"[km]"               

ccc MINUIT chi^2 minimization setting 
            call mninit(5,20,7) ! Initialization of MINUIT fitting parameters           
            ! Setting fitting parameters to MINUIT
            call mnparm(1,'s212_2',fs212_2(1),fs212_2(2),0d0,0d0,ierr)
            call mnparm(2,'s213_2',fs213_2(1),fs213_2(2),0d0,0d0,ierr)
            call mnparm(3,'dm21_2',fdm21_2(1),fdm21_2(2),0d0,0d0,ierr)
            call mnparm(4,'dm31_2',fdm31_2(1),fdm31_2(2),0d0,0d0,ierr)
            call mnparm(5,'Norm',fovnorm(1),fovnorm(2),0d0,0d0,ierr)
            call mnparm(6,'Norm geo-neutrino',fovnorm_geo(1),fovnorm_geo(2),0d0,0d0,ierr)
            call mnparm(7,'Eres_a',fEres_a(1),fEres_a(2),0d0,0d0,ierr)
            call mnparm(8,'Eres_b',fEres_b(1),fEres_b(2),0d0,0d0,ierr)
c            call mnparm(9,'fscale',fscale(1),fscale(2),0d0,0d0,ierr)
            ! Setting fixed parameters (treated as a constant in the chi^2 minimization)
            call mncomd(minfunc,'FIX 6',iflag,0) ! fovnorm_geo is fixed to fovnorm_geo(1)
            call mncomd(minfunc,'FIX 7',iflag,0) ! Eres_a is fixed to fa(1)
            call mncomd(minfunc,'FIX 8',iflag,0) ! Eres_b is fixed to fb(1)
            
ccc PRINT out MINUIT information
            arg(1) = 0d0 
            call mnexcm(minfunc,'SET PRINTOUT',arg,1,ierr,0)

ccc chi^2 minimization with MINUIT            
            zz(36) = 1          ! chi^2 fitting with the true mass hierarchy 
            call mnexcm(minfunc,'MIGRAD',arg,0,ierr,0)
            call mnstat(chisqmin_true,fedm,errdef,npari,nparx,istat)
            zz(36) = -1         ! chi^2 fitting with the wrong mass hierarchy
            call mnexcm(minfunc,'MIGRAD',arg,0,ierr,0)
            call mnstat(chisqmin_wrong,fedm,errdef,npari,nparx,istat)
            dchisqmin = chisqmin_wrong -chisqmin_true
            
ccc get minimization information
            do i = 1,nparx
               call mnpout(i,name(i),pval(i),perr(i),plo(i),phi(i)
     &              ,ierr)
            enddo
            

            if (iLscan.eq.1) write(25,*) dchisqmin,nbins
c            if (iLscan.eq.1) write(26,'(e22.15,1x,e12.5)') sensitivity,dchisqmin
c            if (nreactor.ge.1) then
c               write(27,*) theta, zz(1),dchisqmin
c            elseif (nreactor.le.-1) then
c               write(27,*) xx,yy,dchisqmin
c            endif
            write(30,*) zz(1),dchisqmin
            write(21,'(e10.3,38e13.5,e10.3)') zz(1),dchisqmin,fedm
     &           ,pval(1),perr(1),fs212_2(2),(pval(1)-fs212_2(1))/fs212_2(2)
     &           ,pval(2),perr(2),fs213_2(2),(pval(2)-fs213_2(1))/fs213_2(2)
     &           ,pval(3),perr(3),fdm21_2(2),(pval(3)-fdm21_2(1))/fdm21_2(2)
     &           ,pval(4),perr(4),fdm31_2(2),(pval(4)-fdm31_2(1))/fdm31_2(2)
     &           ,pval(5),perr(5),fovnorm(2),(pval(5)-fovnorm(1))/fovnorm(2)
c     &           ,pval(9),perr(9),fscale(2),(pval(9)-fscale(1))/fscale(2)
     &           ,pval(7),perr(7),fEres_a(2),(pval(7)-fEres_a(1))/fEres_a(2)
     &           ,pval(8),perr(8),fEres_b(2),(pval(8)-fEres_b(1))/fEres_b(2)
     &           ,pval(6),perr(6),fovnorm_geo(2)
     &           ,(pval(6)-fovnorm_geo(1))/fovnorm_geo(2)
     &           ,final_bins
            write(22,'(e10.3,9e13.5)') zz(1),pval(1),pval(2),pval(3)
     &           ,pval(4),pval(5),pval(6),pval(7),pval(8)
            
c            write(29,'(2e13.5)') pval(3),perr(3)
            
c     if ((zz(1).ge.50d0).and.(zz(1).lt.50.9d0)) then
c     write(23,*) value, dchisqmin
c     endif
            write(19,'(4x,a14,e12.5,a3,e9.2)') "Delta-Chi2  = "
     &           ,dchisqmin," +-",fedm
            write(19,'(4x,a14,e12.5,a3,e9.2)') "(sin2*12)^2 = "
     &           ,pval(1)," +-",perr(1)
            write(19,'(4x,a14,e12.5,a3,e9.2)') "(sin2*13)^2 = "
     &           ,pval(2)," +-",perr(2)
            write(19,'(4x,a14,e12.5,a3,e9.2)') "dm21^2      = "
     &           ,pval(3)," +-",perr(3)
            write(19,'(4x,a14,e12.5,a3,e9.2)') "dm31^2      = "
     &           ,pval(4)," +-",perr(4)
            write(19,'(4x,a14,e12.5,a3,e9.2)') "Normalization = "
     &           ,pval(5)," +-",perr(5)
c            write(19,'(4x,a14,e12.5,a3,e9.2)') "fscale = "
c     &           ,pval(9)," +-",perr(9)
            write(19,'(4x,a14,e12.5,a3,e9.2)') "Eres_a = "
     &           ,pval(7)," +-",perr(7)
            write(19,'(4x,a14,e12.5,a3,e9.2)') "Eres_b = "
     &           ,pval(8)," +-",perr(8)
            write(19,'(4x,a14,e12.5,a3,e9.2)') "Norm. geo-neutrino = "
     &           ,pval(6)," +-",perr(6)
            write(19,*) ""
            write(19,*) "event # =",nevent_dat
            call mncomd(minfunc,'SET OUTPUTFILE 19',iflag,0)
            call mncomd(minfunc,'SHOW COVARIANCE',iflag,0)
            write(19,*) ""
            write(19,*) ""
c     if ( (ZZ(1).gt.48d0).and.(zz(1).lt.50d0)) then
c     write(6,*) zz(2),zz(1),dchisqmin
c     allevent = 0d0
c     do iev = 1,nbins
c     allevent = allevent +event2_dat(iev)
c     enddo
c     write(6,*) allevent
c     endif
         enddo
         write(19,*) ""
         write(19,*) ""           
c         write(28,*) ndetermined/dble(ndiv),nmissed/dble(ndiv) 
      enddo
      close(19)
c      close(20)
      close(21)
      close(22)
c      close(23)
      close(25)
c      close(26)
c      close(27)
c      close(28)
c      close(29)
      close(30)
      
C$$$      if (iLscan.eq.0) then
C$$$         if (zz(2).eq.1) then
C$$$            open(1,file="dchi2_dist_nh.dat",status="old")
C$$$            call get_mean_error(1,99,mean_dchi2min_nh,error_nh
C$$$     &           ,mean_error_nh,error_error_nh)
C$$$            close(1)
C$$$            open(1,file="dchi2_error_nh.dat",status="replace")
C$$$            write(1,*) Lmin,mean_dchi2min_nh,error_nh,mean_error_nh,error_error_nh
C$$$            close(1)
C$$$c            open(1,file="sensitivity_dist_nh.dat",status="old")
C$$$c            call get_mean_error(1,99,mean_nh,error_nh,mean_error_nh
C$$$c     &           ,error_error_nh)
C$$$c            close(1)
C$$$c            open(1,file="sensitivity_error_nh.dat",status="replace")
C$$$c            write(1,*) mean_dchi2min_nh,mean_nh,error_nh,mean_error_nh,error_error_nh
C$$$c            close(1)
C$$$         elseif (zz(2).eq.-1) then
C$$$            open(1,file="dchi2_dist_ih.dat",status="old")
C$$$            call get_mean_error(1,99,mean_dchi2min_ih,error_ih
C$$$     &           ,mean_error_ih,error_error_ih)
C$$$            close(1)
C$$$            open(1,file="dchi2_error_ih.dat",status="replace")
C$$$            write(1,*) Lmin,mean_dchi2min_ih,error_ih,mean_error_ih,error_error_ih
C$$$            close(1)
C$$$c            open(1,file="sensitivity_dist_ih.dat",status="old")
C$$$c            call get_mean_error(1,99,mean_ih,error_ih,mean_error_ih
C$$$c     &           ,error_error_ih)
C$$$c            close(1)
C$$$c            open(1,file="sensitivity_error_ih.dat",status="replace")
C$$$c            write(1,*) mean_dchi2min_ih,mean_ih,error_ih,mean_error_ih,error_error_ih
C$$$c            close(1)
C$$$         else 
C$$$            write(*,*) "ERROR:main.f:Invalid zz(2)"
C$$$         endif
C$$$      endif
      
      end
