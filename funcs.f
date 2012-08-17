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
      real*8 E
C     ----------
C     BEGIN CODE
C     ----------
      flux = 0.58*dexp( 0.870d0 -0.160*E -0.091*E**2 )
     &      +0.30*dexp( 0.896d0 -0.239*E -0.0981*E**2 )
     &      +0.07*dexp( 0.976d0 -0.162*E -0.0790*E**2 )
     &      +0.05*edxp( 0.793d0 -0.080*E -0.1085*E**2 )

      return
      end
