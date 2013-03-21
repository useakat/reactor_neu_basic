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
C     ARGUMENTS
C     real*8 rx: variable
C     real*8 rmean: the mean value
C     real*8 rsigma: the standard deviation
C
C     Last Modified: Dec.14 2012
C     ****************************************************
      implicitnone
      include 'const.inc'
C     ARGUMENTS 
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
