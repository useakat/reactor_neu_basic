      program neu_event
      implicitnone

      integer i,ndiv
      parameter (ndiv=1000)
      real*8 Emin,Emax,L,E,no_osc,prob_nor,prob_inv
      real*8 events_nor,events_inv,diff
      real*8 loemin,loemax,loe

      real*8 flux,xsec,prob_ee
      external flux,xsec,prob_ee

      L = 60d0
      Emin = 1.81d0
      Emax = 9d0

      open(10,file="flux.dat",status="replace")
      open(11,file="xsec.dat",status="replace")
      open(12,file="prob.dat",status="replace")
      open(13,file="events.dat",status="replace")
      open(14,file="flux_loe.dat",status="replace")
      open(15,file="xsec_loe.dat",status="replace")
      open(16,file="prob_loe.dat",status="replace")
      open(17,file="events_loe.dat",status="replace")

      do i = 1,ndiv
         loemin = L/Emax
         loemax = L/Emin
         loe = loemin +(loemax -loemin)/dble(ndiv)*(i-1)
         E = L/loe
         no_osc = flux(E)*xsec(E)
         prob_nor = prob_ee(loe,1,0,0)
         prob_inv = prob_ee(loe,-1,0,0)
         events_nor = no_osc*prob_nor
         events_inv = no_osc*prob_inv
         diff = 1d0 -prob_inv/prob_nor
         write(10,*) E,flux(E)
         write(11,*) E,xsec(E)
         write(12,*) E,prob_nor,prob_inv,diff
         write(13,*) E,no_osc,events_nor,events_inv,diff
         write(14,*) loe,flux(E)
         write(15,*) loe,xsec(E)
         write(16,*) loe,prob_nor,prob_inv,diff
         write(17,*) loe,no_osc,events_nor,events_inv,diff
      enddo

      close(10)
      close(11)
      close(12)
      close(13)
      close(14)
      close(15)
      close(16)
      close(17)

      end
