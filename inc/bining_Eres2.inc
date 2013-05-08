C -*- fortran -*-
      binfactor = rdx
         xmin = dsqrt(Emin-0.8d0)                           
         xmax = dsqrt(Emax-0.8d0)
         x(0) = xmin
         do i = 1,maxnbin
            Evis = x(i-1)**2
            ddx = 0.5*dsqrt( Eres**2 +(Eres_nl/100d0)**2*Evis )*binfactor
            x(i) = x(i-1) +ddx
            if (x(i).gt.xmax) then
               nbins = i
               xmax = x(i)
               exit
            endif
         enddo
