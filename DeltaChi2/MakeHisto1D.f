      subroutine MakeHisto1D(nout,f,z,nevent,nbins,x,evform,error,nmax
     &     ,mode,event,hevent,nevent_th,ierr)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS AUG 25 2012
C
C     
C     ****************************************************
      implicit none

C     ARGUMENTS 
      integer nevent,nbins,nout,evform,nmax,mode
      real*8 f,x(0:nbins),error,z(20)
      real*8 event(nbins),hevent(nbins),nevent_th
C     LOCAL VARIABLES 
      integer i,j
      integer ierr
      real*8 sumy,xi,y(nbins),dy(nbins),rnevent,hy(nbins)
      real*8 dx(nbins)
C     EXTERNAL FUNCTIONS
      external f
C     ----------
C     BEGIN CODE
C     ----------
      sumy = 0d0
      nevent_th = 0d0
      ierr = 0

      if (mode.eq.0) then
         do i = 1,nbins
            dx(i) = x(i) -x(i-1)
            xi = x(i-1)
            hevent(i) = f(xi,z)
            event(i) = hevent(i)*dx(i)
            nevent_th = nevent_th +event(i)
         enddo
      else
         do i = 1,nbins
            dx(i) = x(i) -x(i-1)
            if ( mode.eq.1 ) then
               call hsimp1D(f,x(i-1),x(i),z,y(i),error,nmax,ierr)
               hy(i) = y(i)/dx(i)
               if (ierr.ne.0) then
                  write(nout,*) "ERROR: Integration does not converge"
                  return
               endif
            elseif (mode.eq.2) then
               xi = ( x(i) +x(i-1) )/2d0
               hy(i) = f(xi,z)
               y(i) = hy(i)*dx(i)
            endif
            sumy = sumy +y(i)
         enddo
         
         if (nevent.eq.0) then
            sumy = 1d0
            rnevent = 1d0
         else
            rnevent = nevent
         endif

         do i = 1,nbins
            if (evform.eq.1) then
               event(i) = idint( y(i)*rnevent / sumy )
c               event(i) = int(y(i))
            elseif (evform.eq.2) then
               event(i) = y(i)*rnevent / sumy
            endif
            hevent(i) = event(i)/dx(i)
            nevent_th = nevent_th +event(i) 
         enddo
      endif

      return
      end
