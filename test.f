      program test
      implicitnone

      real*8 z(2),ANS,error
      integer i
      integer iflag,nmax

      integer time
      real*8 gran
      external gran
      real*8 rNormalDist,esbeta,testfunc,SigmaProb
      external rNormalDist,esbeta,testfunc,SigmaProb,time

      call gran_init(time())
      do i = 1,10
         z(1) = gran()
         write(6,*) z(1)
      enddo

      end

      real*8 function testfunc(x) 
      implicitnone
      
      real*8 x

      testfunc = x**2 +2*x +4d0

      return
      end

