      program test
      implicitnone

      integer i,ndim,narg,ierr
      parameter (ndim=5,narg=10)
      integer nprm(ndim)
      real*8 vstrt(ndim),stp(ndim),arglis(narg)
      character*10 pnam(ndim)

      external bfunc

c     initialize Minuit, define I/O unit numbers
      call mninit(5,6,7)

c     define parameters, set initial values
      call mnparm(1 , 'Re(X)'   , 0d0    , 0.1d0, 0d0, 0d0, ierr)
      call mnparm(2 , 'Im(X)'   , 0d0    , 0.1d0, 0d0, 0d0, ierr)
      call mnparm(5 , 'Delta M' , 0.535d0, 0.1d0, 0d0, 0d0, ierr)
      call mnparm(10, 'T Kshort', 0.892d0, 0d0  , 0d0, 0d0, ierr)
      call mnparm(11, 'T Klong' , 0d0    , 0d0  , 0d0, 0d0, ierr)
      if (ierr.ne.0) then
         write(6,'(a,i)') 'unable to define parameter no.',i
         stop
      endif

c     set title
      call mnseti('test')

c     request FCN to read in data (ilfag=1)
      arglis(1) = 1d0
      call mnexcm(bfunc,'CALL FCN',arglis,1,ierr,0)
      arglis(1) = 5d0
      call mnexcm(bfunc,'FIX',arglis,1,ierr,0)
      arglis(1) = 0d0
      call mnexcm(bfunc,'SET PRINT',arglis,1,ierr,0)
      call mnexcm(bfunc,'migrad',arglis,0,ierr,0)
      arglis(1) = 3d0
      call mnexcm(bfunc,'call FCN',arglis,1,ierr,0)
      call mnexcm(bfunc,'stop',0d0,0,ierr,0)

      end


      subroutine prterr
      implicitnone

      integer i
      integer npari,nparx,istat
      real*8 fmin,fedm,errdef,eplus,eminus,eparab,globcc

      call mnstat(fmin,fedm,errdef,npari,nparx,istat)

      do i = 1,npari
         call mnerrs(-1,eplus,eminus,eparab,globcc)
         write (6,45) i,eplus,eminus,eparab,globcc
 45      format(5x,i5,4f12.6)
      enddo
      
      return
      end


      subroutine bfunc(npar,gin,f,x,iflag,futil)
      implicitnone

      integer i
      integer npar,iflag
      real*8 gin(*),x(*),futil,f

      integer mxbin,nbins,nevtot,igod
      parameter (mxbin=50)
      real*8 thplu(mxbin),thmin(mxbin),t(mxbin),evtp(mxbin),evtm(mxbin)
      real*8 xre,xim,dm,gams,gaml,gamls,sthplu,sthmin,ti,ehalf,sterm
      real*8 sevtp,sevtm,thplui,thmini,chi1,chisq,thp,evp
      real*8 chi2,thm,evm,th,nevplu,nevmin

      external futil

      data nbins,nevtot/ 30,250 /
      data (evtp(igod),igod=1,30)
     &     / 11., 9.,13.,13.,17., 9., 1., 7., 8., 9., 6., 4., 6., 3., 7.
     &      , 4., 7., 3., 8., 4., 6., 5., 7., 2., 7., 1., 4., 1., 4. 
     &      , 5. /
      data (evtm(igod),igod=1,30)
     &     /  0., 0., 0., 0., 0., 0., 0., 0., 1., 1., 0., 2., 1., 4., 4.
     &      , 2., 4., 2., 2., 0., 2., 3., 7., 2., 3., 6., 2., 4., 1. 
     &      , 5. /
      
c     define the parameters
      xre = x(1)
      xim = x(2)
      dm = x(5)
      gams = 1.0 / x(10)
      gaml = 1.0 / x(11)
      gamls = 0.5*( gaml +gams )
      
      if (iflag.ne.1) go to 300      

      sthplu = 0.
      sthmin = 0.
      do i =1,nbins
         t(i) = 0.1*dble(i)
         ti = t(i)

c     get function to be minimized
         ehalf = dexp(-ti*gamls)
         th = ( ( 1.0 -xre )**2 +xim**2 )*dexp(-ti*gaml)
         th = th +( ( 1.0 +xre )**2 +xim**2 )*dexp(-ti*gams)
         th = th -4.0*xim*dsin(dm*ti)*ehalf
         sterm = 2.0*( 1.0 -xre**2 -xim**2 )*dcos(dm*ti)*ehalf

         thplu(i) = th +sterm
         thmin(i) = th -sterm
         sthplu = sthplu +thplu(i)
         sthmin = sthmin +thmin(i)
      enddo

      nevplu = dble(nevtot)*( sthplu / ( sthplu +sthmin ) )
      nevmin = dble(nevtot)*( sthmin / ( sthplu +sthmin ) )

      sevtp = 0.
      sevtm = 0.
      do i = 1,nbins
         thplu(i) = thplu(i)*dble(nevplu) / sthplu
         thmin(i) = thmin(i)*dble(nevmin) / sthmin
         thplui = thplu(i)
         sevtp = sevtp +evtp(i)
         thmini = thmin(i)
         sevtm = sevtm +evtm(i)
      enddo

 300  chisq = 0.
      sthplu = 0.
      sthmin = 0.
      do i = 1,nbins
         ti = t(i)
         ehalf = dexp(-ti*gamls)
         th = ( ( 1.0 -xre )**2 +xim**2 )*dexp(-ti*gaml)
         th = th +( ( 1.0 +xre )**2 +xim**2 )*dexp(-ti*gams)
         th = th -4.0*xim*dsin(dm*ti)*ehalf
         sterm = 2.0*( 1.0 -xre**2 -xim**2 )*dcos(dm*ti)*ehalf
         thplu(i) = th +sterm
         thmin(i) = th -sterm
         sthplu = sthplu +thplu(i)
         sthmin = sthmin +thmin(i)
      enddo

      thp = 0.
      thm = 0.
      evp = 0.
      evm = 0.

      do i = 1,nbins
         thplu(i) = thplu(i)*sevtp / sthplu
         thmin(i) = thmin(i)*sevtm / sthmin
         thp = thp +thplu(i)
         thm = thm +thmin(i)
         evp = evp +evtp(i)
         evm = evm +evtm(i)
         if (evp.gt.3) then
            chi1 = ( evp -thp )**2 / evp
            chisq = chisq + chi1
            thp = 0.
            evp = 0.
         endif
         if (evm.gt.3) then
            chi2 = ( evm -thm )**2 / evm
            chisq = chisq +chi2
            thm = 0.
            evm = 0.
         endif
      enddo

      f = chisq

      return
      end


      subroutine get_func(z,ti,kfunc)
      
      implicit none

      real*8 z(10),ti
      
      real*8 kfunc(10)

      real*8 th,ehalf,xre,xim,dm,gamls,gaml,gams
      real*8 sterm,th

      gams = 1.0 / z(4) 
      gaml = 1.0 / z(5)
      gamls = 0.5*( gaml +gams )
      xre = z(1)
      xim = z(2)
      dm = z(3)

      ehalf = dexp(-ti*gamls)
      th = ( ( 1.0 -xre )**2 +xim**2 )*dexp(-ti*gaml)
      th = th +( ( 1.0 +xre )**2 +xim**2 )*dexp(-ti*gams)
      th = th -4.0*xim*dsin(dm*ti)*ehalf
      sterm = 2.0*( 1.0 -xre**2 -xim**2 )*dcos(dm*ti)*ehalf
      kfunc(1) = th +sterm
      kfunc(2) = th -sterm
         
      return
      end
