      real function gran()
      implicit none
c     const:
      real pi
      parameter(pi=3.14159265)
c     local:
      integer  odd/0/
      real     x1,x2,fac
c     function:
      real rand
      external rand
c     save:
      save     odd,fac,x2
c     begin:
      odd=1-odd
      if (odd.ne.0) then
         x1=rand()
         x2=rand()
         fac=sqrt(-2.0*log(x1))
         gran=fac*cos(2.0*pi*x2)
      else 
         gran=fac*sin(2.0*pi*x2)
      endif

      return
      end
      
