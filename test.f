      program test
      implicitnone

      real*8 z(2),ANS,error
      integer i
      integer iflag,nmax

      integer time
      real*8 gran,x1,y1,x2,y2
      external gran
      real*8 rNormalDist,esbeta,testfunc,SigmaProb,xy2d
      external rNormalDist,esbeta,testfunc,SigmaProb,xy2d

      x1 = 139.75d0
      y1 = 35.68d0
      x2 = 135.48d0
      y2 = 34.70d0

      write(*,*) x1,y1,x2,y2
      write(*,*) xy2d(x1,y1,x2,y2)

      return
      end

      real*8 function testfunc(x) 
      implicitnone
      
      real*8 x

      testfunc = x**2 +2*x +4d0

      return
      end

