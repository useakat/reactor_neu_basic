      real*8 function hfunc1D_multi(x,z)
c     This subroutine returns neutrino flux from identical multi-reactor sources
c     with different baseline length. 
c     In this current version, neutrino flux from Yongwang reactor complex can be 
c     calculated as a function of the angle from the reactor-alignment line.
      implicit none
      include 'const.inc'

      integer sign,mode
      real*8 x,z(40),error(10),L,E,loe,Np,P,YY,ovnorm
      real*8 flux,xsec,prob_ee,Lfact(6),fa,fb,Evis,fscale
      external flux,xsec,prob_ee      
      real*8 da,theta,b(6),c(6),a(6),Lv,Lh(0:6),LL(6)

      error(1) = 0.025d0
      error(2) = 0.005d0
      error(3) = 0.2d-5
      error(4) = 0.1d-3
      error(5) = 0.03d0
      error(6) = 0.2d0
c      error(7) = 0.1d0

      ovnorm = z(5)
c      fa = z(6)
c      fb = z(7)
      fscale = z(6)
      L = z(16)
      sign = int(z(11))
      Np = z(12)
      P = z(13)
      YY = z(14)
      mode = z(15)
      theta = z(17)

      Lv = L*dsin(theta)
      Lh(0) = L*dcos(theta)

      da = 0.23d0
      b(1) = 2
      b(2) = 1
      b(3) = 0
      b(4) = 0
      b(5) = 1
      b(6) = 2
      do i = 1,3
         c(i) = -1
      enddo
      do i = 4,6
         c(i) = 1
      enddo
      do i = 1,6
         a(i) = da/2d0 +b(i)*da
      enddo
      do i = 1,6
         Lh(i) = abs(Lh(0) +c(i)*a(i))
      enddo
      do i = 1,6
         LL(i) = dsqrt(Lv**2 +Lh(i)**2)
      enddo
      do i = 1,6
         Lfact(i) = 4*pi*(LL(i)*1d5)**2
      enddo

      Evis = ( 1d0 +fscale )*x**2
      E = Evis +0.8d0           ! x = sqrt{E_{vis}}

      hfunc1D_multi = 0d0
      do i =1,6
         hfunc1D_multi = hfunc1D_multi +2*x*ovnorm*Np*YY*flux(E,P)/6d0/Lfact(i)
     &        *prob_ee(LL(i)/E,z,error,sign,0,0)*xsec(E)
      enddo
      
      return
      end


