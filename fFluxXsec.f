      real*8 function fFluxXsec(x,z)
!     This function returns d (flux*xsec*P/L**2) / d[sqrt(E_vis)]
      implicit none

      include 'const.inc'

      integer mode
      real*8 x,z(20),error(10),L,E,loe,P,YY,Np
      real*8 flux,xsec,prob_ee
      external flux,xsec,prob_ee

      error(1) = 0.025d0
      error(2) = 0.01d0
      error(3) = 0.2d-5
      error(4) = 0.1d-3

      L = z(5)
      mode = z(6)
      Np = z(7)
      P = z(8)
      YY = z(9)
      E = x**2 +0.8d0
      loe = L/E

      fFluxXsec = 2*x*flux(E)*P/L**2*xsec(E)

      return
      end


