      program neu_event
      implicitnone

      integer i,ndiv,sign,mode
      parameter (ndiv=1000)
      integer*8 plan1,FFTW_ESTIMATE,plan2
      real*8 Emin,Emax,event21(ndiv),event0_nor(ndiv),L,E,El,vol,prob2
      real*8 event0_inv(ndiv),no_osc(ndiv)
      real*8 loemin,loemax,loe,omega
      complex*16 event0_nor_out(ndiv/2+1),event0_inv_out(ndiv/2+1)

      real*8 flux,xsec,prob_ee,flux_norm,xsec_norm,Elmax,Elmin,scale
      external flux,xsec,prob_ee

c      E = 6d0
      L = 60d0

      open(10,file="events_loe.dat",status="replace")
      open(16,file="events_e.dat",status="replace")
      open(11,file="prob.dat",status="replace")
      open(12,file="prob2.dat",status="replace")
      open(13,file="fig1.dat",status="replace")
      open(14,file="events2.dat",status="replace")
      open(15,file="events3.dat",status="replace")
      open(16,file="events.dat",status="replace")
      open(17,file="flux.dat",status="replace")
      open(18,file="xsec.dat",status="replace")

      do i = 1,ndiv
         loemin = L/9d0
         loemax = L/1d0
         loe = loemin +(loemax -loemin)/dble(ndiv)*(i-1)
         E = L/loe
c         L = loe*E
         event21(i) = flux(E)*xsec(E)*prob_ee(loe,1,21,0)
         event0_nor(i) = flux(E)*xsec(E)*prob_ee(loe,1,0,0)
         event0_inv(i) = flux(E)*xsec(E)*prob_ee(loe,-1,0,0)
c         event21(i) = prob_ee(loe,1,21)
c         event0_nor(i) = prob_ee(loe,1,0)
c         event0_inv(i) = prob_ee(loe,-1,0)
         no_osc(i) = flux(E)*xsec(E)
         prob2 = 1d0 -prob_ee(loe,-1,0,0)/prob_ee(loe,1,0,0)
         write(10,*) loe,event21(i),event0_nor(i),event0_inv(i)
         write(16,*) E,event21(i),event0_nor(i),event0_inv(i)
         write(11,*) E,prob_ee(loe,1,0,0),prob_ee(loe,-1,0,0)
         write(12,*) E,prob2
         write(13,*) loe,prob_ee(loe,1,21,0),prob_ee(loe,1,0,0),prob_ee(loe,-1,0,0)
         write(14,*) loe,no_osc(i)
         write(15,*) E,no_osc(i)
         write(17,*) E,flux(E)
         write(18,*) E,xsec(E)
      enddo
      close(10)
      close(11)
      close(12)
      close(13)
      close(14)
      close(15)
      close(16)
      close(17)
      close(18)

      end
