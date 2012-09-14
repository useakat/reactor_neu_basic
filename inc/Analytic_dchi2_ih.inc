C -*- fortran -*-
         z_dat(10) = 20
         include 'bining_value.inc'  ! bining by value

         z_dat(6) = -1
         z_min(6) = 1
         open(1,file="adchi2_fit2ih.dat",status="replace")
         rint_adchi2 = 0d0
         do i = 0,nbins-1
            radchi2 = adchi2(hfunc1D,x(i),5,z_min,z_dat,error)
            write(1,*) x(i),radchi2,x(i+1)-x(i)
            rint_adchi2 = rint_adchi2 +radchi2*( x(i+1) -x(i) ) 
         enddo
         close(1)

         open(1,file="int_adchi2_fit2ih.dat",status="replace")
         write(1,*) rint_adchi2
         close(1)