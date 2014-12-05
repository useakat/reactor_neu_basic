      real*8 function flux(E,P)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Aug.31 2012
C     
C     Anti-electron-neutrino flux of energy E[MeV] 
C     from the reactors with the total thermal 
C     power of P[GW] in [ 1/s/MeV ] unit
C     ****************************************************
      implicitnone
C     
C     ARGUMENTS 
C     
      real*8 E,P
      real*8 a,EU235,EU238,EPu239,EPu241,fU235,fU238,fPu239,fPu241
      real*8 preflux,pi
C     ----------
C     BEGIN CODE
C     ----------
      pi = dacos(-1d0)

      fU235 = 0.58d0
      fU238 = 0.07d0
      fPu239 = 0.30d0
      fPu241 = 0.05d0
      EU235 = 201.7d0
      EU238 = 205.0d0
      EPu239 = 210.0d0
      EPu241 = 212.4d0

      a = 1d0 / ( fU235*EU235 +fU238*EU238 +fPu239*EPu239 
     &     +fPu241*EPu241 )

      preflux = fU235*dexp( 0.870d0 -0.160*E -0.091*E**2 )
     &      +fPu239*dexp( 0.896d0 -0.239*E -0.0981*E**2 )
     &      +fU238*dexp( 0.976d0 -0.162*E -0.0790*E**2 )
     &      +fPu241*dexp( 0.793d0 -0.080*E -0.1085*E**2 )

      flux = P*a*preflux*6.24*1d21
c      flux = a*preflux*1d12/1.602176487d0
c      flux = a*preflux*1d22/1.602176487d0

      return
      end

      real*8 function geo_neu_flux(E)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Aug.31 2012
C     
C     Anti-electron-neutrino flux of energy E[MeV] 
C     from the reactors with the total thermal 
C     power of P[GW] in [ 1/cm^2/s/MeV ] unit
C     ****************************************************
      implicitnone
C     ARGUMENTS
      integer iso
      real*8 E,r
      real*8 norm,flux_U,flux_Th,flux
      real*8 preflux,pi,norm_U,norm_Th
C     ----------
C     BEGIN CODE
C     ----------
      pi = dacos(-1d0)

c      norm = 4.3d6 ! 1/cm^2/s/MeV KAMLAND measurement

      norm_U = 5.65d6  ! 1/cm^2/s/MeV effective flux (= 30 TNU:KAMLAND, Th/U = 3.9)
      norm_Th = 4.46d6 ! 1/cm^2/s/MeV effective flux (= 8 TNU:KAMLAND)
c      norm_U = 0d0

      if (E.lt.1.74) then
         flux_U = -0.391 +0.678*E -0.214*E**2  
      elseif (E.lt.1.9) then
c         flux_U = -3.66 +4.23*E -1.18*E**2
         flux_U = 0.322 -0.103*E
      elseif (E.lt.2.28) then
         flux_U = -0.165 +0.363*E -0.111*E**2
      elseif (E.lt.3.26) then
         flux_U = 0.0206 +0.00566*E -0.003*E**2
      else
         flux_U = 0d0
      endif

      if (E.lt.1.73) then
         flux_Th = -0.1106 +0.351*E -0.121*E**2  
      elseif (E.lt.2.08) then
         flux_Th = -0.00218 +0.194*E -0.0736*E**2
      elseif (E.lt.2.25) then
         flux_Th = -0.39 +0.531*E -0.148*E**2
      else
         flux_Th = 0d0
      endif

c      geo_neu_flux = norm*(flux_U +r*flux_Th)
      geo_neu_flux = norm_U*flux_U +norm_Th*flux_Th

      return
      end


      real*8 function xsec_IBD_naive(E)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Aug.17 2012
C     
C     Cross section between electron neutrino and detector in cm^2 unit.
C     Ref: hep-ph/9903554 eq.11
C
C     input
C           E: energy of the positron in MeV           
C     ****************************************************
      implicitnone
C     CONSTANTS
      real*8 me,mp,mn
C     ARGUMENTS 
      real*8 E,Ee
C     ----------
C     BEGIN CODE
C     ----------
      me = 0.510998910d0
      mp = 938.272d0
      mn = 939.565d0
c      Ee = (E +mp)/2d0*(1d0 -(mn**2 -me**2)/(2*E*mp +mp**2))
      Ee = E -(mn-mp)
      xsec_IBD_naive = 0.0952d0*Ee*dsqrt(Ee**2 -me**2)*1d-42
      return
      end


      real*8 function xsec_IBD_naive2(E)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Aug.17 2012
C     
C     Cross section between electron neutrino and detector in cm^2 unit.
C     Ref: astro-ph/0302055 eq.25
C
C     input
C           E: energy of the positron in MeV           
C     ****************************************************
      implicitnone
C     CONSTANTS
      real*8 me,mp,mn
C     ARGUMENTS 
      real*8 E,Ee,pw
C     ----------
C     BEGIN CODE
C     ----------
      me = 0.510998910d0
      mp = 938.272d0
      mn = 939.565d0
      Ee = E -(mn-mp)
      pw = -0.07056 +0.02018*dlog(E) -0.001953*dlog(E)**3
      xsec_IBD_naive2 = Ee*dsqrt(Ee**2 -me**2)*E**pw*1d-43
      return
      end


      real*8 function prob_ee(LoE,param,error,sign,mode,unc_mode)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Aug.17 2012
C     Modified @ U.Tokyo Jun.19 2014
C
C     P_ee
C
C     input
C           a: L/E in km/MeV
C     ****************************************************
      implicitnone
C     CONSTANTS
C     ARGUMENTS 
      integer sign,mode,unc_mode,icheck
      real*8 a,aa,param(4),error(4),LoE
C     LOCAL VARIABLES
      real*8 s212_2,s23_2,s213_2,s12,c12,s13,c13
      real*8 s12_2,s13_2,unc_s212_2,unc_s213_2
      real*8 s212_2_eff,s213_2_eff
      real*8 dm13_2,dm12_2,dm23_2,unc_dm12_2,unc_dm13_2
      real*8 dm12_2_eff,dm13_2_eff,dm23_2_eff
      real*8 ue1,ue2,ue3,ue1ue2,ue1ue3,ue2ue3
      real*8 dim_fact,c212,Del_21,Del_ee,phi
      real*8 dmee_2,cosphi,sinphi
C     ----------
C     BEGIN CODE
C     ----------
      s212_2 = param(1)
      s213_2 = param(2)
      dm12_2 = param(3)
      dm13_2 = param(4)
      unc_s212_2 = error(1)
      unc_s213_2 = error(2)
      unc_dm12_2 = error(3)
      unc_dm13_2 = error(4)

      dm23_2 = sign*dm13_2 -dm12_2
      s212_2_eff = s212_2 +unc_mode*unc_s212_2
      s213_2_eff = s213_2 +unc_mode*unc_s213_2
      dm12_2_eff = dm12_2 
      dm13_2_eff = dm13_2 
      dm23_2_eff = dm23_2

      s13_2 = 0.5*s213_2_eff/( 1d0 +dsqrt(1d0 -s213_2_eff) )
      s13 = dsqrt(s13_2)
      c13 = dsqrt(1d0 -s13**2)
      s12_2 = ( 1d0 -dsqrt(1d0 -s212_2_eff) )/2d0
      s12 = dsqrt(s12_2)
      c12 = dsqrt(1d0 -s12**2)
      ue1 = c12*c13
      ue2 = s12*c13
      ue3 = s13

      dim_fact = 1d6/197.3269631d0
      aa = LoE*dim_fact

      if (mode.eq.0) then
         prob_ee = 1d0 -4*ue1**2*ue2**2*dsin(dm12_2_eff*aa/4d0)**2
     &        -4*ue1**2*ue3**2*dsin(dm13_2_eff*aa/4d0)**2
     &        -4*ue2**2*ue3**2*dsin(dm23_2_eff*aa/4d0)**2
c         Prob_ee = 1d0 -4*c13**4*s12**2*c12**2*dsin(dm12_2*a*1270d0)**2
c     &        -c12**2*s213_2*dsin(dm13_2*a*1270d0)**2
c     &        -s12**2*s213_2*dsin(dm23_2*a*1270d0)**2
      elseif (mode.eq.1) then
         s212_2 = s212_2
         dmee_2 = dm13_2
         c212 = c12**2 -s12**2
         Del_21 = dm12_2*LoE/4d0*dim_fact
         Del_ee = dmee_2*LoE/4d0*dim_fact
c         phi = datan(c212*dtan(Del_21)) -Del_21*c212
c         phi = 2*s12_2*Del_21*(1d0 -dsin(Del_21)/(2*Del_21
c     &        *dsqrt(1d0 -4*s12_2*c12**2*dsin(Del_21)**2)))
      cosphi = (c12**2*dcos(2*s12_2*Del_21)+s12_2*dcos(2*c12**2*Del_21))
     &        /dsqrt(1d0 -4*s12_2*c12**2*dsin(Del_21)**2)
      sinphi = (c12**2*dsin(2*s12_2*Del_21)-s12_2*dsin(2*c12**2*Del_21))
     &        /dsqrt(1d0 -4*s12_2*c12**2*dsin(Del_21)**2)
      
         prob_ee = 1d0 -0.5*s213_2*(1d0 -dsqrt(1d0 
     &        -s212_2*dsin(Del_21)**2)*(dcos(2*Del_ee)*cosphi 
     &        -sign*dsin(2*Del_ee)*sinphi))
     &        -s212_2*c13**4*dsin(Del_21)**2       
c     &        -s212_2*dsin(Del_21)**2)*dcos(2*Del_ee +sign*phi))  
      elseif (mode.eq.21) then
         prob_ee = 1d0 -4*ue1**2*ue2**2*dsin(dm12_2_eff*aa/4d0)**2
      elseif (mode.eq.31) then
         prob_ee = -4*ue1**2*ue3**2*dsin(dm13_2_eff*aa/4d0)**2
      elseif (mode.eq.32) then
         prob_ee = -4*ue2**2*ue3**2*dsin(dm23_2_eff*aa/4d0)**2
      endif

      return
      end


      real*8 function prob_geo(LoE,param,error,sign,mode,unc_mode)
C     ****************************************************
C     By Yoshitaro Takaesu @U.Tokyo Jun.21 2014
C
C     P_geo
C
C     input
C           a: L/E in km/MeV
C     ****************************************************
      implicitnone
C     CONSTANTS
C     ARGUMENTS 
      integer sign,mode,unc_mode,icheck
      real*8 a,aa,param(4),error(4),LoE
C     LOCAL VARIABLES
      real*8 s212_2,s23_2,s213_2,s12,c12,s13,c13
      real*8 s12_2,s13_2,unc_s212_2,unc_s213_2
      real*8 s212_2_eff,s213_2_eff
      real*8 dm13_2,dm12_2,dm23_2,unc_dm12_2,unc_dm13_2
      real*8 dm12_2_eff,dm13_2_eff,dm23_2_eff
      real*8 ue1,ue2,ue3,ue1ue2,ue1ue3,ue2ue3
      real*8 dim_fact,c212,Del_21,Del_ee,phi
      real*8 dmee_2,cosphi,sinphi
C     ----------
C     BEGIN CODE
C     ----------
      s212_2 = param(1)
      s213_2 = param(2)
      dm12_2 = param(3)
      dm13_2 = param(4)
      unc_s212_2 = error(1)
      unc_s213_2 = error(2)
      unc_dm12_2 = error(3)
      unc_dm13_2 = error(4)

      dm23_2 = sign*dm13_2 -dm12_2
      s212_2_eff = s212_2 +unc_mode*unc_s212_2
      s213_2_eff = s213_2 +unc_mode*unc_s213_2
      dm12_2_eff = dm12_2 
      dm13_2_eff = dm13_2 
      dm23_2_eff = dm23_2

      s13_2 = 0.5*s213_2_eff/( 1d0 +dsqrt(1d0 -s213_2_eff) )
      s13 = dsqrt(s13_2)
      c13 = dsqrt(1d0 -s13**2)
c      s12_2 = ( 1d0 -dsqrt(1d0 -s212_2_eff/c13**4) )/2d0
      s12_2 = ( 1d0 -dsqrt(1d0 -s212_2_eff) )/2d0
      s12 = dsqrt(s12_2)
      c12 = dsqrt(1d0 -s12**2)
      ue1 = c12*c13
      ue2 = s12*c13
      ue3 = s13

      prob_geo = c13**4*(1d0 -2*s12_2*c12**2) +s13**4

      return
      end
