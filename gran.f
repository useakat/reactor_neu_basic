      real*8 function gran_init(iseed)
      implicitnone
      integer iseed
      call srand_init(iseed)
      end

      real*8 function gran()
      implicit none
c     const:
      real*8 pi
      parameter(pi=3.14159265358979314)
c     local:
      integer  odd/0/,iseed,time
      real*8     x1,x2,fac
c     function:
      real*8 srand
      external srand,time
c     save:
      save     odd,fac,x2
c     begin:

      odd=1-odd
      if (odd.ne.0) then
         x1=srand()
         x2=srand()
         fac=dsqrt(-2.0*dlog(x1))
         gran=fac*dcos(2.0*pi*x2)
      else 
         gran=fac*dsin(2.0*pi*x2)
      endif

      return
      end
      
