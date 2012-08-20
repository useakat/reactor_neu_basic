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
      real*8 me
C     
C     ARGUMENTS 
C     
      real*8 E,Ee
C     ----------
C     BEGIN CODE
C     ----------
      me = 0.510998910d0

      Ee = E -0.78d0
c      Ee = E -1.2913d0
c      Ee = E
c      xsec = 0.0952d0*Ee*dsqrt(Ee**2 -me**2)*1d-42
      xsec = 0.0952d0*Ee**4*1d-42

      return
      end


      real*8 function prob_ee(a,sign,mode)
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
      real*8 dm13_2,dm12_2,dm23_2
      real*8 ue1,ue2,ue3,ue1ue2,ue1ue3,ue2ue3
      real*8 dim_fact
C     
C     ARGUMENTS 
C     
      integer sign,mode
      real*8 a,aa
C     ----------
C     BEGIN CODE
C     ----------
      s2sun_2 = 0.852d0
      s23_2 = 0.5d0
      s213_2 = 0.1d0 
      dm12_2 = 7.6d-5
      dm23_2 = sign*2.4d-3
      dm13_2 = dm23_2 +dm12_2

c      s13 = dsqrt( (1d0 -dsqrt(1d0 -s213_2))/2d0 )
      s13 = dsqrt( 0.5*s213_2/( 1d0 +dsqrt(1d0 -s213_2) ) )
      c13 = dsqrt(1d0 -s13**2)
c      s12 = dsqrt( (1d0 -dsqrt(1d0 -s2sun_2/c13**4))/2d0 )
      s12 = dsqrt(0.32d0)
      c12 = dsqrt(1d0 -s12**2)
      ue1 = c12*c13
      ue2 = s12*c13
      ue3 = s13

      dim_fact = 1d6/197.3269631d0
      aa = a*dim_fact

      if (mode.eq.0) then
         prob_ee = 1d0 -4*ue1**2*ue2**2*dsin(dm12_2*aa/4d0)**2
     &        -4*ue1**2*ue3**2*dsin(dm13_2*aa/4d0)**2
     &        -4*ue2**2*ue3**2*dsin(dm23_2*aa/4d0)**2
      elseif (mode.eq.21) then
         prob_ee = 1d0 -4*ue1**2*ue2**2*dsin(dm12_2*aa/4d0)**2
      elseif (mode.eq.31) then
         prob_ee = -4*ue1**2*ue3**2*dsin(dm13_2*aa/4d0)**2
      elseif (mode.eq.32) then
         prob_ee = -4*ue2**2*ue3**2*dsin(dm23_2*aa/4d0)**2
      endif

      return
      end
