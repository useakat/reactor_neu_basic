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

      x1 = 126.4103670
      y1 = 35.407687d0
      x2 = 126.697083d0
      y2 = 35.052273d0

      write(*,*) x1,y1
      write(*,*) xy2d(x1,y1,x2,y2)

      x1 = 126.412630d0
      y1 = 35.409074d0
      write(*,*) x1,y1
      write(*,*) xy2d(x1,y1,x2,y2)

      x1 = 126.414916d0
      y1 = 35.410389d0
      write(*,*) x1,y1
      write(*,*) xy2d(x1,y1,x2,y2)

      x1 = 126.417201d0
      y1 = 35.411784d0
      write(*,*) x1,y1
      write(*,*) xy2d(x1,y1,x2,y2)

      x1 = 126.419465d0
      y1 = 35.413124d0
      write(*,*) x1,y1
      write(*,*) xy2d(x1,y1,x2,y2)

      x1 = 126.421766d0
      y1 = 35.414490d0
      write(*,*) x1,y1
      write(*,*) xy2d(x1,y1,x2,y2)

      return
      end

      real*8 function testfunc(x) 
      implicitnone
      
      real*8 x

      testfunc = x**2 +2*x +4d0

      return
      end

