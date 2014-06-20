      program test
      implicitnone

      real z(2),ANS,error
      integer i
      integer iflag,nmax

      integer time,ier,neval
      real gran,x1,y1,x2,y2,x,abserr
      real rNormalDist,esbeta,testfunc,SigmaProb,xy2d,f
      external rNormalDist,esbeta,testfunc,SigmaProb,f

      call qng(f,1,10,0.01,0.01,ans,abserr,neval,ier)
      write(*,*) ans,abserr,neval,ier

      return
      end

      real function f(x)
      implicit none
      real x      

      f = x**2

      return
      end

