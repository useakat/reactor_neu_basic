      program test
      implicitnone

      integer i
      integer ierr,lencm,npari,nparx,istat
      real*8 arg(10),pval(10),perr(10),plo(10),phi(10),gint
      real*8 chisqmin,fedm,errdef
      character*10 name(10),iname

      real*8 zz(10)
      common /zz/ zz

      integer lench
      external minfunc,lench
      
      open(20,file='minorm.dat')

      zz(1) = 60d0

      call mninit(5,20,7)

      call mnparm(1,'s2sun_2',0.852d0,0.025d0,0d0,1d0,ierr)
      call mnparm(2,'s213_2',0.1d0,0.01d0,0d0,1d0,ierr)
      call mnparm(3,'dm12_2',7.5d-5,0.2d-5,0d0,0d0,ierr)
      call mnparm(4,'dm13_2',2.35d-3,0.1d-3,0d0,0d0,ierr)

      arg(1) = 1d0
      call mnexcm(minfunc,'SET PRINTOUT',arg,1,ierr,0)
c      call mnexcm(minfunc,'SIMPLEX',arg,0,ierr,0)
      call mnexcm(minfunc,'MIGRAD',arg,0,ierr,0)

      do i = 1,4
         call mnpout(i,name(i),pval(i),perr(i),plo(i),phi(i),ierr)
      enddo
      call mnstat(chisqmin,fedm,errdef,npari,nparx,istat)
      write (20,*)
      write (20,'(5a7)') 'DELTA CHI2','ERROR','NPARAMS','NPARAMS'
     &     ,'ISTAT'
      write (20,'(2e14.7,3i10)') chisqmin,fedm,npari,nparx,istat
      write (*,'(a10,4f15.5)') (name(i),pval(i),perr(i),plo(i),phi(i)
     &     ,i=1,4)
      write (*,*)
      write (*,'(a12,a11,a11,a10,a8)') 'DELTA CHIMIN','ERROR','NPARAMS'
     &     ,'NPARAMS','ISTAT'
      write (*,'(1x,e10.3,4x,e10.3,i6,i10,i9)') chisqmin,fedm,npari
     &     ,nparx,istat
      end
