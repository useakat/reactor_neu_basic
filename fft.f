      program neu_event
      implicitnone

      real*8 res
      parameter (res=3) ! in % @E=4MeV
      integer i,j,k,ndiv,mdiv
      parameter (mdiv=10000)
      integer*8 plan1,FFTW_ESTIMATE,plan2
      real*8 Emin,Emax,event21(10000),event0_nor(10000),L,E,El,vol,prob2
      real*8 event0_inv(10000),no_osc(10000)
      real*8 loemin,loemax,loe,omega,F_nor(0:3),F_inv(0:3),FST_nor(0:3)
      real*8 FST_inv(0:3),FCT_nor(0:3),FCT_inv(0:3),omega_min,omega_max
      real*8 factor,dm2_min,dm2_max,dm2,dm21_2,dm32_2,dm31_2

      real*8 flux,xsec,prob_ee,flux_norm,xsec_norm,Elmax,Elmin,scale
      external flux,xsec,prob_ee

      L = 10d0
      Emin = 2d0 ! Mev unit Emin > 1.30
      Emax = 12d0
      factor = 1d41
      dm2_min = 2.0d-3
      dm2_max = 3.0d-3 

      ndiv = int((Emax -Emin)/(Emax*Emin)*4/res*100)
      write(*,*) "res=",res," %"," N=",ndiv
      loemin = L/Emax
      loemax = L/Emin

      open(10,file="fst_nor.dat",status="replace")
      open(11,file="fct_nor.dat",status="replace")
      open(12,file="fst_inv.dat",status="replace")
      open(13,file="fct_inv.dat",status="replace")
      do j = 1,mdiv
         dm2 = dm2_min +(dm2_max -dm2_min)/dble(mdiv)*(j-1)
         omega = 2.53387d3*dm2
         do i = 1,3
            FST_nor(i) = 0d0
            FCT_nor(i) = 0d0
            FST_inv(i) = 0d0
            FCT_inv(i) = 0d0
         enddo
         do i = 1,ndiv
            loe = loemin +(loemax -loemin)/dble(ndiv)*(i-1)
            E = L/loe
            F_nor(1) = flux(E)*xsec(E)*prob_ee(loe,1,31)*factor
            F_nor(2) = flux(E)*xsec(E)*prob_ee(loe,1,32)*factor
            F_nor(3) = flux(E)*xsec(E)*prob_ee(loe,1,21)*factor
            F_inv(1) = flux(E)*xsec(E)*prob_ee(loe,-1,31)*factor
            F_inv(2) = flux(E)*xsec(E)*prob_ee(loe,-1,32)*factor
            F_inv(3) = flux(E)*xsec(E)*prob_ee(loe,-1,21)*factor
            do k = 1,3
               FST_nor(k) = FST_nor(k) +F_nor(k)*dsin(omega*loe)
     &              *(loemax -loemin)/dble(ndiv)
               FCT_nor(k) = FCT_nor(k) +F_nor(k)*dcos(omega*loe)
     &           *(loemax -loemin)/dble(ndiv)
               FST_inv(k) = FST_inv(k) +F_inv(k)*dsin(omega*loe)
     &              *(loemax -loemin)/dble(ndiv)
               FCT_inv(k) = FCT_inv(k) +F_inv(k)*dcos(omega*loe)
     &           *(loemax -loemin)/dble(ndiv)
            enddo
         enddo
         FST_nor(0) = FST_nor(1) +FST_nor(2) +FST_nor(3)
         FCT_nor(0) = FCT_nor(1) +FCT_nor(2) +FCT_nor(3)
         FST_inv(0) = FST_inv(1) +FST_inv(2) +FST_inv(3)
         FCT_inv(0) = FCT_inv(1) +FCT_inv(2) +FCT_inv(3)
         write(10,*) dm2,FST_nor(0),FST_nor(1),FST_nor(2),FST_nor(3)
         write(11,*) dm2,FCT_nor(0),FCT_nor(1),FCT_nor(2),FCT_nor(3)
         write(12,*) dm2,FST_inv(0),FST_inv(1),FST_inv(2),FST_inv(3)
         write(13,*) dm2,FCT_inv(0),FCT_inv(1),FCT_inv(2),FCT_inv(3)
      enddo
      close(10)
      close(11)
      close(12)
      close(13)

      end
