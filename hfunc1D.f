      real*8 function hfunc1D(x,z)

      implicit none
      
      include 'const.inc'

      integer sign,mode
      real*8 x,z(40),error(10),L,E,loe,Np,P,YY,ovnorm
      real*8 flux,xsec,prob_ee,Lfact,fa,fb
      external flux,xsec,prob_ee      

      error(1) = 0.025d0
      error(2) = 0.005d0
      error(3) = 0.2d-5
      error(4) = 0.1d-3
      error(5) = 0.03d0
      error(6) = 0.1d0
      error(7) = 0.1d0

      ovnorm = z(5)
      fa = z(6)
      fb = z(7)
      L = z(16)
      sign = int(z(11))
      Np = z(12)
      P = z(13)
      YY = z(14)
      mode = z(15)

      Lfact = 4*pi*(L*1d5)**2
      if (mode.lt.10) then
         E = x    ! x = E_{\nu}
      elseif (mode.lt.20) then
         E = L/x   ! x = L/E{\nu}
      elseif (mode.lt.30) then
         E = x**2 +0.8d0  ! x = sqrt{E_{vis}}
      endif

      if (mode.eq.0) then   ! dN/dE_{\nu}
         hfunc1D = ovnorm*Np*YY*flux(E,P)/Lfact
     &        *prob_ee(L/E,z,error,sign,0,0)*xsec(E)
      elseif (mode.eq.1) then   ! dFlux/dE_{\nu}  eq.6
         hfunc1D = flux(E,P)
      elseif (mode.eq.2) then   ! dXsec/dE_{\nu}  eq.13
         hfunc1D = xsec(E)
      elseif (mode.eq.3) then   ! dPee/E_{\nu}
         hfunc1D = prob_ee(L/E,z,error,sign,0,0)         
      elseif (mode.eq.4) then   ! d(Flux*Xsec)/dE_{\nu}
         hfunc1D = flux(E,P)*xsec(E)

      elseif (mode.eq.12) then      ! d(Flux*Xsec)/d(L/E_{\nu})
         hfunc1D = E**2/( L*1d5 )*flux(E,P)/Lfact*xsec(E)
      elseif (mode.eq.13) then  ! d(Flux*Xsec*Pee)/d(L/E_{\nu})
         hfunc1D = E**2/( L*1d5 )*flux(E,P)/Lfact*xsec(E)
     &        *prob_ee(x,z,error,sign,0,0)
      elseif (mode.eq.14) then  ! Pee vs L/E_{\nu}
         hfunc1D = prob_ee(L/E,z,error,sign,0,0)         

      elseif (mode.eq.20) then  ! dN/dsqrt(E_{vis})
         hfunc1D = 2*x*ovnorm*Np*YY*flux(E,P)/Lfact
     &        *prob_ee(L/E,z,error,sign,0,0)*xsec(E)
      elseif (mode.eq.21) then  ! d(Flux*Xsec)/dsqrt{E_{vis}}
         hfunc1D = 2*x*flux(E,P)/Lfact*xsec(E)
      elseif (mode.eq.23) then  ! Flux vs sqrt{E_{vis}}
         hfunc1D = flux(E,P)
      elseif (mode.eq.24) then  ! Xsec vs sqrt{E_{vis}}
         hfunc1D = xsec(E)
      elseif (mode.eq.100) then  ! Xsec vs sqrt{E_{vis}}
         hfunc1D = 2000d0
      endif

      return
      end


