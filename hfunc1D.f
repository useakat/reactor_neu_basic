      real*8 function hfunc1D_th(x,z)

      implicit none
      
      include 'const.inc'

      integer sign
      real*8 x,z(20),error(10),L,E,loe,Np,P,YY
      real*8 flux,xsec,prob_ee
      external flux,xsec,prob_ee

      error(1) = 0.025d0
      error(2) = 0.01d0
      error(3) = 0.2d-5
      error(4) = 0.1d-3

      L = z(5)
      sign = int(z(6))
      Np = z(7)
      P = z(8)
      YY = z(9)
      E = x**2 +0.8d0
      loe = L/E

      hfunc1D_th = 2*x*flux(E)*P/L**2*xsec(E)
     &     *prob_ee(loe,z,error,sign,0,0)*Np*YY

      return
      end


      real*8 function hfunc1D_dat(x,z)
      implicit none

      include 'const.inc'

      integer isign
      real*8 x,z(20),error(10),L,E,loe,P,YY,Np
      real*8 flux,xsec,prob_ee
      external flux,xsec,prob_ee

      error(1) = 0.025d0
      error(2) = 0.01d0
      error(3) = 0.2d-5
      error(4) = 0.1d-3

      L = z(5)
      isign = int(z(6))
      Np = z(7)
      P = z(8)
      YY = z(9)
      E = x**2 +0.8d0
      loe = L/E

      hfunc1D_dat = 2*x*flux(E)*P/L**2*xsec(E)
     &     *prob_ee(loe,z,error,isign,0,0)*Np*YY

      return
      end


