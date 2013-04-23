      subroutine get_Ls(L,theta,n,LL)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS APR 23 2013
C     ****************************************************
      implicit none
C     GLOBAL VARIABLES
C     CONSTANTS
C     ARGUMENTS 
      integer n
      real*8 L,theta,LL(n)
C     LOCAL VARIABLES 
      integer i,j
      integer ieven
      real*8 lbase,lh0,lv,dl,lh(n)
C     EXTERNAL FUNCTIONS
C     ----------
C     BEGIN CODE
C     ----------      
      lbase = 1.8d0  ! the baseline length of YongGwang reactor complex [km]
      if (mod(n,2).eq.0) then
         ieven = 1
      else 
         ieven = 0
      endif
      lh0 = L*dsin(theta)
      lv = L*dcos(theta)
      if (n.eq.1) then
         dl = 1d0
      else
         dl = lbase/dble(n-1)
      endif
      if (ieven.eq.1) then
         do i = 1,n/2
            j = 2*i-1
            lh(j) = dl/2d0 +(i-1)*dl
            lh(j+1) = -lh(j)
         enddo
      else
         lh(1) = 0d0
         do i = 1,(n-1)/2
            j = 2*i-1 +1
            lh(j) = i*dl
            lh(j+1) = -lh(j)
         enddo
      endif

      do i = 1,n
         LL(i) = dsqrt(lh0**2 +( lv -lh(i) )**2)
      enddo

      return
      end
