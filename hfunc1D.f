      real*8 function hfunc1D_th(x,z)

      implicit none

      integer mode
      real*8 x,z(20),error(10),L,E,loe
      real*8 flux,xsec,prob_ee
      external flux,xsec,prob_ee

c      hfunc1D = ( x -z(1) )**2 +z(2)

      error(1) = 0.025d0
      error(2) = 0.01d0
      error(3) = 0.2d-5
      error(4) = 0.1d-3

      L = z(5)
      mode = z(6)
      E = x**2
      loe = L/E

      hfunc1D_th = flux(E)*xsec(E)*prob_ee(loe,z,error,mode,0,0)

c      hfunc1D = prob_ee(loe,z,error,1,0,0)

      return
      end


      real*8 function hfunc1D_dat(x,z)

      implicit none

      integer mode
      real*8 x,z(20),error(10),L,E,loe
      real*8 flux,xsec,prob_ee
      external flux,xsec,prob_ee

c      hfunc1D = ( x -z(1) )**2 +z(2)

      error(1) = 0.025d0
      error(2) = 0.01d0
      error(3) = 0.2d-5
      error(4) = 0.1d-3

      L = z(5)
      mode = z(6)
      E = x**2
      loe = L/E

      hfunc1D_dat = flux(E)*xsec(E)*prob_ee(loe,z,error,mode,0,0)

c      hfunc1D = prob_ee(loe,z,error,1,0,0)

      return
      end


