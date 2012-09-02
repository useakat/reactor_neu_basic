      real*8 function feventdist(x,z)

      implicit none

      integer mode
      real*8 x,z(20),error(10),L,E,loe,Np,P,YY
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

      feventdist = flux(E)*P/L**2*xsec(E)
     &     *prob_ee(loe,z,error,mode,0,0)*Np*YY

      return
      end
