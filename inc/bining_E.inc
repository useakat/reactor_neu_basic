C -*- fortran -*-
         xmin = Emin
         xmax = Emax
         nbins = nnbins
         rdbin = ( xmax -xmin ) / dble(nbins)
         do i = 0,nbins
            x(i) = xmin +rdbin*i
         enddo
