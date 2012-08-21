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

      Ee = E -1.2913d0
c      Ee = E
      xsec = 0.0952d0*Ee*dsqrt(Ee**2 -me**2)*1d-42
c      xsec = 0.0952d0*Ee**4*1d-42

      return
      end
