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


      subroutine get_Ls_xy(xx,yy,n,LL,reactor_mode,reactor_type)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS MAY 1 2013
C     ****************************************************
      implicit none
C     GLOBAL VARIABLES
C     CONSTANTS
C     ARGUMENTS 
      integer n,reactor_mode,reactor_type
      real*8 xx(0:200),yy(0:200),LL(200)
C     LOCAL VARIABLES 
      integer i
      real*8 xy2d
C     EXTERNAL FUNCTIONS
      external xy2d
C     ----------
C     BEGIN CODE
C     ----------      
      if (reactor_mode.eq.0) then
         do i = 1,n
            LL(i) = xy2d(xx(0),yy(0),xx(i),yy(i))
         enddo
      elseif(reactor_mode.eq.1) then
         if (reactor_type.eq.0) then
            if (n.ge.1) then ! YongGwang
               do i = 11,16
                  LL(i) = xy2d(xx(0),yy(0),xx(i),yy(i))
               enddo
            endif
            if (n.ge.2) then ! +Kori
               do i = 21,26
                  LL(i) = xy2d(xx(0),yy(0),xx(i),yy(i))
               enddo
            endif
            if (n.ge.3) then ! +Wolsong
               do i = 31,35
                  LL(i) = xy2d(xx(0),yy(0),xx(i),yy(i))
               enddo
            endif
            if (n.ge.4) then ! +Ulchin
               do i = 41,46
                  LL(i) = xy2d(xx(0),yy(0),xx(i),yy(i))
               enddo
            endif
         elseif (reactor_type.eq.1) then
            if (n.ge.1) then
               do i = 11,16
c               do i = 1,1
                  LL(i) = xy2d(xx(0),yy(0),xx(i),yy(i))
               enddo
            endif
            if (n.ge.2) then
               do i = 21,26
                  LL(i) = xy2d(xx(0),yy(0),xx(i),yy(i))
               enddo
               do i = 121,124
                  LL(i) = xy2d(xx(0),yy(0),xx(i),yy(i))
               enddo
            endif
            if (n.ge.3) then
               do i = 31,35
                  LL(i) = xy2d(xx(0),yy(0),xx(i),yy(i))
               enddo
               do i = 131,131
                  LL(i) = xy2d(xx(0),yy(0),xx(i),yy(i))
               enddo
            endif
            if (n.ge.4) then
               do i = 41,46
                  LL(i) = xy2d(xx(0),yy(0),xx(i),yy(i))
               enddo
               do i = 141,144
                  LL(i) = xy2d(xx(0),yy(0),xx(i),yy(i))
               enddo
            endif
         endif
      endif

      return
      end


      real*8 function xy2d(x1,y1,x2,y2)
C     ************************************************************
C     Calculate the straight distance, xy2d [km], between two 
C     points, P1=(tokei-x1, hokui-y1) and P2=(tokei-x2, hokui-y2)
C
C     By Yoshitaro Takaesu @KIAS MAY 1 2013
C     ************************************************************
      implicit none
      include 'const.inc'
C     ARGUMENTS 
      real*8 x1,y1,x2,y2
C     LOCAL VARIABLES
      real*8 rx1,ry1,rx2,ry2,R
      real*8 xx1,yy1,zz1,xx2,yy2,zz2
C     ----------
C     BEGIN CODE
C     ----------      
      R = 6378.137d0 ! [km]
      rx1 = x1*2*pi/360d0
      ry1 = (90d0-y1)*2*pi/360d0
      rx2 = x2*2*pi/360d0
      ry2 = (90d0-y2)*2*pi/360d0
      
      xx1 = R*dsin(ry1)*dcos(rx1)
      yy1 = R*dsin(ry1)*dsin(rx1)
      zz1 = R*dcos(ry1)
      xx2 = R*dsin(ry2)*dcos(rx2)
      yy2 = R*dsin(ry2)*dsin(rx2)
      zz2 = R*dcos(ry2)

      xy2d = dsqrt( (xx1-xx2)**2 +(yy1-yy2)**2 +(zz1-zz2)**2 )

      return
      end
