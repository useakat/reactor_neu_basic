      subroutine MakeHisto1D(nout,f,z,nevent,nbins,x,evform,event
     &     ,nevent_th)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS AUG 25 2012
C
C     
C     ****************************************************
      implicit none

C     ARGUMENTS 
      integer nevent,nbins,nout,evform,nmax
      parameter (nmax=100)
      real*8 f,x(0:nbins),error,z(20)
      parameter (error=1d0)
      real*8 event(nbins),nevent_th
C     LOCAL VARIABLES 
      integer i
      integer ierr
      real*8 sumy,xi,y(nbins),dy(nbins)
C     EXTERNAL FUNCTIONS
      external f
C     ----------
C     BEGIN CODE
C     ----------
      sumy = 0d0
      do i =1,nbins
         call hsimp1D(f,x(i-1),x(i),z,y(i),error,nmax,ierr)
         sumy = sumy +y(i)
         if (ierr.ne.0) then
            write(nout,*) "ERROR: Integration does not converge"
         endif
      enddo

      nevent_th = 0d0
      do i = 1,nbins
         if (evform.eq.1) then
c            event(i) = idnint( y(i)*dble(nevent) / sumy )
            event(i) = int( y(i)*dble(nevent) / sumy )
         elseif (evform.eq.2) then
            event(i) = y(i)*dble(nevent)/sumy
         endif
         nevent_th = nevent_th +event(i) 
      enddo

      return
      end
