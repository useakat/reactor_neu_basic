      program test
      implicitnone

      integer i,j,k
      integer ierr,lencm,npari,nparx,istat,ndiv,mode
      real*8 arg(10),pval(10),perr(10),plo(10),phi(10),gint
      real*8 chisqmin,fedm,errdef,Lmin,Lmax,Eres,s2sun_2(2)
      real*8 s213_2(2),dm21_2(2),dm31_2(2),Emin,Emax,serror,snmax
      character*10 name(10),iname,cLmin,cLmax,cndiv,cP,cV,CR,CY
      character*10 cEres,cmode
      
      integer iflag
      real*8 z(20),dchisq,grad,futil

      real*8 zz(40)
      common /zz/ zz

      integer lench
      external minfunc,lench

      call getarg(1,cLmin)
      call getarg(2,cLmax)
      call getarg(3,cndiv)
      call getarg(4,cP)
      call getarg(5,cV)
      call getarg(6,cR)
      call getarg(7,cY)
      call getarg(8,cEres)
      call getarg(9,cmode)
      read (cLmin,*) Lmin 
      read (cLmax,*) Lmax
      read (cndiv,*) ndiv 
      read (cP,*) zz(3) 
      read (cV,*) zz(4) 
      read (cR,*) zz(5) 
      read (cY,*) zz(6) 
      read (cEres,*) Eres 
      read (cmode,*) mode
      s2sun_2(1) = 0.852d0
      s2sun_2(2) = 0.025d0
      s213_2(1) = 0.1d0
      s213_2(2) = 0.01d0
      dm21_2(1) = 7.5d-5
      dm21_2(2) = 0.2d-5
      dm31_2(1) = 2.35d-3
      dm31_2(2) = 0.1d-3
      Emin = 1.81d0  
      Emax = 8d0
      serror = 1d-2
      snmax = 3

      zz(7) = Eres/100d0
      zz(8) = mode
      zz(9) = s2sun_2(1)
      zz(10) = s2sun_2(2)
      zz(11) = s213_2(1)
      zz(12) = s213_2(2)
      zz(13) = dm21_2(1)
      zz(14) = dm21_2(2)
      zz(15) = dm31_2(1)
      zz(16) = dm31_2(2)
      zz(17) = Emin
      zz(18) = Emax
      zz(19) = serror
      zz(20) = snmax

      open(19,file='dchi2_result.txt',status='replace')
      write(19,'(a11,e12.5,a3,e9.2)') "sin212_2 = ",s2sun_2(1)," +-"
     &     ,s2sun_2(2)
      write(19,'(a11,e12.5,a3,e9.2)') "sin213_2 = ",s213_2(1)," +-"
     &     ,s213_2(2)
      write(19,'(a11,e12.5,a3,e9.2)') "dm21_2 = ",dm21_2(1)," +-"
     &     ,dm21_2(2)
      write(19,'(a11,e12.5,a3,e9.2)') "dm31_2 = ",dm31_2(1)," +-"
     &     ,dm31_2(2)
      write(19,*) ""
      write(19,*) "Ev Range:",Emin," -",Emax," [MeV]"
c      write(19,*) "E_vis Resolusion:",Eres," [MeV]"
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
               write(19,*) "<NH case>"
            elseif (k.eq.-1) then
               open(20,file='minorm_ih.dat',status='replace')
               open(21,file='dchi2min_ih.dat',status='replace')
               write(19,*) "<IH case>"
            endif
            do j = 0,ndiv
               zz(1) = Lmin +( Lmax -Lmin )/dble(ndiv)*j
               write(19,*) zz(1),"[km]"               

               call mninit(5,20,7)
               
               call mnparm(1,'s2sun_2',s2sun_2(1),s2sun_2(2),0d0,0d0
     &              ,ierr)
               call mnparm(2,'s213_2',s213_2(1),s213_2(2),0d0,0d0,ierr)
               call mnparm(3,'dm12_2',dm21_2(1),dm21_2(2),0d0,0d0,ierr)
               call mnparm(4,'dm13_2',dm31_2(1),dm31_2(2),0d0,0d0,ierr)
               
               arg(1) = -1d0
               call mnexcm(minfunc,'SET PRINTOUT',arg,1,ierr,0)
c     call mnexcm(minfunc,'SIMPLEX',arg,0,ierr,0
               arg(1) = 1d0
               call mnexcm(minfunc,'MIGRAD',arg,0,ierr,0)
               
               do i = 1,4
                  call mnpout(i,name(i),pval(i),perr(i),plo(i),phi(i)
     &                 ,ierr)
               enddo
               call mnstat(chisqmin,fedm,errdef,npari,nparx,istat)

               write(21,'(e10.3,14e13.5)') zz(1),chisqmin,fedm
     &              ,pval(1),perr(1),(pval(1)-0.852d0)/0.025d0
     &              ,pval(2),perr(2),(pval(2)-0.1d0)/0.01d0
     &              ,pval(3),perr(3),(pval(3)-7.5d-5)/0.2d-5
     &              ,pval(4),perr(4),(pval(4)-2.35d-3)/0.1d-3
               write(19,'(4x,a14,e12.5,a3,e9.2)') "Delta-Chi2  = "
     &              ,chisqmin," +-",fedm
               write(19,'(4x,a14,e12.5,a3,e9.2)') "(sin2*12)^2 = "
     &              ,pval(1)," +-",perr(1)
               write(19,'(4x,a14,e12.5,a3,e9.2)') "(sin2*13)^2 = "
     &              ,pval(2)," +-",perr(2)
               write(19,'(4x,a14,e12.5,a3,e9.2)') "dm21^2      = "
     &              ,pval(3)," +-",perr(3)
               write(19,'(4x,a14,e12.5,a3,e9.2)') "dm31^2      = "
     &              ,pval(4)," +-",perr(4)
               write(19,*) ""
               call mncomd(minfunc,'SET OUTPUTFILE 19',iflag,0)
               call mncomd(minfunc,'SHOW COVARIANCE',iflag,0)
               write(19,*) ""
               write(19,*) ""
            enddo
            write(19,*) ""
            write(19,*) ""
         enddo
         close(19)
         close(20)
         close(21)

      elseif (mode.eq.1) then ! For F vs. dsqrt(E) distribution
         zz(1) = Lmin
         npari = 4
         do i = 1,npari
            z(i) = 1d0
         enddo
         call minfunc(npari,grad,dchisq,z,iflag,0)

      elseif (mode.eq.2) then ! For dN/dE plots
         npari = 4
         do i = 1,npari
            z(i) = 1d0
         enddo
         zz(1) = Lmin
         call minfunc(npari,grad,dchisq,z,iflag,0)

      elseif (mode.eq.3) then ! For F vs. L/E distribution
         zz(1) = Lmin
         npari = 4
         do i = 1,npari
            z(i) = 1d0
         enddo
         call minfunc(npari,grad,dchisq,z,iflag,0)

      elseif (mode.eq.4) then ! For F vs. E distribution
         zz(1) = Lmin
         npari = 4
         do i = 1,npari
            z(i) = 1d0
         enddo
         call minfunc(npari,grad,dchisq,z,iflag,0)

      endif

      end
