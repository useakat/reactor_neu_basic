      program sandbox
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Sep.7 2012
C     
C     ****************************************************
      implicitnone
C     
C     CONSTANTS
C     
C     
C     ARGUMENTS 
C     
C     
C     GLOBAL VARIABLES
C     
C     
C     LOCAL VARIABLES 
C     
      integer i
      integer inmax
      parameter (inmax=30)
      real*8 ra,rd,P0,sumP
      
C     
C     EXTERNAL FUNCTIONS
C     
      real*8 Pn,rNormalDist
      external Pn,rNormalDist
C     ----------
C     BEGIN CODE
C     ----------
      ra = 3d0
      rd = 0.005d0

      P0 = Pn(0,rd,ra*rd)
      
      sumP = 0d0
      do i = 1,inmax
         sumP = sumP +Pn(i,rd,ra*rd)
      enddo
      
      write(6,*) 2*sumP

      end
