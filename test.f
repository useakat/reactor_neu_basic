      program test
      implicitnone

      real*8 z(2),ANS,error
      integer iflag,nmax

      real*8 rNormalDist,esbeta,testfunc,SigmaProb
      external rNormalDist,esbeta,testfunc

      z(1) = 0.2d0
      z(2) = 0.1d0

      error = 1d-8
      nmax = 10

c      call simp3d(rNormalDist,0d0,2d0,z,ans,error,nmax,iflag)
c      write(6,*) ans,iflag
c      write(6,*) rNormalDist(0d0,z(1),z(2))

c      call simp1d(testfunc,0d0,0.3d0,ans,error,nmax,iflag)
c      write(6,*) ans,iflag

      write(6,*) SigmaProb(1.64d0)

      end

      real*8 function testfunc(x) 
      implicitnone
      
      real*8 x

      testfunc = x**2 +2*x +4d0

      return
      end

