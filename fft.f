      program neu_event
      implicitnone

      real*8 res
      character*5 rres,cL
c      parameter (res=10) ! in % @E=4MeV
      integer i,j,k,ll,ndiv,mdiv
      parameter (mdiv=10000)
      integer*8 plan1,FFTW_ESTIMATE,plan2
      real*8 Emin,Emax,event21(10000),event0_nor(10000),L,E,El,vol,prob2
      real*8 event0_inv(10000),no_osc(10000)
      real*8 loemin,loemax,loe,omega,F_nor(-1:1,0:3),F_inv(-1:1,0:3)
      real*8 FST_nor(-1:1,0:3)
      real*8 FST_inv(-1:1,0:3),FCT_nor(-1:1,0:3),FCT_inv(-1:1,0:3)
      real*8 omega_min,omega_max
      real*8 factor,dm2_min,dm2_max,dm2,dm21_2,dm32_2,dm31_2

      real*8 flux,xsec,prob_ee,flux_norm,xsec_norm,Elmax,Elmin,scale
      external flux,xsec,prob_ee

      call getarg(1,rres)
      read(rres,*) res
      call getarg(2,cL)
      read(cL,*) L

      Emin = 1.81d0 ! Mev unit Emin > 1.81
      Emax = 10d0
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
      open(14,file="fst_nor_uncp.dat",status="replace")
      open(15,file="fct_nor_uncp.dat",status="replace")
      open(16,file="fst_inv_uncp.dat",status="replace")
      open(17,file="fct_inv_uncp.dat",status="replace")
      open(18,file="fst_nor_uncm.dat",status="replace")
      open(19,file="fct_nor_uncm.dat",status="replace")
      open(20,file="fst_inv_uncm.dat",status="replace")
      open(21,file="fct_inv_uncm.dat",status="replace")
      do j = 1,mdiv
         dm2 = dm2_min +(dm2_max -dm2_min)/dble(mdiv)*(j-1)
         omega = 2.53387d3*dm2
         do i = 1,3
            do ll = -1,1
               FST_nor(ll,i) = 0d0
               FCT_nor(ll,i) = 0d0
               FST_inv(ll,i) = 0d0
               FCT_inv(ll,i) = 0d0
            enddo
         enddo
         do ll = -1,1
            do i = 1,ndiv
               loe = loemin +(loemax -loemin)/dble(ndiv)*(i-1)
               E = L/loe
               F_nor(ll,1) = flux(E)*xsec(E)*prob_ee(loe,1,31,ll)*factor
               F_nor(ll,2) = flux(E)*xsec(E)*prob_ee(loe,1,32,ll)*factor
               F_nor(ll,3) = flux(E)*xsec(E)*prob_ee(loe,1,21,ll)*factor
               F_inv(ll,1) = flux(E)*xsec(E)*prob_ee(loe,-1,31,ll)*factor
               F_inv(ll,2) = flux(E)*xsec(E)*prob_ee(loe,-1,32,ll)*factor
               F_inv(ll,3) = flux(E)*xsec(E)*prob_ee(loe,-1,21,ll)*factor
              do k = 1,3
                  FST_nor(ll,k) = FST_nor(ll,k) +F_nor(ll,k)
     &                 *dsin(omega*loe)*(loemax -loemin)/dble(ndiv)
                  FCT_nor(ll,k) = FCT_nor(ll,k) +F_nor(ll,k)
     &                 *dcos(omega*loe)*(loemax -loemin)/dble(ndiv)
                  FST_inv(ll,k) = FST_inv(ll,k) +F_inv(ll,k)
     &                 *dsin(omega*loe)*(loemax -loemin)/dble(ndiv)
                  FCT_inv(ll,k) = FCT_inv(ll,k) +F_inv(ll,k)
     &                 *dsin(omega*loe)*(loemax -loemin)/dble(ndiv)
              enddo
            enddo
            FST_nor(ll,0) = FST_nor(ll,1) +FST_nor(ll,2) +FST_nor(ll,3)
            FCT_nor(ll,0) = FCT_nor(ll,1) +FCT_nor(ll,2) +FCT_nor(ll,3)
            FST_inv(ll,0) = FST_inv(ll,1) +FST_inv(ll,2) +FST_inv(ll,3)
            FCT_inv(ll,0) = FCT_inv(ll,1) +FCT_inv(ll,2) +FCT_inv(ll,3)
         enddo
         write(10,*) dm2,FST_nor(0,0),FST_nor(0,1),FST_nor(0,2),FST_nor(0,3)
         write(11,*) dm2,FCT_nor(0,0),FCT_nor(0,1),FCT_nor(0,2),FCT_nor(0,3)
         write(12,*) dm2,FST_inv(0,0),FST_inv(0,1),FST_inv(0,2),FST_inv(0,3)
         write(13,*) dm2,FCT_inv(0,0),FCT_inv(0,1),FCT_inv(0,2),FCT_inv(0,3)
         write(14,*) dm2,FST_nor(1,0),FST_nor(1,1),FST_nor(1,2),FST_nor(1,3)
         write(15,*) dm2,FCT_nor(1,0),FCT_nor(1,1),FCT_nor(1,2),FCT_nor(1,3)
         write(16,*) dm2,FST_inv(1,0),FST_inv(1,1),FST_inv(1,2),FST_inv(1,3)
         write(17,*) dm2,FCT_inv(1,0),FCT_inv(1,1),FCT_inv(1,2),FCT_inv(1,3)
         write(18,*) dm2,FST_nor(-1,0),FST_nor(-1,1),FST_nor(-1,2),FST_nor(-1,3)
         write(19,*) dm2,FCT_nor(-1,0),FCT_nor(-1,1),FCT_nor(-1,2),FCT_nor(-1,3)
         write(20,*) dm2,FST_inv(-1,0),FST_inv(-1,1),FST_inv(-1,2),FST_inv(-1,3)
         write(21,*) dm2,FCT_inv(-1,0),FCT_inv(-1,1),FCT_inv(-1,2),FCT_inv(-1,3)
      enddo
      do i = 10,21
         close(i)
      enddo

      end
