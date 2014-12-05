C -*- fortran -*-
C This part makes bins in x-axis, where x = sqrt{E_vis}.
C E_vis = E_nu -0.8 [MeV]
C Emin: minimum energy of a incoming neutrino
C Emax: maximum energy of a incoming neutrino
C rdx: bin width set by binsize*
            xmin = dsqrt(Emin-0.8d0)
            xmax = dsqrt(Emax-0.8d0)
            nbins = int( ( xmax -xmin ) / rdx ) ! nbins should be less than 100000
            do i = 0,nbins
               x(i) = xmin +rdx*i
            enddo
