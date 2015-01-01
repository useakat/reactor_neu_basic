      real*8 function hfunc1D(x,z)

      implicit none
      
      include 'const.inc'

      integer i,reactor_mode,reactor_type
      integer sign,mode,nr,iPee,ixsec
      real*8 x,z(50),error(10),L,E,loe,Np,P,YY,ovnorm,ovnorm_geo
      real*8 flux,xsec_IBD_naive,prob_ee,Lfact,fa,fb,Evis,fscale,theta
      real*8 probLL,LL(200),LLfact(200),tokei(0:200),hokui(0:200)
      real*8 PP(200),xsec_IBD_naive2,nxsec,Pee,geo_neu_flux,nflux
      real*8 Prob_geo,Pgeo
      external flux,xsec_IBD_naive,prob_ee,xsec_IBD_naive2
      external geo_neu_flux,Prob_geo

      error(1) = 0.025d0
      error(2) = 0.005d0
      error(3) = 0.2d-5
      error(4) = 0.1d-3
      error(5) = 0.03d0
      error(6) = 0.2d0
c      error(7) = 0.1d0

      ovnorm = z(5)
      ovnorm_geo = z(6)
c      fa = z(6)
c      fb = z(7)
c      fscale = z(9)
      L = z(16)
      sign = int(z(11)) ! MH 1:NH -1:IH
      Np = z(12)
      P = z(13)
      YY = z(14)
      mode = z(15)
c      theta = z(17)
c      nr = int(abs(z(18)))
c      tokei(0) = z(19)
c      hokui(0) = z(20)
c      reactor_mode = int(z(21))
c      reactor_type = int(z(22))
      ixsec = int(z(23))
      iPee = int(z(24))

      Lfact = 4*pi*(L*1d5)**2
c      if (mode.lt.10) then ! x = E_{\nu}
c         E = x    
c      elseif (mode.lt.20) then ! x = L/E{\nu}
c         E = L/x   
c      elseif (mode.lt.30) then ! x = sqrt{E_{vis}}
c         Evis = ( 1d0 +fscale )*x**2
         Evis = x**2      ! x = sqrt{E_{vis}}
         E = Evis +0.8d0  
c      endif
CCC
CCC IBD cross section
CCC
      if (ixsec.eq.0) then
         nxsec = xsec_IBD_naive2(E) ! improved approximation
      elseif (ixsec.eq.1) then
         nxsec = xsec_IBD_naive(E) ! very naive approximation
      endif
CCC
CCC survival probability (P_ee)
CCC
      Pee = prob_ee(L/E,z,error,sign,iPee,0)
      Pgeo = prob_geo(L/E,z,error,sign,iPee,0)
c      Pee = 1d0

CCC
CCC survival probability (P_ee)
CCC
c      nflux = flux(E,P)
c      nflux = geo_neu_flux(E)

CCC
CCC calculation of hfunc1D
CCC
c      if (mode.eq.0) then   ! dN/dE_{\nu}
         hfunc1D = 0d0
         hfunc1D = ovnorm*Np*YY*flux(E,P)/Lfact*Pee*nxsec
         hfunc1D = hfunc1D +Np*YY*geo_neu_flux(E)*Pgeo*nxsec
c      endif

      return
      end


