      program test
      implicitnone

      integer i,j,k
      integer ierr,lencm,npari,nparx,istat,ndiv
      real*8 arg(10),pval(10),perr(10),plo(10),phi(10),gint
      real*8 chisqmin,fedm,errdef,Lmin,Lmax,Eres
      character*10 name(10),iname,cLmin,cLmax,cndiv,cP,cV,CR,CY
      character*10 cEres

      real*8 zz(10)
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
      read (cLmin,*) Lmin 
      read (cLmax,*) Lmax
      read (cndiv,*) ndiv 
      read (cP,*) zz(3) 
      read (cV,*) zz(4) 
      read (cR,*) zz(5) 
      read (cY,*) zz(6) 
      read (cEres,*) Eres 
      zz(7) = Eres/100d0

      do k = -1,1,2
         zz(2) = k
         if (k.eq.1) then
            open(20,file='minorm_nh.dat')
            open(21,file='dchi2min_nh.dat')
         elseif (k.eq.-1) then
            open(20,file='minorm_ih.dat')
            open(21,file='dchi2min_ih.dat')
         endif
         do j = 0,ndiv
            zz(1) = Lmin +( Lmax -Lmin )/dble(ndiv)*j

            call mninit(5,20,7)
            
            call mnparm(1,'s2sun_2',0.852d0,0.025d0,0d0,1d0,ierr)
            call mnparm(2,'s213_2',0.1d0,0.01d0,0d0,1d0,ierr)
            call mnparm(3,'dm12_2',7.5d-5,0.2d-5,0d0,0d0,ierr)
            call mnparm(4,'dm13_2',2.35d-3,0.1d-3,0d0,0d0,ierr)
            
            arg(1) = 1d0
            call mnexcm(minfunc,'SET PRINTOUT',arg,1,ierr,0)
c            call mnexcm(minfunc,'SIMPLEX',arg,0,ierr,0)
            call mnexcm(minfunc,'MIGRAD',arg,0,ierr,0)

            do i = 1,4
               call mnpout(i,name(i),pval(i),perr(i),plo(i),phi(i),ierr)
            enddo
            call mnstat(chisqmin,fedm,errdef,npari,nparx,istat)
            write (20,*)
            write (20,'(5a7)') 'DELTA CHI2','ERROR','NPARAMS','NPARAMS'
     &           ,'ISTAT'
            write (20,'(2e14.7,3i10)') chisqmin,fedm,npari,nparx,istat
            write(21,*) zz(1),chisqmin
         enddo
      enddo
      close(20)
      close(21)

      end
