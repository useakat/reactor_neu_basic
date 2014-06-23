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
      fscale = z(9)
      L = z(16)
      sign = int(z(11)) ! MH 1:NH -1:IH
      Np = z(12)
      P = z(13)
      YY = z(14)
      mode = z(15)
      theta = z(17)
      nr = int(abs(z(18)))
      tokei(0) = z(19)
      hokui(0) = z(20)
      reactor_mode = int(z(21))
      reactor_type = int(z(22))
      ixsec = int(z(23))
      iPee = int(z(24))

      Lfact = 4*pi*(L*1d5)**2
      if (mode.lt.10) then
         E = x    ! x = E_{\nu}
      elseif (mode.lt.20) then
         E = L/x   ! x = L/E{\nu}
      elseif (mode.lt.30) then
         Evis = ( 1d0 +fscale )*x**2
         E = Evis +0.8d0  ! x = sqrt{E_{vis}}
      endif
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
      nflux = flux(E,P)
c      nflux = geo_neu_flux(E)
CCC
CCC calculation of hfunc1D
CCC
      if (mode.eq.0) then   ! dN/dE_{\nu}
         hfunc1D = 0d0
         hfunc1D = ovnorm*Np*YY*flux(E,P)/Lfact*Pee*nxsec
         hfunc1D = hfunc1D +Np*YY*geo_neu_flux(E)*Pgeo*nxsec
      elseif (mode.eq.1) then   ! dFlux/dE_{\nu}  eq.6
         hfunc1D = nflux
c         hfunc1D = geo_neu_flux(E)
      elseif (mode.eq.2) then   ! dXsec/dE_{\nu}  eq.13
         hfunc1D = nxsec
      elseif (mode.eq.3) then   ! dPee/E_{\nu}
         hfunc1D = Pee
      elseif (mode.eq.4) then   ! d(Flux*Xsec)/dE_{\nu}
         hfunc1D = nflux*nxsec
c         hfunc1D = nxsec
c         hfunc1D = geo_neu_flux(E)*nxsec

      elseif (mode.eq.12) then      ! d(Flux*Xsec)/d(L/E_{\nu})
         hfunc1D = E**2/( L*1d5 )*nflux/Lfact*nxsec
      elseif (mode.eq.13) then  ! d(Flux*Xsec*Pee)/d(L/E_{\nu})
         hfunc1D = E**2/( L*1d5 )*nflux/Lfact*nxsec*Pee
      elseif (mode.eq.14) then  ! Pee vs L/E_{\nu}
         hfunc1D = Pee

      elseif (mode.eq.20) then  ! dN/dsqrt(E_{vis})
         hfunc1D = 0d0
         hfunc1D = 2*x*ovnorm*Np*YY*nflux/Lfact*Pee*nxsec
c         hfunc1D = hfunc1D +2*x*ovnorm_geo*Np*YY*geo_neu_flux(E)*nxsec
c         hfunc1D = 1d32*3.1536d7*geo_neu_flux(E)*nxsec ! consistent with KAMLAND
c         hfunc1D = 3.49d32*3.1536d7*geo_neu_flux(E)*nxsec ! BOREXINO (Neutrino2014)
c         hfunc1D = 5.2d33*3.1536d7*geo_neu_flux(E)*nxsec ! consistent with KAMLAND
c         hfunc1D = geo_neu_flux(E)
      elseif (mode.eq.21) then  ! d(Flux*Xsec)/dsqrt{E_{vis}}
         hfunc1D = 2*x*nflux/Lfact*nxsec
      elseif (mode.eq.23) then  ! Flux vs sqrt{E_{vis}}
         hfunc1D = nflux
      elseif (mode.eq.24) then  ! Xsec vs sqrt{E_{vis}}
         hfunc1D = nxsec
      elseif (mode.eq.25) then  ! RENO50 dN/dsqrt(E_{vis})
         call get_Ls(L,theta,nr,LL)
         do i = 1,nr
            LLfact(i) = 4*pi*(LL(i)*1d5)**2
         enddo
         probLL = 0d0
         do i = 1,nr
               probLL = probLL 
     &              +prob_ee(LL(i)/E,z,error,sign,iPee,0)/LLfact(i)
         enddo
         hfunc1D = 2*x*ovnorm*Np*YY*flux(E,P)*probLL*nxsec/dble(nr)
c         hfunc1D = 2*x*ovnorm*Np*YY*flux(E,P)*probLL*nxsec/dble(nr)
      elseif (mode.eq.26) then  ! Korean reactors dN/dsqrt(E_{vis})
         include 'inc/set_reactors.inc'
         call get_Ls_xy(tokei,hokui,nr,LL,reactor_mode,reactor_type)
         include 'inc/get_probLL.inc'
         hfunc1D = 2*x*ovnorm*Np*YY*2.8*probLL*nxsec
      elseif (mode.eq.100) then  ! Xsec vs sqrt{E_{vis}}
         hfunc1D = 2000d0
      endif

      return
      end


