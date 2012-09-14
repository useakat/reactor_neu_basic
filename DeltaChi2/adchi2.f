      real*8 function adchi2(func,x,nparm,parm,parm0,error)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS AUG 27 2012
C
C     Calculate chi^2 from two real*8 arrays
C     ****************************************************
      implicit none

C     ARGUMENTS 
      integer nparm
      real*8 x,parm(40),parm0(40),error(nparm)
C     LOCAL VARIABLES 
      integer i
      real*8 Fdat,Ffit
C     EXTERNAL VARIABLES
      real*8 func
      external func
C     ----------
C     BEGIN CODE
C     ----------
      Fdat = func(x,parm0)
      Ffit = func(x,parm) 

      adchi2 = (Fdat -Ffit)**2/Fdat
c      do i = 1,nparm
c         adchi2 = adchi2 +( parm(i) -parm0(i) )**2 / error(i)**2
c      enddo

      return
      end
