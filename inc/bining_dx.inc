C -*- fortran -*-
            xmin = dsqrt(Emin-0.8d0)
            xmax = dsqrt(Emax-0.8d0)
            nbins = int( ( xmax -xmin ) / rdx ) ! nbins should be less than 100000
            do i = 0,nbins
               x(i) = xmin +rdx*i
            enddo