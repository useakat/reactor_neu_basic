      real*8 function reduce_rfdim1(rx)
C     ****************************************************
C     By Yoshitaro Takaesu @KIAS Dec.14 2012
C     ****************************************************
      implicit none
C     GLOBAL VARIABLES
      include 'redce_rfdim1.inc'
C     CONSTANTS
C     ARGUMENTS
      real*8 rx
C     LOCAL VARIABLES 
      integer i
      integer sum_ivar
C     EXTERNAL FUNCTIONS
C     ----------
C     BEGIN CODE
C     ----------
      sum_ivar = 0
      do i = 1,idim
         sum_ivar = sum_ivar +ivar(i)
      enddo
      if (sum_ivar.eq.1) then
         if (idim.eq.1) then
            reduce_rfdim1 = func(rx)
         elseif (idim.eq.2) then
            if (ivar(1).eq.1) reduce_rfdim1 = func(rx,x(2))
            if (ivar(2).eq.1) reduce_rfdim1 = func(x(1),rx)
         elseif (idim.eq.3) then
            if (ivar(1).eq.1) reduce_rfdim1 = func(rx,x(2),x(3))
            if (ivar(2).eq.1) reduce_rfdim1 = func(x(1),rx,x(3))
            if (ivar(3).eq.1) reduce_rfdim1 = func(x(1),x(2),rx)
         endif
      else
         write(99,*) "ERROR: The variable setting is not valid."
      endif
      
      return
      end
