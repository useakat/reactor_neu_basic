      real*8 function rGauss(rx,ra,rmean,rsigma)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Sep.7 2012
C     
C     ****************************************************
      implicitnone
C     
C     ARGUMENTS 
C     
      real*8 rx,rmean,rsigma,ra
      
C     ----------
C     BEGIN CODE
C     ----------
      rGauss = ra*dexp( -( rx -rmean )**2 / (2*rsigma**2) )
      
      return
      end


      real*8 function rNormalDist(rx,rmean,rsigma)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Sep.7 2012
C     
C     ****************************************************
      implicitnone
      
      include 'const.inc'
C     
C     ARGUMENTS 
C     
      real*8 rx,rmean,rsigma

      real*8 ra
      
      real*8 rGauss
      external rGauss

C     ----------
C     BEGIN CODE
C     ----------
      ra = 1d0/(dsqrt(2*pi)*rsigma)
      rNormalDist = rGauss(rx,ra,rmean,rsigma)
      
      return
      end
