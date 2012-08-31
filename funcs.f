      real*8 function flux(E)
C     ****************************************************
C     
C     By Yoshitaro Takaesu @KEK Nov.19 2011
C     
C     The driver for making include and dat files for QCD
C     processes in color-flow-sampling option of MG. 
C     Input:
C     pp    4 momentum of external particles
C     Output:
C     Amplitude squared and summed
C     ****************************************************
      implicitnone
C     
C     ARGUMENTS 
C     
      integer neu_per_s 
      real*8 E
C     ----------
C     BEGIN CODE
C     ----------
c      neu_per_s = 5*10**20 

      flux = 0.58*dexp( 0.870d0 -0.160*E -0.091*E**2 )
     &      +0.30*dexp( 0.896d0 -0.239*E -0.0981*E**2 )
     &      +0.07*dexp( 0.976d0 -0.162*E -0.0790*E**2 )
     &      +0.05*dexp( 0.793d0 -0.080*E -0.1085*E**2 )

      return
      end


      real*8 function xsec(E)
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
C
C     CONSTANTS
C
      real*8 me,mp,mn
C     
C     ARGUMENTS 
C     
      real*8 E,Ee
C     ----------
C     BEGIN CODE
C     ----------
      me = 0.510998910d0
      mp = 938.272d0
      mn = 939.565d0

c      Ee = E -0.78d0
c      Ee = E -1.2913d0
      Ee = (E +mp)/2d0*(1d0 -(mn**2 -me**2)/(2*E*mp +mp**2))

      xsec = 0.0952d0*Ee*dsqrt(Ee**2 -me**2)*1d-42
c      xsec = 0.0952d0*Ee**4*1d-42

      return
      end


      real*8 function prob_ee(a,param,error,sign,mode,unc_mode)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Aug.17 2012
C     
C     P_ee
C
C     input
C           a: L/E in km/MeV
C     ****************************************************
      implicitnone
C
C     CONSTANTS
C
      real*8 s2sun_2,s23_2,s213_2,s12,c12,s13,c13
      real*8 s12_2,s13_2,unc_s2sun_2,unc_s213_2
      real*8 s2sun_2_eff,s213_2_eff
      real*8 dm13_2,dm12_2,dm23_2,unc_dm12_2,unc_dm13_2
      real*8 dm12_2_eff,dm13_2_eff,dm23_2_eff
      real*8 ue1,ue2,ue3,ue1ue2,ue1ue3,ue2ue3
      real*8 dim_fact
C     
C     ARGUMENTS 
C     
      integer sign,mode,unc_mode,icheck
      real*8 a,aa,param(4),error(4)
C     ----------
C     BEGIN CODE
C     ----------
      icheck = 0
      if (icheck.eq.0) then
         s2sun_2 = param(1)
         s213_2 = param(2)
         dm12_2 = param(3)
         dm13_2 = param(4)
         unc_s2sun_2 = error(1)
         unc_s213_2 = error(2)
         unc_dm12_2 = error(3)
         unc_dm13_2 = error(4)
         dm23_2 = sign*dm13_2 -dm12_2
      elseif (icheck.eq.1) then
         s2sun_2 = 0.852d0
         s213_2 = 0.1d0 
         dm12_2 = 7.5d-5
         dm13_2 = 2.35d-3
         unc_s2sun_2 = 0.025d0
         unc_s213_2 = 0.01d0
         unc_dm12_2 = 0.2d-5
         unc_dm13_2 = 0.1d-3
         dm23_2 = sign*dm13_2 -dm12_2
      elseif (icheck.eq.2) then
         s12_2 = 0.32d0
         s23_2 = 0.5d0
         s213_2 = 0.1d0 
         dm12_2 = 7.6d-5
         dm23_2 = sign*2.4d-3
         dm13_2 = dm23_2 +dm12_2
      endif

      s2sun_2_eff = s2sun_2 +unc_mode*unc_s2sun_2
      s213_2_eff = s213_2 +unc_mode*unc_s213_2
      dm12_2_eff = dm12_2 
      dm13_2_eff = dm13_2 
      dm23_2_eff = dm23_2

      s13_2 = 0.5*s213_2_eff/( 1d0 +dsqrt(1d0 -s213_2_eff) )
      s13 = dsqrt(s13_2)
      c13 = dsqrt(1d0 -s13**2)
      if (icheck.eq.0) then
         s12_2 = ( 1d0 -dsqrt(1d0 -s2sun_2_eff/c13**4) )/2d0
      endif
      s12 = dsqrt(s12_2)
      c12 = dsqrt(1d0 -s12**2)
      ue1 = c12*c13
      ue2 = s12*c13
      ue3 = s13

      dim_fact = 1d6/197.3269631d0
      aa = a*dim_fact

      if (mode.eq.0) then
         prob_ee = 1d0 -4*ue1**2*ue2**2*dsin(dm12_2_eff*aa/4d0)**2
     &        -4*ue1**2*ue3**2*dsin(dm13_2_eff*aa/4d0)**2
     &        -4*ue2**2*ue3**2*dsin(dm23_2_eff*aa/4d0)**2
      elseif (mode.eq.21) then
         prob_ee = 1d0 -4*ue1**2*ue2**2*dsin(dm12_2_eff*aa/4d0)**2
      elseif (mode.eq.31) then
         prob_ee = -4*ue1**2*ue3**2*dsin(dm13_2_eff*aa/4d0)**2
      elseif (mode.eq.32) then
         prob_ee = -4*ue2**2*ue3**2*dsin(dm23_2_eff*aa/4d0)**2
      endif

      return
      end
