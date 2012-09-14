C -*- fortran -*-
         xmin = dsqrt(Emin-0.8d0)                           
         xmax = dsqrt(Emax-0.8d0)
         nbins = int( ( xmax -xmin ) / Eres*2 ) ! nbins should be less than 100000
         do i = 0,nbins
            x(i) = xmin +Eres/2d0*i
         enddo