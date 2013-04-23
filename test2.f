      program test
      implicitnone

      integer i,j,k
      integer ierr,lencm,npari,nparx,istat,ndiv,mode
      real*8 arg(10),pval(10),perr(10),plo(10),phi(10),gint
      real*8 chisqmin_true,fedm,errdef,Lmin,Lmax,Eres,s2sun_2(2),Eres_nl
      real*8 chisqmin_wrong,dchisqmin
      real*8 s213_2(2),dm21_2(2),dm31_2(2),Emin,Emax,serror,snmax
      real*8 ovnorm(2),fa(2),fb(2),value,fscale(2)
      character*10 name(10),iname,cLmin,cLmax,cndiv,cP,cV,cR,cY,ctheta
      character*10 cEres,cmode,cEres_nl,cvalue,cfixL,cfluc,cbinsize
      character*10 cnreactor
      
      integer iflag,ifixL,ifluc,nreactor
      real*8 z(20),dchisq,grad,futil,sensitivity
      real*8 mean_nh,error_nh,mean_error_nh,error_error_nh
      real*8 mean_ih,error_ih,mean_error_ih,error_error_ih
      real*8 mean_dchi2min_nh,mean_dchi2min_ih,binsize,theta

      real*8 zz(50)
      common /zz/ zz

      integer lench,time
      real*8 SigmaProb
      external minfunc,lench,time,SigmaProb

      integer ifirst
      real*8 final_bins
      common /first/ final_bins,ifirst

      integer nbins,iev
      real*8 event2_dat(20000),allevent,nevent_dat
      common /event_dat/ event2_dat,nevent_dat,nbins

      call getarg(1,cLmin)
      call getarg(2,cLmax)
      call getarg(3,cndiv)
      call getarg(4,cP)
      call getarg(5,cV)
      call getarg(6,cR)
      call getarg(7,cY)
      call getarg(8,cEres)
      call getarg(9,cEres_nl)
      call getarg(10,cmode)
      call getarg(11,cvalue)
      call getarg(12,cfixL)
      call getarg(13,cfluc)
      call getarg(14,cbinsize)
      call getarg(15,ctheta)
      call getarg(16,cnreactor)
      read (cLmin,*) Lmin 
      read (cLmax,*) Lmax
      read (cndiv,*) ndiv 
      read (cP,*) zz(3) 
      read (cV,*) zz(4) 
      read (cR,*) zz(5) 
      read (cY,*) zz(6) 
      read (cEres,*) Eres 
      read (cEres_nl,*) Eres_nl 
      read (cmode,*) mode
      read (cvalue,*) value
      read (cfixL,*) ifixL
      read (cfluc,*) ifluc
      read (cbinsize,*) binsize
      read (ctheta,*) theta
      read (cnreactor,*) nreactor
      s2sun_2(1) = 0.857d0
      s2sun_2(2) = 0.024d0
      s213_2(1) = 0.089d0
      s213_2(2) = 0.005d0
      dm21_2(1) = 7.50d-5
      dm21_2(2) = 0.20d-5
      dm31_2(1) = 2.32d-3
      dm31_2(2) = 0.1d-3
      ovnorm(1) = 1d0
      ovnorm(2) = 0.1d0
      fa(1) = 1d0
      fa(2) = 0.1d0
      fb(1) = 1d0
      fb(2) = 0.1d0
      fscale(1) = 0d0
      fscale(2) = 0.02d0

      Emin = 1.81d0  
      Emax = 8d0
      serror = 1d-4
      snmax = 10

      zz(10) = s2sun_2(1)
      zz(11) = s2sun_2(2)
      zz(12) = s213_2(1)
      zz(13) = s213_2(2)
      zz(14) = dm21_2(1)
      zz(15) = dm21_2(2)
      zz(16) = dm31_2(1)
      zz(17) = dm31_2(2)
      zz(18) = ovnorm(1)
      zz(19) = ovnorm(2)
      zz(20) = fscale(1)
      zz(21) = fscale(2)
      zz(22) = fa(1)
      zz(23) = fa(2)
      zz(24) = fb(1)
      zz(25) = fb(2)

      zz(7) = Eres/100d0
      zz(8) = mode
      zz(30) = Emin
      zz(31) = Emax
      zz(32) = serror
      zz(33) = snmax
      zz(34) = Eres_nl
      zz(35) = ndiv
      zz(37) = ifluc
      zz(38) = binsize
      zz(39) = theta
      zz(40) = nreactor

      call gran_init(time())
c      call gran_init(200)

      open(19,file='dchi2_result.txt',status='replace')
      write(19,'(a11,e12.5,a3,e9.2)') "sin212_2 = ",s2sun_2(1)," +-"
     &     ,s2sun_2(2)
      write(19,'(a11,e12.5,a3,e9.2)') "sin213_2 = ",s213_2(1)," +-"
     &     ,s213_2(2)
      write(19,'(a11,e12.5,a3,e9.2)') "dm21_2 = ",dm21_2(1)," +-"
     &     ,dm21_2(2)
      write(19,'(a11,e12.5,a3,e9.2)') "dm31_2 = ",dm31_2(1)," +-"
     &     ,dm31_2(2)
      write(19,'(a11,e12.5,a3,e9.2)') "ovnorm = ",ovnorm(1)," +-"
     &     ,ovnorm(2)
      write(19,'(a11,e12.5,a3,e9.2)') "fscale = ",fscale(1)," +-"
     &     ,fscale(2)
      write(19,'(a11,e12.5,a3,e9.2)') "fa = ",fa(1)," +-"
     &     ,fa(2)
      write(19,'(a11,e12.5,a3,e9.2)') "fb = ",fb(1)," +-"
     &     ,fb(2)
      write(19,*) ""
      write(19,*) "Ev Range:",Emin," -",Emax," [MeV]"
      write(19,*) ""
      write(19,*) "( Simpson Integration Parameters )"
      write(19,*) "Accuracy:",serror
      write(19,*) "Max division = 2^",snmax+1
      write(19,*) ""
      write(19,*) ""
      write(19,*) "[Delta-Chi2 analysis]"

      if (mode.eq.0) then
         do k = -1,1,2
            zz(2) = k
            if (k.eq.1) then
               open(20,file='minorm_nh.dat',status='replace')
               open(21,file='dchi2min_nh.dat',status='replace')
               open(22,file='dchi2min_bestfit2nh.dat',status='replace')
               open(23,file='dchi2_vsparam_nh.dat',status='replace')
               open(25,file='dchi2_dist_nh.dat',status='replace')
               open(26,file='sensitivity_dist_nh.dat',status='replace')
               write(19,*) "<NH case>"
            elseif (k.eq.-1) then
               open(20,file='minorm_ih.dat',status='replace')
               open(21,file='dchi2min_ih.dat',status='replace')
               open(22,file='dchi2min_bestfit2ih.dat',status='replace')
               open(23,file='dchi2_vsparam_ih.dat',status='replace')
               open(25,file='dchi2_dist_ih.dat',status='replace')
               open(26,file='sensitivity_dist_ih.dat',status='replace')
               write(19,*) "<IH case>"
            endif
            do j = 0,ndiv
               ifirst = 0
               if (ifixL.eq.0) then
                  zz(1) = Lmin +( Lmax -Lmin )/dble(ndiv)*j
               elseif (ifixL.eq.1) then
                  if (zz(2).eq.1) zz(1) = Lmin
                  if (zz(2).eq.-1) zz(1) = Lmax
               endif
               write(19,*) zz(1),"[km]"               
               call mninit(5,20,7)
               
               call mnparm(1,'s2sun_2',s2sun_2(1),s2sun_2(2),0d0,0d0
     &              ,ierr)
               call mnparm(2,'s213_2',s213_2(1),s213_2(2),0d0,0d0,ierr)
               call mnparm(3,'dm21_2',dm21_2(1),dm21_2(2),0d0,0d0,ierr)
               call mnparm(4,'dm31_2',dm31_2(1),dm31_2(2),0d0,0d0,ierr)
               call mnparm(5,'Norm',ovnorm(1),ovnorm(2),0d0,0d0,ierr)
               call mnparm(6,'fscale',fscale(1),fscale(2),0d0,0d0,ierr)
               call mnparm(7,'fa',fa(1),fa(2),0d0,0d0,ierr)
               call mnparm(8,'fb',fb(1),fb(2),0d0,0d0,ierr)
               call mncomd(minfunc,'FIX 6',iflag,0)
               call mncomd(minfunc,'FIX 7',iflag,0)
               call mncomd(minfunc,'FIX 8',iflag,0)

               arg(1) = 0d0
               call mnexcm(minfunc,'SET PRINTOUT',arg,1,ierr,0)
c               call mnexcm(minfunc,'SIMPLEX',arg,0,ierr,0)

               zz(36) = 1
               call mnexcm(minfunc,'MIGRAD',arg,0,ierr,0)
               call mnstat(chisqmin_true,fedm,errdef,npari,nparx,istat)
               zz(36) = -1
               call mnexcm(minfunc,'MIGRAD',arg,0,ierr,0)
               call mnstat(chisqmin_wrong,fedm,errdef,npari,nparx,istat)

               dchisqmin = chisqmin_wrong -chisqmin_true
c               dchisqmin = chisqmin_true
               if (dchisqmin.gt.0d0) then
                  sensitivity = SigmaProb(dsqrt(dchisqmin))
               else
                  sensitivity = 0d0
               endif

               do i = 1,nparx
                  call mnpout(i,name(i),pval(i),perr(i),plo(i),phi(i)
     &                 ,ierr)
               enddo

               if (ifixL.eq.1) write(25,*) dchisqmin
               if (ifixL.eq.1) write(26,'(e22.15,1x,e12.5)') sensitivity,dchisqmin
               write(21,'(e10.3,34e13.5,e10.3)') zz(1),dchisqmin,fedm
     &              ,pval(1),perr(1),s2sun_2(2),(pval(1)-s2sun_2(1))/s2sun_2(2)
     &              ,pval(2),perr(2),s213_2(2),(pval(2)-s213_2(1))/s213_2(2)
     &              ,pval(3),perr(3),dm21_2(2),(pval(3)-dm21_2(1))/dm21_2(2)
     &              ,pval(4),perr(4),dm31_2(2),(pval(4)-dm31_2(1))/dm31_2(2)
     &              ,pval(5),perr(5),ovnorm(2),(pval(5)-ovnorm(1))/ovnorm(2)
     &              ,pval(6),perr(6),fscale(2),(pval(6)-fscale(1))/fscale(2)
     &              ,pval(7),perr(7),fa(2),(pval(7)-fa(1))/fa(2)
     &              ,pval(8),perr(8),fb(2),(pval(8)-fb(1))/fb(2)
     &              ,final_bins
               write(22,'(e10.3,8e13.5)') zz(1),pval(1),pval(2),pval(3)
     &              ,pval(4),pval(5),pval(6),pval(7),pval(8)

c               if ((zz(1).ge.50d0).and.(zz(1).lt.50.9d0)) then
c                  write(23,*) value, dchisqmin
c               endif
               write(19,'(4x,a14,e12.5,a3,e9.2)') "Delta-Chi2  = "
     &              ,dchisqmin," +-",fedm
               write(19,'(4x,a14,e12.5,a3,e9.2)') "(sin2*12)^2 = "
     &              ,pval(1)," +-",perr(1)
               write(19,'(4x,a14,e12.5,a3,e9.2)') "(sin2*13)^2 = "
     &              ,pval(2)," +-",perr(2)
               write(19,'(4x,a14,e12.5,a3,e9.2)') "dm21^2      = "
     &              ,pval(3)," +-",perr(3)
               write(19,'(4x,a14,e12.5,a3,e9.2)') "dm31^2      = "
     &              ,pval(4)," +-",perr(4)
               write(19,'(4x,a14,e12.5,a3,e9.2)') "Normalization = "
     &              ,pval(5)," +-",perr(5)
               write(19,'(4x,a14,e12.5,a3,e9.2)') "fscale = "
     &              ,pval(6)," +-",perr(6)
               write(19,'(4x,a14,e12.5,a3,e9.2)') "fa = "
     &              ,pval(7)," +-",perr(7)
               write(19,'(4x,a14,e12.5,a3,e9.2)') "fb = "
     &              ,pval(8)," +-",perr(8)
               write(19,*) ""
               write(19,*) "event # =",nevent_dat
               call mncomd(minfunc,'SET OUTPUTFILE 19',iflag,0)
               call mncomd(minfunc,'SHOW COVARIANCE',iflag,0)
               write(19,*) ""
               write(19,*) ""
c               if ( (ZZ(1).gt.48d0).and.(zz(1).lt.50d0)) then
c                  write(6,*) zz(2),zz(1),dchisqmin
c                  allevent = 0d0
c                  do iev = 1,nbins
c                     allevent = allevent +event2_dat(iev)
c                  enddo
c                  write(6,*) allevent
c               endif
            enddo
            write(19,*) ""
            write(19,*) ""           
         enddo
         close(19)
         close(20)
         close(21)
         close(22)
         close(23)
         close(25)
         close(26)

         if (ifixL.eq.1) then
            open(1,file="dchi2_dist_nh.dat",status="old")
            call get_mean_error(1,99,mean_dchi2min_nh,error_nh
     &           ,mean_error_nh,error_error_nh)
            close(1)
            open(1,file="dchi2_dist_ih.dat",status="old")
            call get_mean_error(1,99,mean_dchi2min_ih,error_ih
     &           ,mean_error_ih,error_error_ih)
            close(1)
            open(1,file="dchi2_error_nh.dat",status="replace")
           write(1,*) Lmin,mean_dchi2min_nh,error_nh,mean_error_nh,error_error_nh
            close(1)
            open(1,file="dchi2_error_ih.dat",status="replace")
           write(1,*) Lmin,mean_dchi2min_ih,error_ih,mean_error_ih,error_error_ih
            close(1)

            open(1,file="sensitivity_dist_nh.dat",status="old")
            call get_mean_error(1,99,mean_nh,error_nh,mean_error_nh
     &           ,error_error_nh)
            close(1)
            open(1,file="sensitivity_dist_ih.dat",status="old")
            call get_mean_error(1,99,mean_ih,error_ih,mean_error_ih
     &           ,error_error_ih)
            close(1)
            open(1,file="sensitivity_error_nh.dat",status="replace")
           write(1,*) mean_dchi2min_nh,mean_nh,error_nh,mean_error_nh,error_error_nh
            close(1)
            open(1,file="sensitivity_error_ih.dat",status="replace")
           write(1,*) mean_dchi2min_ih,mean_ih,error_ih,mean_error_ih,error_error_ih
            close(1)
c            write(6,*) "stat"
c            write(6,*) "nh", mean_nh,error_nh
c            write(6,*) "ih", mean_ih,error_ih
         endif

      elseif (mode.eq.1) then ! For F vs. dsqrt(E) distribution
c         zz(1) = Lmin
         npari = 10
         do i = 1,npari
            z(i) = 1d0
         enddo
         call minfunc(npari,grad,dchisq,z,iflag,0)

      elseif (mode.eq.2) then ! For dN/dE plots
         npari = 10
         do i = 1,npari
            z(i) = 1d0
         enddo
         zz(1) = Lmin
         call minfunc(npari,grad,dchisq,z,iflag,0)

      elseif (mode.eq.3) then ! For F vs. L/E distribution
         zz(1) = Lmin
         npari = 10
         do i = 1,npari
            z(i) = 1d0
         enddo
         call minfunc(npari,grad,dchisq,z,iflag,0)

      elseif (mode.eq.4) then ! For F vs. E distribution
         zz(1) = Lmin
         npari = 10
         do i = 1,npari
            z(i) = 1d0
         enddo
         call minfunc(npari,grad,dchisq,z,iflag,0)

      elseif (mode.eq.5) then ! For dN/dE distribution
         zz(1) = Lmin
         npari = 10
         do i = 1,npari
            z(i) = 1d0
         enddo
         call minfunc(npari,grad,dchisq,z,iflag,0)

      endif

      end
