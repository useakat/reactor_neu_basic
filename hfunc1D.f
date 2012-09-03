      real*8 function hfunc1D(x,z)

      implicit none
      
      include 'const.inc'

      integer sign,mode
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
      mode = z(10)

      if (mode.lt.10) then
         E = x
      elseif (mode.lt.20) then
         E = L/x
      elseif (mode.lt.30) then
         E = x**2 +0.8d0
      endif

      if (mode.eq.4) then   ! Pee vs. E
         hfunc1D = prob_ee(L/E,z,error,sign,0,0)         
      elseif (mode.eq.12) then      ! Flux*Xsec vs. L/E
         hfunc1D = E**2/L*1d-5*flux(E)*P/L**2*xsec(E)
      elseif (mode.eq.13) then  ! Flux*Xsec*Pee vs. L/E
         hfunc1D = E**2/L*1d-5*flux(E)*P/L**2*xsec(E)
     &        *prob_ee(x,z,error,sign,0,0)
      elseif (mode.eq.14) then  ! Pee vs. L/E
         hfunc1D = prob_ee(L/E,z,error,sign,0,0)         
      elseif (mode.eq.20) then  ! N vs. sqrt(E)
         hfunc1D = 2*x*flux(E)*P/L**2*xsec(E)
     &        *prob_ee(L/E,z,error,sign,0,0)*Np*YY
      elseif (mode.eq.21) then  ! Flux*Xsec vs. sqrt(E)
         hfunc1D = 2*x*flux(E)*P/L**2*xsec(E)
      endif


      return
      end


