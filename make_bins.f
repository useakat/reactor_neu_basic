      subroutine make_bins_sqrtE(Emin,Emax,dx,x,nbins)
C     This subroutine makes bins in x-axis, where x = sqrt{E_vis},
C     E_vis = E_nu -0.8 [MeV].
C     Emin: Minimum energy of a incoming neutrino
C     Emax: Maximum energy of a incoming neutrino
C     dx: Bin width set by binsize in run.sh
      implicitnone
c     arguments
      real*8 Emin,Emax,dx
      integer nbins
      real*8 x(100000)
c     local variables
      integer i
      real*8 xmin,xmax
      xmin = dsqrt(Emin-0.8d0)
      xmax = dsqrt(Emax-0.8d0)
      nbins = int( ( xmax -xmin ) / dx ) ! nbins should be less than 100000
      do i = 0,nbins
         x(i) = xmin +dx*i
      enddo
      
      return
      end
